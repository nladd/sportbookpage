

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
);


CREATE TABLE `users` (
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
  PRIMARY KEY  (`id`),
  KEY `first_name` (`first_name`),
  KEY `hometown` (`hometown`),
  KEY `last_name` (`last_name`),
  KEY `middle_name` (`middle_name`)
);

CREATE TABLE `challenges` (
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


CREATE TABLE `stats_mappings` (
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


CREATE TABLE `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_sent` DATETIME DEFAULT NOW(),
  `invitee_email` varchar(255) DEFAULT NULL,
  `inviter_id` int(11) DEFAULT NULL,
  `has_joined` boolean DEFAULT false,
  PRIMARY KEY (`id`)
);



#CREATE TABLE `position_stats_mappings` (
#  `position_id` int(11) default NULL,
#  `stats_mapping_id` int(11) default NULL
#);



ALTER TABLE teams ADD COLUMN followers INT DEFAULT 0;
ALTER TABLE events ADD COLUMN playoff_round INT;
ALTER TABLE basketball_rebounding_stats ADD COLUMN rebounds_offensive_per_game INT;
ALTER TABLE basketball_rebounding_stats ADD COLUMN rebounds_defensive_per_game INT;
