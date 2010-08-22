

<?php

$archive_path = "/home/nathan/FeedFetcherDeluxe/archive/";

$conn = mysql_connect('localhost', 'root', '');
mysql_select_db("sportbookpage_development");

$time = time() - (10 * 24 * 60 * 60); #subtract 10 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '" . $str_time . "' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key = 'event-score' AND document_contents.document_id = documents.id";

$result = mysql_query($query);
$docs = 0;
while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
	system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = " . $row['document_id'];
	mysql_query($query);

	$query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
	mysql_query($query);
	$query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
	$query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
	$query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
	$query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
	mysql_query($query);

	$docs++;
}

$time = time() - (45 * 24 * 60 * 60); #subtract 45 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '" . $str_time . "' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key = 'pre-event-coverage' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = " . $row['document_id'];
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

	$docs++;
}


$time = time() - (45 * 24 * 60 * 60); #subtract 45 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '{$str_time}' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key LIKE 'standings%' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = {$row['document_id']}";
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

        $docs++;
}


$time = time() - (45 * 24 * 60 * 60); #subtract 45 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '{$str_time}' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key LIKE 'matchup%' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = {$row['document_id']}";
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

        $docs++;
}



$time = time() - (90 * 24 * 60 * 60); #subtract 90 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '{$str_time}' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key LIKE 'leaders%' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = {$row['document_id']}";
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

        $docs++;
}


$time = time() - (60 * 24 * 60 * 60); #subtract 60 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '{$str_time}' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key LIKE 'injuries%' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = {$row['document_id']}";
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

        $docs++;
}

$time = time() - (90 * 24 * 60 * 60); #subtract 90 days
$str_time = date ("Y-m-d H:i:s", $time);

$query = "SELECT document_contents.sportsml, document_contents.document_id FROM document_contents, documents, document_fixtures WHERE documents.date_time < '{$str_time}' AND documents.document_fixture_id = document_fixtures.id AND document_fixtures.fixture_key LIKE 'event%' AND document_contents.document_id = documents.id";

$result = mysql_query($query);

while($row = mysql_fetch_array($result))
{
        $sportsml = $row['sportsml'];
        system("rm -rf " . $archive_path . $sportsml);

        $query = "DELETE FROM documents WHERE id = {$row['document_id']}";
        mysql_query($query);

        $query = "DELETE FROM affiliations_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM teams_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM persons_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM events_documents WHERE document_id = {$row['document_id']}";
        mysql_query($query);
        $query = "DELETE FROM document_contents WHERE document_id = " . $row['document_id'];
        mysql_query($query);

        $docs++;
}

echo "DOCUMENTS DELETED: {$docs}";

mysql_close($conn);

?>

