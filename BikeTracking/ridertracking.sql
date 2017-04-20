-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2017 at 02:54 AM
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
(1, 'ipp', 'mac', 'testasdasdasd', '-31.420460049675587, 29.51580047607422'),
(2, 'aspdasdas', 'sdfsfsdf', 'tesmlncv', '-22.9821041, 21.57136'),
(3, 'ipipip', 'masdf', 'Aasdfasdf', '-33.9821041, 25.571360799999997');

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
(1, 16, 1, 0),
(2, 16, 2, 0),
(3, 16, 3, 0),
(4, 17, 1, 0),
(5, 17, 2, 0),
(6, 17, 3, 0);

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
(17, 1, NULL, NULL, '2017-04-19 18:32:28', 'Roof-Of-Africa-April-19 2');

-- --------------------------------------------------------

--
-- Table structure for table `race_line`
--

CREATE TABLE `race_line` (
  `race_line_id` int(11) NOT NULL,
  `race_header_id` int(11) NOT NULL,
  `rider_tag_id` int(11) NOT NULL,
  `checkpoint_id` int(254) NOT NULL,
  `time` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `race_tags`
--

CREATE TABLE `race_tags` (
  `race_tag_id` int(254) NOT NULL,
  `race_header_id` int(11) NOT NULL,
  `rider_tag_id` int(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `race_tags`
--

INSERT INTO `race_tags` (`race_tag_id`, `race_header_id`, `rider_tag_id`) VALUES
(7, 17, 3),
(8, 17, 4),
(9, 17, 5);

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
(4, 'amir3');

-- --------------------------------------------------------

--
-- Table structure for table `rider_tag_date`
--

CREATE TABLE `rider_tag_date` (
  `rider_tag_id` int(254) NOT NULL,
  `rider_id` int(254) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `rider_tag_date`
--

INSERT INTO `rider_tag_date` (`rider_tag_id`, `rider_id`, `tag_id`, `date`) VALUES
(1, 2, 18, '2017-04-19 19:25:28'),
(2, 3, 19, '2017-04-19 19:26:06'),
(3, 2, 20, '2017-04-19 22:14:19'),
(4, 3, 21, '2017-04-19 23:42:00'),
(5, 4, 22, '2017-04-19 23:43:11');

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
(3, 'Rupert'),
(4, 'asdfasdfaf'),
(5, 'asdfasdfafZ'),
(6, 'hitag'),
(7, 'dfafZ'),
(8, 'xfvzxcvzxcv'),
(9, 'azxcvzvzzxcvefew'),
(10, 'xcvzcvzxcv'),
(11, 'dfgvchfghft'),
(12, 'zxcvzxcvcxv'),
(13, 'sdfadsfa'),
(14, 'mdmdmdmd'),
(15, 'cdcdddcdc'),
(16, 'cdcdcdcd'),
(17, 'zxcvzxcvzcvzv'),
(18, 'sdadc'),
(19, 'zsddsffdf'),
(20, 'asdasdac'),
(21, 'zxcvzxcv'),
(22, 'sdfsdf');

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
  ADD KEY `checkpoint_id` (`checkpoint_id`);

--
-- Indexes for table `race_tags`
--
ALTER TABLE `race_tags`
  ADD PRIMARY KEY (`race_tag_id`),
  ADD KEY `race_header_id` (`race_header_id`),
  ADD KEY `rider_tag_id` (`rider_tag_id`);

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
  ADD KEY `rider_id` (`rider_id`);

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
  MODIFY `checkpoint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `race_checkpoints`
--
ALTER TABLE `race_checkpoints`
  MODIFY `race_checkpoint_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `race_header`
--
ALTER TABLE `race_header`
  MODIFY `race_header_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `race_line`
--
ALTER TABLE `race_line`
  MODIFY `race_line_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `race_tags`
--
ALTER TABLE `race_tags`
  MODIFY `race_tag_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `rider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `rider_tag_date`
--
ALTER TABLE `rider_tag_date`
  MODIFY `rider_tag_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(254) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
