
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `awards` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Player_id` int DEFAULT NULL,
  `award` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_awards_on_Player_ID` (`Player_id`),
  CONSTRAINT `fk_rails_ce60f534f3` FOREIGN KEY (`Player_id`) REFERENCES `players` (`Player_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `dc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Position` int DEFAULT NULL,
  `Rank` int DEFAULT NULL,
  `Player` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) DEFAULT NULL,
  `event` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `gameschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameschedule` (
  `Game_ID` bigint NOT NULL AUTO_INCREMENT,
  `Game_Date` datetime(6) DEFAULT NULL,
  `Opponent` varchar(25) NOT NULL,
  `HV` varchar(255) NOT NULL DEFAULT 'H',
  `Location` varchar(20) NOT NULL,
  `Playoff` tinyint(1) NOT NULL DEFAULT '0',
  `Finals` tinyint(1) NOT NULL DEFAULT '0',
  `Wood` tinyint(1) NOT NULL DEFAULT '0',
  `Manager` int NOT NULL DEFAULT '0',
  `SP` int NOT NULL DEFAULT '0',
  `Notes` varchar(145) DEFAULT NULL,
  `LocationId` int unsigned NOT NULL,
  `GameFile` mediumtext,
  PRIMARY KEY (`Game_ID`),
  UNIQUE KEY `index_gameschedules_on_gamedate` (`Game_Date`),
  KEY `index_gameschedule_on_Manager` (`Manager`),
  KEY `index_gameschedule_on_LocationId` (`LocationId`),
  CONSTRAINT `fk_rails_422aa3e68f` FOREIGN KEY (`LocationId`) REFERENCES `locations` (`Id`),
  CONSTRAINT `fk_rails_d3d56f70e8` FOREIGN KEY (`Manager`) REFERENCES `players` (`Player_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=816 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Category` varchar(255) DEFAULT NULL,
  `Data` varchar(255) DEFAULT NULL,
  `YearStart` varchar(255) DEFAULT NULL,
  `YearEnd` varchar(255) DEFAULT NULL,
  `Finish` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `hittingstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hittingstats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Player_ID` int DEFAULT NULL,
  `Game_ID` bigint DEFAULT NULL,
  `AB` int DEFAULT NULL,
  `R` int DEFAULT NULL,
  `H` int DEFAULT NULL,
  `2B` int DEFAULT NULL,
  `3B` int DEFAULT NULL,
  `HR` int DEFAULT NULL,
  `RBI` int DEFAULT NULL,
  `BB` int DEFAULT NULL,
  `HBP` int DEFAULT NULL,
  `K` int DEFAULT NULL,
  `SB` int DEFAULT NULL,
  `CS` int DEFAULT NULL,
  `SAC` int DEFAULT NULL,
  `SF` int DEFAULT NULL,
  `LOB` int DEFAULT NULL,
  `Bitching` int DEFAULT NULL,
  `PO` int DEFAULT NULL,
  `A` int DEFAULT NULL,
  `E` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_925ad0b6c9` (`Player_ID`),
  KEY `fk_rails_07763d2699` (`Game_ID`),
  CONSTRAINT `fk_rails_07763d2699` FOREIGN KEY (`Game_ID`) REFERENCES `gameschedule` (`Game_ID`),
  CONSTRAINT `fk_rails_925ad0b6c9` FOREIGN KEY (`Player_ID`) REFERENCES `players` (`Player_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6776 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `innings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `innings` (
  `GameId` int NOT NULL,
  `Inning` int NOT NULL,
  `Hruns` int DEFAULT NULL,
  `Hhits` int DEFAULT NULL,
  `Herrors` int DEFAULT NULL,
  `Aruns` int DEFAULT NULL,
  `Ahits` int DEFAULT NULL,
  `Aerrors` int DEFAULT NULL,
  PRIMARY KEY (`GameId`,`Inning`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `FieldName` varchar(45) NOT NULL,
  `ShortName` varchar(2) NOT NULL,
  `Link` varchar(255) NOT NULL,
  `Current` tinyint(1) NOT NULL,
  `CityAndState` varchar(45) DEFAULT NULL,
  `GoogleName` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `managerrecords`;
/*!50001 DROP VIEW IF EXISTS `managerrecords`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `managerrecords` AS SELECT 
 1 AS `Manager`,
 1 AS `Years`,
 1 AS `Seasons`,
 1 AS `Record`,
 1 AS `Games`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `notable_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notable_players` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_name` text,
  `first_name` text,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `pitchingstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitchingstats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Player_ID` int DEFAULT NULL,
  `Game_ID` bigint DEFAULT NULL,
  `Decision` varchar(255) DEFAULT NULL,
  `GS` int DEFAULT NULL,
  `IP` float DEFAULT NULL,
  `BF` int DEFAULT NULL,
  `H` int DEFAULT NULL,
  `R` int DEFAULT NULL,
  `ER` int DEFAULT NULL,
  `BB` int DEFAULT NULL,
  `K` int DEFAULT NULL,
  `HB` int DEFAULT NULL,
  `HR` int DEFAULT NULL,
  `cg` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_23f7e1e20f` (`Player_ID`),
  KEY `fk_rails_00ba5d58c5` (`Game_ID`),
  CONSTRAINT `fk_rails_00ba5d58c5` FOREIGN KEY (`Game_ID`) REFERENCES `gameschedule` (`Game_ID`),
  CONSTRAINT `fk_rails_23f7e1e20f` FOREIGN KEY (`Player_ID`) REFERENCES `players` (`Player_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `Player_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(255) DEFAULT NULL,
  `Last_Name` varchar(255) DEFAULT NULL,
  `Current` tinyint(1) DEFAULT NULL,
  `Bats` varchar(255) DEFAULT NULL,
  `Throws` varchar(255) DEFAULT NULL,
  `POS1` varchar(255) DEFAULT NULL,
  `POS2` varchar(255) DEFAULT NULL,
  `POS3` varchar(255) DEFAULT NULL,
  `Nickname` varchar(255) DEFAULT NULL,
  `Hometown` varchar(255) DEFAULT NULL,
  `Divorces` int DEFAULT NULL,
  `DOB` datetime(6) DEFAULT NULL,
  `Height` int DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  `Image` tinyint(1) DEFAULT NULL,
  `uniform` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Player_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `playoffhistory`;
/*!50001 DROP VIEW IF EXISTS `playoffhistory`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `playoffhistory` AS SELECT 
 1 AS `Year`,
 1 AS `Record`,
 1 AS `Result`,
 1 AS `W`,
 1 AS `L`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `season1`;
/*!50001 DROP VIEW IF EXISTS `season1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `season1` AS SELECT 
 1 AS `GameId`,
 1 AS `HV`,
 1 AS `Hruns`,
 1 AS `Aruns`,
 1 AS `HHits`,
 1 AS `AHits`,
 1 AS `HErrors`,
 1 AS `AErrors`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `season2`;
/*!50001 DROP VIEW IF EXISTS `season2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `season2` AS SELECT 
 1 AS `game_id`,
 1 AS `W`,
 1 AS `L`,
 1 AS `T`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `seasonrecords`;
/*!50001 DROP VIEW IF EXISTS `seasonrecords`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `seasonrecords` AS SELECT 
 1 AS `Playoff`,
 1 AS `Year`,
 1 AS `W`,
 1 AS `L`,
 1 AS `T`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Team` varchar(255) NOT NULL,
  `W` int DEFAULT NULL,
  `L` int DEFAULT NULL,
  `T` int DEFAULT NULL,
  `F` int DEFAULT NULL,
  `Division` varchar(255) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  `Franchise_ID` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP VIEW IF EXISTS `managerrecords`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `managerrecords` AS select concat_ws(' ',`players`.`First_Name`,`players`.`Last_Name`) AS `Manager`,concat_ws('-',min(`history`.`YearStart`),(case when (max(`history`.`YearStart`) >= year(curdate())) then 'Present' else max(`history`.`YearStart`) end)) AS `Years`,count(distinct `history`.`YearStart`) AS `Seasons`,concat_ws('-',sum(coalesce(`seasonrecords`.`W`,0)),sum(coalesce(`seasonrecords`.`L`,0)),sum(coalesce(`seasonrecords`.`T`,0))) AS `Record`,((sum(coalesce(`seasonrecords`.`W`,0)) + sum(coalesce(`seasonrecords`.`L`,0))) + sum(coalesce(`seasonrecords`.`T`,0))) AS `Games` from ((`players` join `history` on(((`history`.`Data` = `players`.`Player_ID`) and (`history`.`Category` = 'Manage')))) left join `seasonrecords` on((`seasonrecords`.`Year` = `history`.`YearStart`))) group by `history`.`Data` union select 'Total' AS `Total`,concat_ws('-',min(`history`.`YearStart`),max(`history`.`YearStart`)) AS `Years`,count(distinct `seasonrecords`.`Year`) AS `Seasons`,concat_ws('-',sum(`seasonrecords`.`W`),sum(`seasonrecords`.`L`),sum(`seasonrecords`.`T`)) AS `Record`,((sum(`seasonrecords`.`W`) + sum(`seasonrecords`.`L`)) + sum(`seasonrecords`.`T`)) AS `Games` from (`history` join `seasonrecords` on(((`seasonrecords`.`Year` = `history`.`YearStart`) and (`history`.`Category` = 'Manage')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `playoffhistory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `playoffhistory` AS select `history`.`YearStart` AS `Year`,concat_ws('-',coalesce(`seasonrecords`.`W`,0),coalesce(`seasonrecords`.`L`,0)) AS `Record`,`history`.`Finish` AS `Result`,coalesce(`seasonrecords`.`W`,0) AS `W`,coalesce(`seasonrecords`.`L`,0) AS `L` from (`history` left join `seasonrecords` on(((`seasonrecords`.`Year` = `history`.`YearStart`) and (`seasonrecords`.`Playoff` = 1)))) where (`history`.`Category` = 'Championship') order by `history`.`YearStart` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `season1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `season1` AS select `innings`.`GameId` AS `GameId`,`gameschedule`.`HV` AS `HV`,sum(`innings`.`Hruns`) AS `Hruns`,sum(`innings`.`Aruns`) AS `Aruns`,sum(`innings`.`Hhits`) AS `HHits`,sum(`innings`.`Ahits`) AS `AHits`,sum(`innings`.`Herrors`) AS `HErrors`,sum(`innings`.`Aerrors`) AS `AErrors` from (`innings` join `gameschedule` on((`gameschedule`.`Game_ID` = `innings`.`GameId`))) group by `innings`.`GameId`,`gameschedule`.`HV` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `season2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `season2` AS select `g`.`Game_ID` AS `game_id`,(case when (((`gw`.`Hruns` > `gw`.`Aruns`) and (`g`.`HV` = 'H')) or ((`gw`.`Aruns` > `gw`.`Hruns`) and (`g`.`HV` = 'V'))) then 1 else 0 end) AS `W`,(case when (((`gw`.`Hruns` < `gw`.`Aruns`) and (`g`.`HV` = 'H')) or ((`gw`.`Aruns` < `gw`.`Hruns`) and (`g`.`HV` = 'V'))) then 1 else 0 end) AS `L`,(case when ((`gw`.`Hruns` = `gw`.`Aruns`) and (`gw`.`Hruns` > 0) and (`gw`.`Aruns` > 0)) then 1 else 0 end) AS `T` from (`gameschedule` `g` join `season1` `gw` on((`gw`.`GameId` = `g`.`Game_ID`))) where (year(`g`.`Game_Date`) > 2005) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `seasonrecords`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `seasonrecords` AS select 0 AS `Playoff`,2003 AS `Year`,7 AS `W`,21 AS `L`,0 AS `T` union select 0 AS `0`,2004 AS `2004`,2 AS `2`,25 AS `25`,0 AS `0` union select 0 AS `0`,2005 AS `2005`,7 AS `7`,20 AS `20`,0 AS `0` union select `gs`.`Playoff` AS `Season`,year(`gs`.`Game_Date`) AS `YEAR(gs.Game_Date)`,sum(`record`.`W`) AS `W`,sum(`record`.`L`) AS `L`,sum(`record`.`T`) AS `T` from (`gameschedule` `gs` join `season2` `record` on((`gs`.`Game_ID` = `record`.`game_id`))) group by year(`gs`.`Game_Date`),`gs`.`Playoff` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20260305194801'),
('20260227163412'),
('20260226170700'),
('20260225170600'),
('20260225170400'),
('20260225163200'),
('20260225163100'),
('20260225142636'),
('20260224214741'),
('20260224201647'),
('20260223155458'),
('20260223152016'),
('20260223151535'),
('20260223141145'),
('20260223140821'),
('20260222144728'),
('20260221224741'),
('20260221183816'),
('20260221164329');

