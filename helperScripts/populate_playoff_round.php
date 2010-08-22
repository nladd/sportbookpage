<?php

$conn = mysql_connect('localhost', 'root', '');
mysql_select_db("sportboo_testdev");

#get pro leagues
$qry = "SELECT affiliations.id AS affiliation_id, affiliations.affiliation_key AS affiliation_key, affiliations.publisher_id, display_names.* FROM `display_names` INNER JOIN affiliations ON display_names.entity_id = affiliations.id AND affiliations.publisher_id = 1 WHERE (`display_names`.`full_name` IN ('National Basketball Association','National Hockey League','National Football League','Major League Baseball')) ORDER BY display_names.abbreviation ASC";

$leagues = mysql_query($qry);

while ($league = mysql_fetch_array($leagues)) {
    
    #get the season
    $date = getdate();
    $season_key = $date["year"];
    
    $qry = "SELECT * FROM seasons WHERE season_key = {$season_key} AND league_id = {$league['affiliation_id']}";
    $result = mysql_query($qry);
    
    $i = 0;
    $season = null;
    while (($season = mysql_fetch_array($result)) == false) {
        $season_key--;
        $qry = "SELECT * FROM seasons WHERE season_key = {$season_key} AND league_id = {$league['affiliation_id']}";
        $result = mysql_query($qry);
     	$i++;
	if ($i > 10) {
		break;
	}
    }
   
   if ($i == 11) { continue; } 
        
    #get all teams that made playoffs
    $qry = "SELECT t1.participant_id AS team_id FROM events_sub_seasons INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id INNER JOIN events ON events.id = events_sub_seasons.event_id INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home' WHERE sub_seasons.season_id = {$season['id']} AND sub_seasons.sub_season_type = 'post-season' GROUP BY t1.participant_id";
    
    $teams = mysql_query($qry);
    
    while ($team = mysql_fetch_array($teams)) {
        #for each team, get the opponents faced during playoffs, return the first opponent first
        $qry = "SELECT t1.participant_id AS t1_id, t2.participant_id AS t2_id, MIN(events.start_date_time), d1.full_name, d2.full_name  FROM events_sub_seasons INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id INNER JOIN events ON events.id = events_sub_seasons.event_id INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams' INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams'INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams' WHERE sub_seasons.season_id = {$season['id']} AND sub_seasons.sub_season_type = 'post-season' AND t1.participant_id = {$team['team_id']} GROUP BY t2.participant_id ORDER BY events.start_date_time ASC";
        
        $opponents = mysql_query($qry);
        $round = 1;
        
        while ($opponent = mysql_fetch_array($opponents)) {
        
            #for each different opponent, set the playoff round number
            $qry = "SELECT t1.participant_id, d1.full_name AS d1_full_name, t2.participant_id, d2.full_name AS d2_full_name, events.start_date_time, events.id AS event_id FROM events_sub_seasons INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id INNER JOIN events ON events.id = events_sub_seasons.event_id INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home' INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams' INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams' INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams' WHERE sub_seasons.season_id = {$season['id']} AND sub_seasons.sub_season_type = 'post-season' AND (t1.participant_id = {$team['team_id']} AND t2.participant_id = {$opponent['t2_id']}) ORDER BY events.start_date_time";
            
            
            
            $events = mysql_query($qry);
            
            while ($event = mysql_fetch_array($events)) {
                $qry = "UPDATE events SET playoff_round = {$round} WHERE id = {$event['event_id']} AND playoff_round IS NULL";
                mysql_query($qry);
            }
            
            $round++;
        } # close opponents loop

    

    } # close teams loop

} #close leagues loop

mysql_close($conn);

?>
