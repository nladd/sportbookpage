
<?php

$archive_path = "/home/{$_ENV['USER']}/FeedFetcherDeluxe/archive/";

$conn = mysql_connect('localhost', 'root', $argv[1]);
mysql_select_db("sportboo_testdev");


$time = time() - (45 * 24 * 60 * 60); #subtract 45 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT stats.id FROM events INNER JOIN stats ON stats.stat_coverage_id = events.id AND stats.stat_coverage_type = 'events' WHERE events.start_date_time < '{$str_time}'";


$result = mysql_query($query);

$i = 0;

while($row = mysql_fetch_array($result))
{
	$query = "DELETE FROM stats WHERE id = {$row['id']}";
	mysql_query($query);
	
	$i += mysql_affected_rows();
}


$query = "SELECT pe.id FROM events INNER JOIN participants_events AS pe ON pe.event_id = events.id AND pe.participant_type = 'persons' INNER JOIN person_phases AS pp ON pp.person_id = pe.participant_id WHERE events.start_date_time < '{$str_time}' AND pp.membership_type = 'teams'";


$result = mysql_query($query);


while($row = mysql_fetch_array($result))
{
        $query = "DELETE FROM participants_events WHERE id = {$row['id']}";
        mysql_query($query);

        $i += mysql_affected_rows();
}



$query = "DELETE FROM wagering_moneylines WHERE date_time < '" . $str_time . "'";
mysql_query($query);
$i += mysql_affected_rows();

$query = "DELETE FROM wagering_total_score_lines WHERE date_time < '" . $str_time . "'";
mysql_query($query);
$i += mysql_affected_rows();

$query = "DELETE FROM wagering_runlines WHERE date_time < '" . $str_time . "'";
mysql_query($query);
$i += mysql_affected_rows();

$query = "DELETE FROM wagering_odds_lines WHERE date_time < '" . $str_time . "'";
mysql_query($query);
$i += mysql_affected_rows();

$query = "DELETE FROM wagering_straight_spread_lines WHERE date_time < '" . $str_time . "'";
mysql_query($query);
$i += mysql_affected_rows();


$time = time() - (60 * 24 * 60 * 60); #subtract 60 days
$str_time = date ("Y-m-d H:i:s", $time);

$qry = "SELECT * FROM documents WHERE date_time <= '{$str_time}'";
$result = mysql_query($qry);

while ($row = mysql_fetch_array($result)) {

	############# CLEAN UP THE documents_contents TABLE #########################
	$qry = "SELECT * FROM document_contents WHERE document_id = {$row['id']}";
	$dc_result = mysql_query($qry);
	while ($dc_row = mysql_fetch_array($dc_result)){
		$qry = "INSERT INTO document_contents_archive SELECT * FROM document_contents WHERE id = {$dc_row['id']}";
		mysql_query($qry);
		$qry = "DELETE FROM document_contents WHERE id = {$dc_row['id']}";
        	mysql_query($qry);
	        $i += mysql_affected_rows();
	}

	############# CLEAN UP THE events_documents TABLE #########################
        $qry = "SELECT * FROM events_documents WHERE document_id = {$row['id']}";
        $e_result = mysql_query($qry);
        while ($e_row = mysql_fetch_array($e_result)){
                $qry = "INSERT INTO events_documents_archive SELECT * FROM events_documents WHERE document_id = {$e_row['document_id']} AND event_id = {$e_row['event_id']}";
                mysql_query($qry);
                $qry = "DELETE FROM events_documents WHERE document_id = {$e_row['document_id']} AND event_id = {$e_row['event_id']}";
                mysql_query($qry);
                $i += mysql_affected_rows();
        }

	############# CLEAN UP THE affiliations_documents TABLE #########################
        $qry = "SELECT * FROM affiliations_documents WHERE document_id = {$row['id']}";
        $a_result = mysql_query($qry);
        while ($a_row = mysql_fetch_array($a_result)){
                $qry = "INSERT INTO affiliations_documents_archive SELECT * FROM affiliations_documents WHERE document_id = {$a_row['document_id']} AND affiliation_id = {$a_row['affiliation_id']}";
                mysql_query($qry);
                $qry = "DELETE FROM affiliations_documents WHERE document_id = {$a_row['document_id']} AND affiliation_id = {$a_row['affiliation_id']}";
                mysql_query($qry);
                $i += mysql_affected_rows();
        }

	############# CLEAN UP THE team_documents TABLE #########################
        $qry = "SELECT * FROM teams_documents WHERE document_id = {$row['id']}";
        $t_result = mysql_query($qry);
        while ($t_row = mysql_fetch_array($t_result)){
                $qry = "INSERT INTO teams_documents_archive SELECT * FROM teams_documents WHERE document_id = {$t_row['document_id']} AND team_id = {$t_row['team_id']}";
                mysql_query($qry);
                $qry = "DELETE FROM teams_documents WHERE document_id = {$t_row['document_id']} AND team_id = {$t_row['team_id']}";
                mysql_query($qry);
                $i += mysql_affected_rows();
        }

	############# CLEAN UP THE persons_documents TABLE #########################
        $qry = "SELECT * FROM persons_documents WHERE document_id = {$row['id']}";
        $p_result = mysql_query($qry);
        while ($p_row = mysql_fetch_array($p_result)){
                $qry = "INSERT INTO persons_documents_archive SELECT * FROM persons_documents WHERE document_id = {$p_row['document_id']} AND person_id = {$p_row['person_id']}";
                mysql_query($qry);
                $qry = "DELETE FROM persons_documents WHERE document_id = {$p_row['document_id']} AND person_id = {$p_row['person_id']}";
                mysql_query($qry);
                $i += mysql_affected_rows();
        }

	############# CLEAN UP THE latest_revisions TABLE #########################
        $qry = "SELECT * FROM latest_revisions WHERE latest_document_id = {$row['id']}";
        $lr_result = mysql_query($qry);
        while ($lr_row = mysql_fetch_array($lr_result)){
                $qry = "INSERT INTO latest_revisions_archive SELECT * FROM latest_revisions WHERE id = {$lr_row['id']}";
                mysql_query($qry);
                $qry = "DELETE FROM affiliations_documents WHERE id = {$lr_row['id']}";
                mysql_query($qry);
                $i += mysql_affected_rows();
        }


	############# CLEAN UP THE documents TABLE ################################
	$qry = "INSERT INTO documents_archive SELECT * FROM documents WHERE id={$row['id']}";
	mysql_query($qry);
	$qry = "DELETE FROM documents WHERE id = {$row['id']}";
	mysql_query($qry);
	$i += mysql_affected_rows();
}




echo "ROWS DELETED = " . $i . "\n";
mysql_close($conn);



?>


