

<?php


$conn = mysql_connect('localhost', 'root', '');
mysql_select_db("sportboo_testdev");

###################################
# Compute missing stats for the basketball_offensive_stats table
#
###################################
$table = "basketball_offensive_stats";
$qry = "SELECT * FROM {$table}";
$result = mysql_query($qry);

echo $qry;

while($row = mysql_fetch_array($result))
{

	$qry = "SELECT core_stats.events_played FROM {$table} INNER JOIN stats ON stats.stat_repository_id = {$table}.id AND stats.stat_repository_type = '{$table}' 
		INNER JOIN stats AS c_stats ON c_stats.stat_holder_type = stats.stat_holder_type AND c_stats.stat_holder_id = stats.stat_holder_id AND c_stats.stat_coverage_type = stats.stat_coverage_type AND c_stats.stat_coverage_id = stats.stat_coverage_id AND c_stats.stat_membership_type = stats.stat_membership_type AND  c_stats.stat_membership_id = stats.stat_membership_id AND c_stats.stat_repository_type = 'core_stats'
	INNER JOIN core_stats ON core_stats.id = c_stats.stat_repository_id
	WHERE {$table}.id = {$row['id']}";


	$core_stats = mysql_query($qry);
	

	$events_played = mysql_result($core_stats, 0, 0);
	$qry = "UPDATE {$table} SET ";

  try {
    $attribute = 'field_goals_per_game';
	  if ($row[$attribute] == NULL) {
		  $value = round( ($row['field_goals_made'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
	  }
    $attribute = 'field_goals_attempted_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['field_goals_attempted'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
    $attribute = 'three_pointers_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['three_pointers_made'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
    $attribute = 'three_pointers_attempted_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['three_pointers_attempted'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
    $attribute = 'free_throws_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['free_throws_made'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
    $attribute = 'free_throws_attempted_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['free_throws_attempted'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
  } catch (Exception $e) {
    print "Exception caught!";
  }

  $qry = substr($qry, 0, strlen($qry) - 2);
	$qry .= " WHERE id = {$row['id']}";

	mysql_query($qry);
	

}



###############################################################################
# Compute missing stats for the baskball_rebounding_stats table
#
###############################################################################
$table = "basketball_rebounding_stats";
$qry = "SELECT * FROM ${table}";
$result = mysql_query($qry);

while($row = mysql_fetch_array($result))
{

	$qry = "SELECT core_stats.events_played FROM {$table} INNER JOIN stats ON stats.stat_repository_id = {$table}.id AND stats.stat_repository_type = '{$table}' 
		INNER JOIN stats AS c_stats ON c_stats.stat_holder_type = stats.stat_holder_type AND c_stats.stat_holder_id = stats.stat_holder_id AND c_stats.stat_coverage_type = stats.stat_coverage_type AND c_stats.stat_coverage_id = stats.stat_coverage_id AND c_stats.stat_membership_type = stats.stat_membership_type AND  c_stats.stat_membership_id = stats.stat_membership_id AND c_stats.stat_repository_type = 'core_stats'
	INNER JOIN core_stats ON core_stats.id = c_stats.stat_repository_id
	WHERE {$table}.id = {$row['id']}";


	$core_stats = mysql_query($qry);
	

	$events_played = mysql_result($core_stats, 0, 0);
	$qry = "UPDATE ${table} SET ";

  try {
    $attribute = 'rebounds_per_game';
    if ($row[$attribute] == NULL) {
		  $value = round( ($row['rebounds_total'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
	  }
    $attribute = 'rebounds_offensive_per_game';
	  if ($row[$attribute] == NULL) {
		  $value = round( ($row['rebounds_offensive'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
	  }
    $attribute = 'rebounds_defensive_per_game';
	  if ($row[$attribute] == NULL) {
      $value = round( ($row['rebounds_defensive'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
    }
  } catch (Exception $e) {
    print "Exception caught!";
  }


  $qry = substr($qry, 0, strlen($qry) - 2);
	$qry .= " WHERE id = {$row['id']}";

	mysql_query($qry);
	

}


###############################################################################
# Compute missing stats for the baskball_defensive_stats table
#
###############################################################################
$table = "basketball_defensive_stats";
$qry = "SELECT * FROM ${table}";
$result = mysql_query($qry);

while($row = mysql_fetch_array($result))
{

	$qry = "SELECT core_stats.events_played FROM {$table} INNER JOIN stats ON stats.stat_repository_id = {$table}.id AND stats.stat_repository_type = '{$table}' 
		INNER JOIN stats AS c_stats ON c_stats.stat_holder_type = stats.stat_holder_type AND c_stats.stat_holder_id = stats.stat_holder_id AND c_stats.stat_coverage_type = stats.stat_coverage_type AND c_stats.stat_coverage_id = stats.stat_coverage_id AND c_stats.stat_membership_type = stats.stat_membership_type AND  c_stats.stat_membership_id = stats.stat_membership_id AND c_stats.stat_repository_type = 'core_stats'
	INNER JOIN core_stats ON core_stats.id = c_stats.stat_repository_id
	WHERE {$table}.id = {$row['id']}";


	$core_stats = mysql_query($qry);
	

	$events_played = mysql_result($core_stats, 0, 0);
	$qry = "UPDATE ${table} SET ";

  try {
    $attribute = 'blocks_per_game';
    if ($row[$attribute] == NULL) {
		  $value = round( ($row['blocks_total'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
	  }
    $attribute = 'steals_per_game';
	  if ($row[$attribute] == NULL) {
		  $value = round( ($row['steals_per_game'] / $events_played), 1);
		  $qry .= "{$attribute} = {$value}, ";
	  }
  } catch (Exception $e) {
    print "Exception caught!";
  }


  $qry = substr($qry, 0, strlen($qry) - 2);
	$qry .= " WHERE id = {$row['id']}";

	mysql_query($qry);
	

}


mysql_close($conn);

?>

