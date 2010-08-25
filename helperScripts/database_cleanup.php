
<?php

$archive_path = "/home/{$_ENV['USER']}/FeedFetcherDeluxe/archive/";

$conn = mysql_connect('localhost', 'root', $argv[1]);
mysql_select_db("sportboo_testdev);


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

echo "ROWS DELETED = " . $i . "\n";
echo "Time deleted from: " . $str_time . "\n";

mysql_close($conn);



?>


