
#Pitchers
UPDATE positions SET abbreviation = 'P' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 1 OR abbreviation = '1');

#Catchers
UPDATE positions SET abbreviation = 'C' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 2 OR abbreviation = '2');

#first base
UPDATE positions SET abbreviation = '1B' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 3 OR abbreviation = '3');

#Second base
UPDATE positions SET abbreviation = '2B' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 4 OR abbreviation = '4');

#Short stop
UPDATE positions SET abbreviation = 'SS' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 6 OR abbreviation = '6');

#Third base
UPDATE positions SET abbreviation = '3B' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 5 OR abbreviation = '5');

#left field
UPDATE positions SET abbreviation = 'LF' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 7 OR abbreviation = '7');

#center field
UPDATE positions SET abbreviation = 'CF' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 8 OR abbreviation = '8');

#right field
UPDATE positions SET abbreviation = 'RF' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 9 OR abbreviation = '9');

#designated hitter
UPDATE positions SET abbreviation = 'DH' WHERE affiliation_id IN (SELECT affiliations.id FROM affiliations INNER JOIN display_names AS dn ON dn.entity_id = affiliations.id AND dn.entity_type = 'affiliations' WHERE dn.full_name = 'Baseball') AND (abbreviation = 'dh');
