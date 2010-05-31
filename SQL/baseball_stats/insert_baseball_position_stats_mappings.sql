
DROP PROCEDURE IF EXISTS pitching_stats;

DELIMITER //

CREATE PROCEDURE pitching_stats()
BEGIN
    
    DECLARE done INT DEFAULT 0;
    DECLARE p_id INT;
    DECLARE cur1 CURSOR FOR SELECT id FROM positions WHERE abbreviation = 'P';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    loop_label: LOOP
        FETCH cur1 INTO p_id;
        IF done THEN
            LEAVE loop_label;
        END IF;
        
           
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Runs allowed'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Singles allowed'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Doubles allowed'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Triples allowed'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Home runs allowed'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Innings pitched'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Hits'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Earned runs'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Bases on balls'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Strikeouts'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Pitches thrown'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Earned runs against'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Pick offs'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Wins'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Losses'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Saves'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Shutouts'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Complete games'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Finished games'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_pitching_stat" AND stats_name = 'Winning percentage'));
    
    END LOOP;

    CLOSE cur1;

END //

DELIMITER ;

CALL pitching_stats();


DROP PROCEDURE IF EXISTS baseball_stats;

DELIMITER //

CREATE PROCEDURE baseball_stats()
BEGIN
    
    DECLARE done INT DEFAULT 0;
    DECLARE p_id INT;
    DECLARE cur1 CURSOR FOR SELECT id FROM positions WHERE abbreviation = 'C' OR abbreviation = '1B' OR abbreviation = '2B' OR abbreviation = '3B' OR abbreviation = 'SS' OR abbreviation = 'LF' OR abbreviation = 'CF' OR abbreviation = 'RF' OR abbreviation = 'DH';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    loop_label: LOOP
        FETCH cur1 INTO p_id;
        IF done THEN
            LEAVE loop_label;
        END IF;
        
           
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Errors'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Average'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Runs scored'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'At bats'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Hits'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Runs batted in'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Total bases'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Slugging percentage'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Bases on balls'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Strikeouts'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Runs scored'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Singles'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Doubles'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Triples'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Home runs'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Grand slams'));
        INSERT INTO position_stats_mappings (position_id, stats_mapping_id)  VALUES (p_id, (SELECT id FROM stats_mappings WHERE stats_type = "baseball_stat" AND stats_name = 'Stolen bases'));
    
    END LOOP;

    CLOSE cur1;

END //

DELIMITER ;

CALL baseball_stats();
