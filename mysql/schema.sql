-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Jun 07, 2020 at 06:41 PM
-- Server version: 8.0.20
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `site_monitor`
--

-- --------------------------------------------------------

--
-- Table structure for table `Contact`
--

CREATE TABLE `Contact` (
  `contactId` int UNSIGNED NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci DEFAULT NULL,
  `phone` int UNSIGNED DEFAULT NULL,
  `creatorUserId` int UNSIGNED NOT NULL COMMENT 'the user that created this contact record',
  `createdTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changedTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Event`
--

CREATE TABLE `Event` (
  `eventId` int UNSIGNED NOT NULL,
  `monitorTypeId` int UNSIGNED NOT NULL,
  `eventReferenceId` int UNSIGNED NOT NULL COMMENT 'Id of specific event type instance (e.g. HeartBeatEvent)	'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `HeartBeat`
--

CREATE TABLE `HeartBeat` (
  `heartBeatId` int UNSIGNED NOT NULL,
  `monitorId` int UNSIGNED NOT NULL,
  `frequency` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '(seconds)',
  `contactIdToNotify` int UNSIGNED NOT NULL,
  `notifyMethodId` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `HeartBeatEvent`
--

CREATE TABLE `HeartBeatEvent` (
  `heartBeatEventId` int UNSIGNED NOT NULL,
  `heartBeatId` int UNSIGNED NOT NULL,
  `requestTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'when the request was made',
  `httpResponseCode` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Monitor`
--

CREATE TABLE `Monitor` (
  `monitorId` int UNSIGNED NOT NULL,
  `webPropertyId` int UNSIGNED NOT NULL,
  `monitorTypeId` int UNSIGNED NOT NULL,
  `monitorReferenceId` int UNSIGNED NOT NULL COMMENT 'Id of specific monitor type instance (e.g. HeartBeat)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='A monitor for a particular web property';

-- --------------------------------------------------------

--
-- Table structure for table `MonitorType`
--

CREATE TABLE `MonitorType` (
  `monitorTypeId` int UNSIGNED NOT NULL,
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Notification`
--

CREATE TABLE `Notification` (
  `notificationId` int UNSIGNED NOT NULL,
  `eventId` int UNSIGNED NOT NULL,
  `contactId` int UNSIGNED NOT NULL,
  `notifyMethodId` int UNSIGNED NOT NULL,
  `sentTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `readTime` datetime DEFAULT NULL COMMENT 'Time contact read the notification'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `NotifyMethod`
--

CREATE TABLE `NotifyMethod` (
  `notifyMethodId` int UNSIGNED NOT NULL,
  `method` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `userId` int UNSIGNED NOT NULL,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs DEFAULT NULL,
  `contactId` int UNSIGNED NOT NULL,
  `createdTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `WebProperty`
--

CREATE TABLE `WebProperty` (
  `webPropertyId` int UNSIGNED NOT NULL,
  `homeUrl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs NOT NULL,
  `ownerContactId` int UNSIGNED NOT NULL,
  `createdTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Contact`
--
ALTER TABLE `Contact`
  ADD PRIMARY KEY (`contactId`),
  ADD KEY `creatorUserId` (`creatorUserId`);

--
-- Indexes for table `Event`
--
ALTER TABLE `Event`
  ADD PRIMARY KEY (`eventId`),
  ADD KEY `monitorTypeId` (`monitorTypeId`);

--
-- Indexes for table `HeartBeat`
--
ALTER TABLE `HeartBeat`
  ADD PRIMARY KEY (`heartBeatId`),
  ADD KEY `monitorId` (`monitorId`),
  ADD KEY `contactIdToNotify` (`contactIdToNotify`),
  ADD KEY `notifyMethodId` (`notifyMethodId`);

--
-- Indexes for table `HeartBeatEvent`
--
ALTER TABLE `HeartBeatEvent`
  ADD PRIMARY KEY (`heartBeatEventId`),
  ADD KEY `heartBeatId` (`heartBeatId`);

--
-- Indexes for table `Monitor`
--
ALTER TABLE `Monitor`
  ADD PRIMARY KEY (`monitorId`),
  ADD KEY `webPropertyId` (`webPropertyId`),
  ADD KEY `monitorTypeId` (`monitorTypeId`);

--
-- Indexes for table `MonitorType`
--
ALTER TABLE `MonitorType`
  ADD PRIMARY KEY (`monitorTypeId`);

--
-- Indexes for table `Notification`
--
ALTER TABLE `Notification`
  ADD PRIMARY KEY (`notificationId`),
  ADD KEY `eventId` (`eventId`),
  ADD KEY `contactId` (`contactId`),
  ADD KEY `notifyMethodId` (`notifyMethodId`);

--
-- Indexes for table `NotifyMethod`
--
ALTER TABLE `NotifyMethod`
  ADD PRIMARY KEY (`notifyMethodId`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `unique_username` (`username`),
  ADD UNIQUE KEY `contactId_unique` (`contactId`),
  ADD KEY `contact_index` (`contactId`);

--
-- Indexes for table `WebProperty`
--
ALTER TABLE `WebProperty`
  ADD PRIMARY KEY (`webPropertyId`),
  ADD KEY `ownerContactId` (`ownerContactId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Contact`
--
ALTER TABLE `Contact`
  MODIFY `contactId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Event`
--
ALTER TABLE `Event`
  MODIFY `eventId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `HeartBeat`
--
ALTER TABLE `HeartBeat`
  MODIFY `heartBeatId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `HeartBeatEvent`
--
ALTER TABLE `HeartBeatEvent`
  MODIFY `heartBeatEventId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Monitor`
--
ALTER TABLE `Monitor`
  MODIFY `monitorId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Notification`
--
ALTER TABLE `Notification`
  MODIFY `notificationId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `userId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `WebProperty`
--
ALTER TABLE `WebProperty`
  MODIFY `webPropertyId` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Contact`
--
ALTER TABLE `Contact`
  ADD CONSTRAINT `Contact_ibfk_1` FOREIGN KEY (`creatorUserId`) REFERENCES `User` (`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Event`
--
ALTER TABLE `Event`
  ADD CONSTRAINT `Event_ibfk_1` FOREIGN KEY (`monitorTypeId`) REFERENCES `MonitorType` (`monitorTypeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `HeartBeat`
--
ALTER TABLE `HeartBeat`
  ADD CONSTRAINT `HeartBeat_ibfk_1` FOREIGN KEY (`monitorId`) REFERENCES `Monitor` (`monitorId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `HeartBeat_ibfk_2` FOREIGN KEY (`contactIdToNotify`) REFERENCES `Contact` (`contactId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `HeartBeat_ibfk_3` FOREIGN KEY (`notifyMethodId`) REFERENCES `NotifyMethod` (`notifyMethodId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `HeartBeatEvent`
--
ALTER TABLE `HeartBeatEvent`
  ADD CONSTRAINT `HeartBeatEvent_ibfk_1` FOREIGN KEY (`heartBeatId`) REFERENCES `HeartBeat` (`heartBeatId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Monitor`
--
ALTER TABLE `Monitor`
  ADD CONSTRAINT `Monitor_ibfk_1` FOREIGN KEY (`webPropertyId`) REFERENCES `WebProperty` (`webPropertyId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `Monitor_ibfk_2` FOREIGN KEY (`monitorTypeId`) REFERENCES `MonitorType` (`monitorTypeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Notification`
--
ALTER TABLE `Notification`
  ADD CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `Event` (`eventId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `Notification_ibfk_2` FOREIGN KEY (`contactId`) REFERENCES `Contact` (`contactId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `Notification_ibfk_3` FOREIGN KEY (`notifyMethodId`) REFERENCES `NotifyMethod` (`notifyMethodId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `User_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `Contact` (`contactId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `WebProperty`
--
ALTER TABLE `WebProperty`
  ADD CONSTRAINT `WebProperty_ibfk_1` FOREIGN KEY (`ownerContactId`) REFERENCES `Contact` (`contactId`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
