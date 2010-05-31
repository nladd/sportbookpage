

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hashed_password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `question_1` varchar(255) DEFAULT NULL,
  `answer_1` varchar(127) DEFAULT NULL,
  `question_2` varchar(255) DEFAULT NULL,
  `answer_2` varchar(127) DEFAULT NULL,
  `sportbucks` int(11) DEFAULT '10000',
  `birthday` varchar(10) DEFAULT NULL,
  `hometown` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `first_name` (`first_name`),
  KEY `hometown` (`hometown`),
  KEY `last_name` (`last_name`),
  KEY `middle_name` (`middle_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=latin1;


CREATE TABLE `position_stats_mappings` (
  `position_id` int(11) default NULL,
  `stats_mapping_id` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

