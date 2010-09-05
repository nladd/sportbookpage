

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
);

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `hashed_password` varchar(255) default NULL,
  `salt` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `email` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `middle_name` varchar(25) default NULL,
  `question_1` varchar(255) default NULL,
  `answer_1` varchar(127) default NULL,
  `question_2` varchar(255) default NULL,
  `answer_2` varchar(127) default NULL,
  `sportbucks` int(11) default '10000',
  `birthday` varchar(10) default NULL,
  `hometown` varchar(255) default NULL,
  `sex` char(1) default NULL,
  `reg_comp` tinyint(1) default '0',
  `state` varchar(2) default NULL,
  `wins` int(11) default '0',
  `losses` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `first_name` (`first_name`),
  KEY `hometown` (`hometown`),
  KEY `last_name` (`last_name`),
  KEY `middle_name` (`middle_name`)
);

CREATE TABLE IF NOT EXISTS `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challengee_id` int(11) DEFAULT NULL,
  `challenger_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `wager` float DEFAULT NULL,
  `spread` float DEFAULT NULL,
  `start_date_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `accepted` varchar(3) DEFAULT 'no',
  `league_id` int(11) DEFAULT NULL,
  `favorite_id` int(11) DEFAULT NULL,
  `underdog_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE IF NOT EXISTS `stats_mappings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stats_table` varchar(255) DEFAULT NULL,
  `stats_type` varchar(255) DEFAULT NULL,
  `stats_name` varchar(255) DEFAULT NULL,
  `stats_field` varchar(255) DEFAULT NULL,
  `sport` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `counter_field` varchar(100) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE IF NOT EXISTS `position_stats_mappings` (
  `position_id` int(11) default NULL,
  `stats_mapping_id` int(11) default NULL
);


CREATE TABLE IF NOT EXISTS `invitations` (
  `id` int(11) NOT NULL auto_increment,
  `date_sent` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `invitee_email` varchar(255) default NULL,
  `inviter_id` int(11) default NULL,
  `has_joined` tinyint(1) default '0',
  `reminder_sent` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
);

#CREATE TABLE `position_stats_mappings` (
#  `position_id` int(11) default NULL,
#  `stats_mapping_id` int(11) default NULL
#);


CREATE TABLE IF NOT EXISTS `documents_archive` (
  `id` int(11) NOT NULL auto_increment,
  `doc_id` varchar(75) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  `date_time` datetime default NULL,
  `title` varchar(255) default NULL,
  `language` varchar(100) default NULL,
  `priority` varchar(100) default NULL,
  `revision_id` varchar(255) default NULL,
  `stats_coverage` varchar(100) default NULL,
  `document_fixture_id` int(11) NOT NULL,
  `source_id` int(11) default NULL,
  `db_loading_date_time` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `IDX_documents_1` (`doc_id`),
  KEY `IDX_documents_3` (`date_time`),
  KEY `IDX_documents_4` (`priority`),
  KEY `IDX_documents_5` (`revision_id`),
  KEY `IDX_FK_doc_doc_fix_id__doc_fix_id` (`document_fixture_id`),
  KEY `IDX_FK_doc_pub_id__pub_id` (`publisher_id`),
  KEY `IDX_FK_doc_sou_id__pub_id` (`source_id`)
);

CREATE TABLE IF NOT EXISTS `document_contents_archive` (
  `id` int(11) NOT NULL auto_increment,
  `document_id` int(11) NOT NULL,
  `sportsml` varchar(200) default NULL,
  `sportsml_blob` text,
  `abstract` text,
  `abstract_blob` text,
  PRIMARY KEY  (`id`),
  KEY `IDX_FK_doc_con_doc_id__doc_id` (`document_id`)
);

CREATE TABLE IF NOT EXISTS `events_documents_archive` (
  `event_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_eve_doc_doc_id__doc_id` (`document_id`),
  KEY `FK_eve_doc_eve_id__eve_id` (`event_id`)
);

CREATE TABLE IF NOT EXISTS `affiliations_documents_archive` (
  `affiliation_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_aff_doc_aff_id__aff_id` (`affiliation_id`),
  KEY `FK_aff_doc_doc_id__doc_id` (`document_id`)
);

CREATE TABLE IF NOT EXISTS `teams_documents_archive` (
  `team_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_tea_doc_tea_id__tea_id` (`team_id`),
  KEY `FK_tea_doc_doc_id__doc_id` (`document_id`)
);

CREATE TABLE IF NOT EXISTS `persons_documents_archive` (
  `person_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_per_doc_per_id__per_id` (`person_id`),
  KEY `FK_per_doc_doc_id__doc_id` (`document_id`)
);

CREATE TABLE IF NOT EXISTS `latest_revisions_archive` (
  `id` int(11) NOT NULL auto_increment,
  `revision_id` varchar(255) NOT NULL,
  `latest_document_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `IDX_FK_lat_rev_lat_doc_id__doc_id` (`latest_document_id`),
  KEY `IDX_latest_revisions_1` (`revision_id`)
);


ALTER TABLE display_names ADD COLUMN url VARCHAR(255);
ALTER TABLE teams ADD COLUMN followers INT DEFAULT 0;
ALTER TABLE events ADD COLUMN playoff_round INT;
ALTER TABLE basketball_rebounding_stats ADD COLUMN rebounds_offensive_per_game INT;
ALTER TABLE basketball_rebounding_stats ADD COLUMN rebounds_defensive_per_game INT;

INSERT INTO `users` VALUES (1,'d404a4ded8c55e9b8c2568d6444bb2c52b58ccf1','702116691207800.263150304560719','2010-08-24 05:28:52','2010-08-24 05:30:47','unregistered.user@sportbookpage.com','Unregistered','User','','The answer to my question is the question?','the question',NULL,NULL,10000,'1/1/2000','Somewhere','f',0,'NE',0,0);
