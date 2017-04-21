-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2017 at 08:30 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ridertracking`
--

-- --------------------------------------------------------

--
-- Table structure for table `checkpoints`
--

CREATE TABLE `checkpoints` (
  `checkpoint_id` int(11) NOT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `mac_address` varchar(50) NOT NULL,
  `checkpoint_name` varchar(200) DEFAULT NULL,
  `gps` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `checkpoints`
--

INSERT INTO `checkpoints` (`checkpoint_id`, `ip_address`, `mac_address`, `checkpoint_name`, `gps`) VALUES
(4, 'ip', 'macsd', '01asd', '-33.9821069, 25.5713902'),
(5, 'aisdf', 'asdfa', '92', '-33.98148018391812, 25.55348239839077'),
(6, 'ipasdfaczxvxcv', 'asdasdfa', 'zcxvzcxv', '-33.9791314630724, 25.537389144301414'),
(7, 'aasdf', 'wefwe', 'zxcvzcv', '-33.969024105726156, 25.51575981080532'),
(9, 'No 227, main rdsdfadsf', 'macsadfsdf', 'amir', '-33.9820594, 25.571363899999998'),
(10, 'asdfzxcv', 'zlkcvzc', 'amir2', '-33.97311368188676, 25.48489898443222'),
(11, 'ipipipi', 'masdfasdf', 'omid', '-33.97030538653371, 25.566528663039207'),
(12, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `race_checkpoints`
--

CREATE TABLE `race_checkpoints` (
  `race_checkpoint_id` int(254) NOT NULL,
  `race_header_id` int(11) NOT NULL,
  `checkpoint_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `race_checkpoints`
--

