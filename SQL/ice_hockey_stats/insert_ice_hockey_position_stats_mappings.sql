DROP PROCEDURE IF EXISTS nested_loop;    
DROP PROCEDURE IF EXISTS ice_hockey_stats;
    
DELIMITER //
    
    
CREATE PROCEDURE nested_loop(IN param INT)
BEGIN
        
    DECLARE done2 INT DEFAULT 0;
    DECLARE stat VARCHAR(255);
    DECLARE cur2 CURSOR FOR SELECT stats_name FROM stats_mappings WHERE stats_type="ice_hockey_defensive_stat" OR stats_type = "ice_hockey_offensive_stat";
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = 1;
    
    OPEN cur2;
    
    loops: LOOP
        FETCH cur2 INTO stat;
    
        IF done2 THEN
            LEAVE loops;
        END IF;
    
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id) VALUES (param, stat);
    
    
    
    END LOOP;
    
    CLOSE cur2;
    
END // 
    
CREATE PROCEDURE ice_hockey_stats()
BEGIN
    
    DECLARE done INT DEFAULT 0;
    DECLARE p_id INT;
    DECLARE cur1 CURSOR FOR SELECT positions.id FROM positions INNER JOIN affiliations AS a ON a.id = positions.affiliation_id INNER JOIN display_names AS dn ON dn.entity_id = a.id AND dn.entity_type = "affiliations" AND dn.full_name = "Ice Hockey" WHERE positions.abbreviation = "defenseman" OR positions.abbreviation = "center" OR positions.abbreviation = "right-forward" OR positions.abbreviation = "left-forward" OR positions.abbreviation = "C";
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    loop_label: LOOP
        FETCH cur1 INTO p_id;
        IF done THEN
            LEAVE loop_label;
        END IF;
    
        CALL nested_loop(p_id);
    END LOOP;

    CLOSE cur1;

END //

DELIMITER ;

CALL ice_hockey_stats();
    
DELIMITER //
    
    
CREATE PROCEDURE ice_hockey_goalie_stats()
BEGIN
    
    DECLARE done INT DEFAULT 0;
    DECLARE p_id INT;
    DECLARE cur1 CURSOR FOR SELECT positions.id FROM positions INNER JOIN affiliations AS a ON a.id = positions.affiliation_id INNER JOIN display_names AS dn ON dn.entity_id = a.id AND dn.entity_type = "affiliations" AND dn.full_name = "Ice Hockey" WHERE positions.abbreviation = "goalie" OR positions.abbreviation = "G";
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    loop_label: LOOP
        FETCH cur1 INTO p_id;
        IF done THEN
            LEAVE loop_label;
        END IF;
    
        CALL nested_loop(p_id);
    
    END LOOP;

    CLOSE cur1;

END //

DELIMITER ;

CALL ice_hockey_goalie_stats();