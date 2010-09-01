
<?php

$conn = mysql_connect('localhost', 'root', $argv[1]);
mysql_select_db("sportboo_testdev");


$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.nba.com' AND publisher_id = 1";
$result = mysql_query($qry);
$league_id = mysql_result($result, 0, 0);


$qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
$seasons = mysql_query($qry);

while ($row = mysql_fetch_array($seasons)) {

	$season_key = $row['season_key'];
	$end_year = $season_key+1;

########################### NBA season dates ##################################################
	$qry = "UPDATE seasons SET start_date_time='{$season_key}-10-10 00:00:00', end_date_time='{$end_year}-06-20 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
	mysql_query($qry);

############################# NBA playoff dates ####################################
	$season_id = $row['id'];
	$qry = "UPDATE sub_seasons SET start_date_time='${end_year}-04-17 00:00:00', end_date_time='{$end_year}-06-10 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
	mysql_query($qry);	


}

$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.mlb.com'";
$result = mysql_query($qry);
$league_id = mysql_result($result, 0, 0);


$qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
$seasons = mysql_query($qry);

while ($row = mysql_fetch_array($seasons)) {

########################### MLB season dates ##################################################
        $season_key = $row['season_key'];
        $qry = "UPDATE seasons SET start_date_time='{$season_key}-03-01 00:00:00', end_date_time='{$season_key}-11-01 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
        mysql_query($qry);

############################# MLB playoff dates ###############################
	 $season_id = $row['id'];
        $qry = "UPDATE sub_seasons SET start_date_time='{$season_key}-10-01 00:00:00', end_date_time='{$season_key}-10-01 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
        mysql_query($qry);

}



$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.nfl.com'";
$result = mysql_query($qry);

if(mysql_num_rows($result)) {
	$league_id = mysql_result($result, 0, 0);


	$qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
	$seasons = mysql_query($qry);

	while ($row = mysql_fetch_array($seasons)) {

########################### NFL season dates ##################################################
        	$season_key = $row['season_key'];
		$end_year = $season_key + 1;
        	$qry = "UPDATE seasons SET start_date_time='{$season_key}-08-01 00:00:00', end_date_time='{$end_year}-02-24 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
	        mysql_query($qry);

##################### NFL playoff dates ###############################
		$season_id = $row['id'];
	        $qry = "UPDATE sub_seasons SET start_date_time='${end_year}-01-15 00:00:00' AND end_date_time='{$end_year}-02-10 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
        	mysql_query($qry);

	}
}
$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.nhl.com'";
$result = mysql_query($qry);
$league_id = mysql_result($result, 0, 0);

$qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
$seasons = mysql_query($qry);

while ($row = mysql_fetch_array($seasons)) {

########################### NHL season dates ##################################################
        $season_key = $row['season_key'];
	$end_year = $season_key + 1;
        $qry = "UPDATE seasons SET start_date_time='{$season_key}-09-15 00:00:00', end_date_time='{$end_year}}-06-24 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
        mysql_query($qry);

############################# NHL playoff date #############################
	$season_id = $row['id'];
        $qry = "UPDATE sub_seasons SET start_date_time='${end_year}-04-17 00:00:00', end_date_time='{$end_year}-06-10 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
        mysql_query($qry);

}


$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.ncaa.org.mbasket'";
$result = mysql_query($qry);
if (mysql_num_rows($result)) {
	$league_id = mysql_result($result, 0, 0);

	$qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
	$seasons = mysql_query($qry);

	while ($row = mysql_fetch_array($seasons)) {

########################### NCAA M Basketball season dates ##################################################
        	$season_key = $row['season_key'];
		$end_year = $season_key + 1;
        	$qry = "UPDATE seasons SET start_date_time='{$season_key}-10-15 00:00:00', end_date_time='{$end_year}-04-12 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
	        mysql_query($qry);

##################### NCAA Men's Basketball March madness dates #################################
		$season_id = $row['id'];
	        $qry = "UPDATE sub_seasons SET start_date_time='${end_year}-03-01 00:00:00', end_date_time='{$end_year}-04-01 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
        	mysql_query($qry);

	}
}


$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.ncaa.org.wbasket'";
$result = mysql_query($qry);
if (mysql_num_rows($result)) {
        $league_id = mysql_result($result, 0, 0);

        $qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
        $seasons = mysql_query($qry);

        while ($row = mysql_fetch_array($seasons)) {

########################### NCAA W Basketball season dates ##################################################
                $season_key = $row['season_key'];
                $end_year = $season_key + 1;
                $qry = "UPDATE seasons SET start_date_time='{$season_key}-10-15 00:00:00', end_date_time='{$end_year}-04-12 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
                mysql_query($qry);

##################### NCAA Men's Basketball March madness dates #################################
                $season_id = $row['id'];
                $qry = "UPDATE sub_seasons SET start_date_time='${end_year}-03-01 00:00:00', end_date_time='{$end_year}-04-01 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
                mysql_query($qry);

        }
}


$qry = "SELECT id FROM affiliations WHERE affiliation_key='l.ncaa.org.mfoot' OR affiliation_key='l.ncaa.org.mfoot.div1.aa' OR affiliation_key='l.ncaa.org.mfoot.div2' OR affiliation_key='l.ncaa.org.mfoot.div3'";
$result = mysql_query($qry);

if (mysql_num_rows($result)) {
while($league = mysql_fetch_array($result)) {

        $league_id = $league['id'];

        $qry = "SELECT id, season_key FROM seasons WHERE league_id = {$league_id}";
        $seasons = mysql_query($qry);

echo $qry;

        while ($row = mysql_fetch_array($seasons)) {

########################### NCAA Football season dates ##################################################
                $season_key = $row['season_key'];
                $end_year = $season_key + 1;
                $qry = "UPDATE seasons SET start_date_time='{$season_key}-08-24 00:00:00', end_date_time='{$end_year}-02-01 23:59:59' WHERE league_id = {$league_id} AND season_key={$season_key}";
                mysql_query($qry);

##################### NCAA Men's Football bowl dates #################################
                $season_id = $row['id'];
                $qry = "UPDATE sub_seasons SET start_date_time='${end_year}-01-01 00:00:00', end_date_time='{$end_year}-02-01 00:00:00' WHERE season_id = {$season_id} AND sub_season_type = 'post-season'";
                mysql_query($qry);

        }
}
}

mysql_close($conn);

?>