INSERT INTO `race_checkpoints` (`race_checkpoint_id`, `race_header_id`, `checkpoint_id`, `priority`) VALUES
(7, 18, 4, 0),
(8, 18, 5, 0),
(9, 18, 6, 0),
(10, 18, 7, 0),
(11, 18, 10, 0),
(12, 20, 4, 0),
(13, 20, 6, 0),
(14, 20, 9, 0),
(15, 20, 10, 0),
(16, 21, 4, 0),
(17, 21, 5, 0),
(18, 21, 6, 0),
(19, 22, 6, 0),
(20, 22, 7, 0),
(21, 22, 4, 0),
(22, 23, 6, 0),
(23, 23, 5, 0),
(24, 24, 4, 0),
(25, 24, 5, 0),
(26, 24, 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `race_header`
--

CREATE TABLE `race_header` (
  `race_header_id` int(11) NOT NULL,
  `lap_no` int(11) DEFAULT '0',
  `start_time` varchar(100) DEFAULT NULL,
  `finish_time` varchar(100) DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `race_header`
--

INSERT INTO `race_header` (`race_header_id`, `lap_no`, `start_time`, `finish_time`, `created_time`, `name`) VALUES
(18, 1, '1492722355808', '1492722887429', '2017-04-20 01:12:06', 'AMirtest'),
(20, 1, '1492723220542', '1492764077702', '2017-04-20 21:19:37', 'Roof-Of-Africa-April-20-23-19'),
(21, 1, '1492764182004', '1492766287098', '2017-04-21 08:42:02', 'Roof-Of-Africa-April-21-10-42'),
(22, 1, '1492769085728', '1492774488915', '2017-04-21 09:20:47', 'Roof-Of-Africa-April-21-11-20'),
(23, 1, '1492775428405', '1492775429970', '2017-04-21 11:35:26', 'Roof-Of-Africa-April-21-13-35'),
(24, 1, '1492798510343', '1492798603226', '2017-04-21 18:13:28', 'RFA-RACEApril-21');

-- --------------------------------------------------------

--
-- Table structure for table `race_line`
--

CREATE TABLE `race_line` (
  `race_line_id` int(11) NOT NULL,
  `race_header_id` int(11) NOT NULL,
  `rider_tag_id` int(11) NOT NULL,
  `checkpoint_race_id` int(254) NOT NULL,
  `time` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `race_line`
--

INSERT INTO `race_line` (`race_line_id`, `race_header_id`, `rider_tag_id`, `checkpoint_race_id`, `time`) VALUES
(5, 22, 41, 19, '1492769483133'),
(6, 22, 41, 20, '1492769997294'),
(7, 22, 42, 21, '1492774115704'),
(8, 22, 42, 20, '1492774134109'),
(9, 22, 42, 19, '1492774136578'),
(16, 22, 41, 21, '1492774417462'),
(17, 23, 43, 22, '1492774561555'),
(18, 24, 44, 25, '1492798556152'),
(19, 24, 45, 25, '1492798564785'),
(20, 24, 44, 26, '1492798598778'),
(21, 24, 45, 26, '1492798600142');

-- --------------------------------------------------------

--
-- Table structure for table `riders`
--

CREATE TABLE `riders` (
  `rider_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `riders`
--

INSERT INTO `riders` (`rider_id`, `username`) VALUES
(2, 'amir'),
(3, 'amir2'),
(4, 'amir3'),
(5, 'zxcvz'),
(6, 'dfsfsf'),
(7, 'zxcvzfsdf'),
(8, 'dfsfsfjm');

-- --------------------------------------------------------

--
-- Table structure for table `rider_tag_date`
--

CREATE TABLE `rider_tag_date` (
  `rider_tag_id` int(254) NOT NULL,
  `race_header_id` int(254) DEFAULT NULL,
  `rider_id` int(254) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `rider_tag_date`
--

INSERT INTO `rider_tag_date` (`rider_tag_id`, `race_header_id`, `rider_id`, `tag_id`, `date`) VALUES
(32, 18, 2, 44, '2017-04-20 14:56:46'),
(33, 18, 3, 45, '2017-04-20 14:56:53'),
(37, 18, 6, 41, '2017-04-20 20:00:01'),
(38, 20, 5, 47, '2017-04-20 20:00:14'),
(39, 21, 2, 48, '2017-04-21 08:42:20'),
(40, 21, 5, 49, '2017-04-21 08:42:37'),
(41, 22, 3, 50, '2017-04-21 09:21:49'),
(42, 22, 4, 51, '2017-04-21 11:27:41'),
(43, 23, 7, 41, '2017-04-21 11:35:32'),
(44, 24, 6, 30, '2017-04-21 18:14:27'),
(45, 24, 8, 52, '2017-04-21 18:14:40');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(254) NOT NULL,
  `tag_code` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`tag_id`, `tag_code`) VALUES
(23, 'zxcvzxvc'),
(24, 'sadfaf'),
(25, 'kjasf'),
(26, 'sfdfsdf'),
(27, 'zxcvzcxvz'),
(28, 'hihihi'),
(29, 'nvnvnv'),
(30, 'zxcvzxcv'),
(31, 'zxcvzcv'),
(32, 'azxcvcxv'),
(33, 'asdfad'),
(34, 'asdfafd'),
(35, 'aazxcvzcxv'),
(36, 'asdafadf'),
(37, 'dddd'),
(38, 'asdfaf'),
(39, 'zxcvxcvzcv'),
(40, 'lkxzcvzv'),
(41, ''),
(42, 'kzcxvzxcv'),
(43, 'zxcvzcxv'),
(44, 'azxcvzcxv'),
(45, 'zdvzxcv'),
(46, 'sdfsdfsf'),
(47, 'asdfasdf'),
(48, 'asdfasdfdf'),
(49, 'zxcvzxcvzcv'),
(50, 'fffff'),
(51, 'djdjdd'),
(52, 'zxcvzxcvzcxv');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `checkpoints`
--
ALTER TABLE `checkpoints`
  ADD PRIMARY KEY (`checkpoint_id`);

--
-- Indexes for table `race_checkpoints`
--
ALTER TABLE `race_checkpoints`
  ADD PRIMARY KEY (`race_checkpoint_id`),
  ADD KEY `race_header_id` (`race_header_id`),
  ADD KEY `checkpoint_id` (`checkpoint_id`);

--
-- Indexes for table `race_header`
--
ALTER TABLE `race_header`
  ADD PRIMARY KEY (`race_header_id`);

--
-- Indexes for table `race_line`
--
ALTER TABLE `race_line`
  ADD PRIMARY KEY (`race_line_id`),
  ADD KEY `race_header_id` (`race_header_id`),
  ADD KEY `rider_tag_id` (`rider_tag_id`),
  ADD KEY `checkpoint_id` (`checkpoint_race_id`);

--
-- Indexes for table `riders`
--
ALTER TABLE `riders`
  ADD PRIMARY KEY (`rider_id`);

--
-- Indexes for table `rider_tag_date`
--
ALTER TABLE `rider_tag_date`
  ADD PRIMARY KEY (`rider_tag_id`),
  ADD KEY `tag_id` (`tag_id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `race_header_id` (`race_header_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `checkpoints`
--
ALTER TABLE `checkpoints`
  MODIFY `checkpoint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `race_checkpoints`
--
ALTER TABLE `race_checkpoints`
  MODIFY `race_checkpoint_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `race_header`
--
ALTER TABLE `race_header`
  MODIFY `race_header_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `race_line`
--
ALTER TABLE `race_line`
  MODIFY `race_line_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `rider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `rider_tag_date`
--
ALTER TABLE `rider_tag_date`
  MODIFY `rider_tag_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `race_checkpoints`
--
ALTER TABLE `race_checkpoints`
  ADD CONSTRAINT `race_checkpoints_ibfk_1` FOREIGN KEY (`checkpoint_id`) REFERENCES `checkpoints` (`checkpoint_id`),
  ADD CONSTRAINT `race_checkpoints_ibfk_2` FOREIGN KEY (`race_header_id`) REFERENCES `race_header` (`race_header_id`);

--
-- Constraints for table `race_line`
--
ALTER TABLE `race_line`
  ADD CONSTRAINT `race_line_ibfk_1` FOREIGN KEY (`race_header_id`) REFERENCES `race_header` (`race_header_id`),
  ADD CONSTRAINT `race_line_ibfk_2` FOREIGN KEY (`checkpoint_race_id`) REFERENCES `race_checkpoints` (`race_checkpoint_id`),
  ADD CONSTRAINT `race_line_ibfk_3` FOREIGN KEY (`rider_tag_id`) REFERENCES `rider_tag_date` (`rider_tag_id`);

--
-- Constraints for table `rider_tag_date`
--
ALTER TABLE `rider_tag_date`
  ADD CONSTRAINT `rider_tag_date_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`rider_id`),
  ADD CONSTRAINT `rider_tag_date_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`),
  ADD CONSTRAINT `rider_tag_date_ibfk_3` FOREIGN KEY (`race_header_id`) REFERENCES `race_header` (`race_header_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
