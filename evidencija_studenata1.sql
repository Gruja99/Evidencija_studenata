-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2021 at 09:02 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evidencija_studenata1`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `korisnici` ()  BEGIN
	SELECT * FROM korisnici;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `predmeti` ()  BEGIN
	SELECT * FROM predmeti;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `telefon` (`ime` VARCHAR(50), `prezime` VARCHAR(50), `broj_telefona` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET latin1 BEGIN
      DECLARE tel VARCHAR(50);                   
      SET tel =  CONCAT(ime ," ", prezime , " ", broj_telefona );
      RETURN tel;
 END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `username` (`email` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET latin1 BEGIN
	DECLARE username VARCHAR(50);
    SET username = SUBSTRING_INDEX(email,"@", 1);
    RETURN username;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

CREATE TABLE `korisnici` (
  `id` int(11) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime`, `prezime`, `email`, `lozinka`) VALUES
(1, 'Stefan', 'Stefanovic', 'stexstefi@gmail.com', 'pbkdf2:sha256:150000$em7LHdlf$f53da62c0b6ded4bca7a9d163f681bdf29a815c552d4c7a4729c9924692d3dcd'),
(2, 'luka', 'grujic', 'luka.g@krstarica.com', 'pbkdf2:sha256:150000$T9AArwcA$cc0fa48715dff75a89a97607dba7a82e906c04e026f521188a9bd99223eb387d'),
(5, 'Luka', 'Grujic', 'lukagrujic80@gmail.com', 'pbkdf2:sha256:150000$Q5kOdH2g$7248b33067f1ec9aeebc064b0e8db8dc9e091150944eac7d4ea1c28b56e6108f');

-- --------------------------------------------------------

--
-- Table structure for table `ocene`
--

CREATE TABLE `ocene` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `predmet_id` int(11) NOT NULL,
  `ocena` smallint(6) NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ocene`
--

INSERT INTO `ocene` (`id`, `student_id`, `predmet_id`, `ocena`, `datum`) VALUES
(12, 2, 10, 9, '2020-01-23'),
(13, 2, 9, 8, '2020-01-21'),
(14, 2, 8, 9, '2020-01-29'),
(15, 2, 16, 10, '2020-01-24'),
(16, 2, 11, 10, '2020-01-27'),
(17, 2, 15, 8, '2020-02-04'),
(18, 2, 12, 7, '2020-06-03'),
(19, 2, 17, 10, '2020-02-10'),
(20, 2, 13, 10, '2020-01-28'),
(21, 2, 14, 7, '2020-01-30');

--
-- Triggers `ocene`
--
DELIMITER $$
CREATE TRIGGER `neprolazna_ocena` BEFORE INSERT ON `ocene` FOR EACH ROW BEGIN
IF NEW.ocena < 6 
THEN SET NEW.ocena = 6;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `predmeti`
--

CREATE TABLE `predmeti` (
  `id` int(11) NOT NULL,
  `sifra` varchar(30) NOT NULL,
  `naziv` varchar(50) NOT NULL,
  `godina_studija` smallint(6) NOT NULL,
  `espb` int(11) NOT NULL,
  `obavezni_izborni` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `predmeti`
--

INSERT INTO `predmeti` (`id`, `sifra`, `naziv`, `godina_studija`, `espb`, `obavezni_izborni`) VALUES
(8, '1', 'Fizika', 1, 6, 'obavezni'),
(9, '2', 'Osnovi elektrotehnike 1', 1, 8, 'obavezni'),
(10, '3', 'Matematika 1', 1, 6, 'obavezni'),
(11, '4', 'Poslovne komunikacije', 1, 4, 'izborni'),
(12, '5', 'Osnovi racunarske tehnike', 1, 6, 'obavezni'),
(13, '6', 'Matematika 2', 1, 6, 'obavezni'),
(14, '7', 'Osnovi telekomunikacije', 1, 6, 'izborni'),
(15, '8', 'Osnovi elektronike', 1, 6, 'obavezni'),
(16, '9', 'Algoritmi i strukture podataka', 1, 6, 'obavezni'),
(17, '10', 'Osnovi programiranja', 1, 6, 'obavezni'),
(18, '11', 'Tehnicki engleski 1', 2, 4, 'izborni'),
(19, '12', 'Operativni sistemi', 2, 7, 'obavezni'),
(20, '13', 'Baze podataka', 2, 6, 'obavezni'),
(21, '14', 'Internet tehnologije', 2, 7, 'obavezni'),
(22, '15', 'Web dizajn', 2, 6, 'obavezni'),
(23, '16', 'Vektorska grafika', 2, 6, 'obavezni'),
(24, '17', 'Administriranje racunarskih mreza', 2, 6, 'izborni'),
(25, '18', 'Objektno orijentisano programiranje', 2, 6, 'obavezni'),
(26, '19', 'Mrezni servisi', 2, 6, 'izborni'),
(27, '20', 'Racunarske mreze', 2, 6, 'izborni'),
(28, '21', 'Arhitektura mikrokontrolera', 3, 6, 'obavezni'),
(29, '22', 'Tehnicki engleski 2', 3, 4, 'obavezni'),
(30, '23', 'NET tehnologije', 3, 6, 'obavezni'),
(31, '24', 'Klijent server sistemi', 3, 6, 'obavezni'),
(32, '25', 'Veb Programiranje', 3, 6, 'izborni'),
(33, '26', 'Softversko inzenjerstvo', 3, 7, 'obavezni'),
(34, '27', 'Administriranje baza podataka', 3, 5, 'izborni'),
(35, '28', 'Primena mikrokontrolera', 3, 6, 'obavezni'),
(36, '29', 'Elektronsko poslovanje', 3, 6, 'obavezni');

--
-- Triggers `predmeti`
--
DELIMITER $$
CREATE TRIGGER `obavezni_izborni` BEFORE INSERT ON `predmeti` FOR EACH ROW BEGIN
IF NEW.espb > 6
THEN SET NEW.obavezni_izborni = 'obavezni';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `p_studenti_17`
-- (See below for the actual view)
--
CREATE TABLE `p_studenti_17` (
`id` int(11)
,`ime` varchar(100)
,`ime_roditelja` varchar(100)
,`prezime` varchar(100)
,`broj_indeksa` varchar(10)
,`godina_studija` smallint(6)
,`jmbg` bigint(20)
,`datum_rodjenja` date
,`espb` int(11)
,`prosek_ocena` float
,`broj_telefona` varchar(20)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `p_zavrsili_17`
-- (See below for the actual view)
--
CREATE TABLE `p_zavrsili_17` (
`id` int(11)
,`ime` varchar(100)
,`ime_roditelja` varchar(100)
,`prezime` varchar(100)
,`broj_indeksa` varchar(10)
,`godina_studija` smallint(6)
,`jmbg` bigint(20)
,`datum_rodjenja` date
,`espb` int(11)
,`prosek_ocena` float
,`broj_telefona` varchar(20)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `studenti`
--

CREATE TABLE `studenti` (
  `id` int(11) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `ime_roditelja` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `broj_indeksa` varchar(10) NOT NULL,
  `godina_studija` smallint(6) NOT NULL,
  `jmbg` bigint(20) NOT NULL,
  `datum_rodjenja` date NOT NULL,
  `espb` int(11) NOT NULL,
  `prosek_ocena` float NOT NULL,
  `broj_telefona` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `studenti`
--

INSERT INTO `studenti` (`id`, `ime`, `ime_roditelja`, `prezime`, `broj_indeksa`, `godina_studija`, `jmbg`, `datum_rodjenja`, `espb`, `prosek_ocena`, `broj_telefona`, `email`) VALUES
(1, 'Milan', 'Dragan', 'Djordjevic', 'REr 01/17', 3, 512352122, '1996-01-15', 0, 0, '062533252', 'milancedj@gmail.com'),
(2, 'Aleksa ', 'Miljan', 'Nejkovic', 'REr 02/17', 3, 15056437542, '1997-05-15', 60, 8.8, '0605632631', 'nejkovic.a@gmail.com'),
(3, 'Viktor', 'Dejan', 'Randjelovic', 'REr 09/17', 3, 707200031, '1998-07-07', 0, 0, '0612342005', 'viktor98@gmail.com'),
(4, 'Danijel', 'Milan', 'Perisic', 'REr 14/17', 3, 1402003566, '1996-02-14', 0, 0, '0628837001', 'dakazmaj@gmail.com'),
(5, 'Mirko', 'Goran', 'Mijovic', 'REr 06/17', 3, 1209233075, '1995-09-12', 0, 0, '0631027772', 'mijovicm@gmail.com'),
(6, 'Stefan', 'Ljubisa', 'Stefanovic', 'REr 17/17', 3, 15119980023, '1998-11-15', 0, 0, '0604126566', 'stexstefi@gmail.com'),
(7, 'Nikola', 'Miroslav', 'Jonic', 'REr 21/17', 3, 220733215, '1997-07-22', 0, 0, '0611236534', 'jonic@gmail.com'),
(8, 'Djordje', 'Nikola', 'Zejak', 'REr 28/17', 3, 280464363, '1997-04-28', 0, 0, '0655833203', 'zeka97@gmail.com'),
(9, 'Strahinja', 'Zoran', 'Milosevic', 'REr 31/17', 3, 1807654642, '1998-07-18', 0, 0, '0602345255', 'strale.mi@gmail.com'),
(10, 'Stefan', 'Goran', 'Nikolic', 'REr 45/17', 3, 1101512251, '1996-01-11', 0, 0, '062523525', 'stefan.nikolic@gmail.com'),
(11, 'Momcilo', 'Miroslav', 'Krstic', 'REr 47/17', 3, 11062352523, '1998-06-11', 0, 0, '061263463', 'moma.krstic@gmail.com'),
(12, 'Milos', 'Goran', 'Milojevic', 'REr 48/17', 3, 202412421, '1998-02-02', 0, 0, '0662342003', 'milojevic@gmail.com'),
(13, 'Jovan', 'Aleksandar', 'Nedeljkovic', 'REr 60/17', 3, 2804523352, '1978-04-28', 0, 0, '0602350350', 'jocaned@gmail.com'),
(14, 'Nikola', 'Milan', 'Dimitrijevic', 'REr 65/17', 3, 1305214114, '1997-05-13', 0, 0, '061231135', 'nidzadim@gmail.com'),
(15, 'Luka', 'Dragan', 'Grujic', 'REr 27/17', 3, 1702000035, '1999-02-17', 0, 0, '0654063323', 'lukagru@gmail.com'),
(16, 'Vladimir', 'Miroslav', 'Todorovic', 'REr 62/17', 3, 12062352352, '1998-06-12', 0, 0, '0621515611', 'vlajceraketa@gmail.com'),
(17, 'Marina', 'Aleksandar', 'Stojanovic', 'REr 55/17', 3, 1212532523, '1996-12-12', 0, 0, '0662352533', 'marinas@gmail.com'),
(18, 'Filip', 'Dragan', 'Stojanovic', 'REr 56/17', 3, 20451521, '1996-04-02', 0, 0, '062353223', 'fica996@gmail.com'),
(19, 'Valentina', 'Slavisa', 'Markovic', 'REr 13/17', 3, 303102312, '1997-03-03', 0, 0, '062324523', 'vanjam@gmail.com'),
(20, 'Nenad', 'Marko', 'Boskovic', 'REr 29/17', 3, 1011632632, '1996-11-10', 0, 0, '060323232', 'nesabos@gmail.com'),
(21, 'Milena', 'Dragan', 'Tonic', 'REr 38/18', 2, 1204152521, '1999-04-12', 0, 0, '0602321551', 'tonicm@gmail.com'),
(22, 'Ivona', 'Milan', 'Milenovic', 'REr 15/18', 2, 1202552151, '1999-02-12', 0, 0, '062167432', 'ivonam@gmail.com'),
(23, 'Aleksa', 'Slavisa', 'Eric', 'REr 05/18', 2, 190743322, '1999-07-19', 0, 0, '06215774', 'a.eric@gmail.com'),
(24, 'Miljana', 'Mirko', 'Pejcic', 'REr 55/18', 2, 111512512, '1999-11-01', 0, 0, '062689921', 'pejcicm@gmail.com'),
(25, 'Teodora', 'Zoran', 'Mitic', 'REr 37/18', 2, 1212151521, '1999-12-12', 0, 0, '061992351', 'team@gmail.com'),
(26, 'Aleksa', 'Nenad', 'Ristic', 'REr 19/18', 2, 290345215, '1999-03-29', 0, 0, '065199932', 'aleksaristic@gmail.com'),
(27, 'Dusan', 'Danilo', 'Djordjevic', 'REr 1/18', 2, 2142141241, '1999-07-22', 0, 0, '061512521', 'ddusan@gmail.com'),
(28, 'Dusan', 'Dejan', 'Antic', 'REr 59/18', 2, 250523523, '1999-05-25', 0, 0, '06156735', 'duleantic@gmail.com'),
(29, 'Uros', 'Ivan', 'Novicic', 'REr 23/18', 2, 170265235, '1999-02-17', 0, 0, '062998632', 'urosn@gmail.com'),
(30, 'Martin', 'Zlatko', 'Stefanovic', 'REr 08/18', 2, 2205215412, '1999-05-22', 0, 0, '06212421', 'martins@gmail.com'),
(31, 'Milan', 'Danilo', 'Bogdanovic', 'REr 41/18', 2, 215125125, '1999-05-15', 0, 0, '062154125', 'miki@gmail.com'),
(32, 'Nikola', 'Slavisa', 'Vladimirovic', 'REr 63/18', 2, 5315215215, '1999-02-06', 0, 0, '0623525252', 'nikolav@gmail.com'),
(33, 'Tijana', 'Milan', 'Radivojevic', 'REr 04/18', 2, 2104215412, '1999-03-21', 0, 0, '062677332', 'tijanar@gmail.com'),
(34, 'Uros', 'Dragan', 'Simic', 'REr 2/18', 2, 5412521521, '1999-02-15', 0, 0, '061673234', 'simicu@gmail.com'),
(35, 'Stefan', 'Ivan', 'Manojlovic', 'REr 10/18', 2, 521521512, '1999-05-21', 0, 0, '0668544235', 'stefan.m@gmail.com'),
(36, 'Lazar', 'Miljan', 'Krmpot', 'REr 14/19', 1, 2121201021, '2000-01-22', 0, 0, '062532152', 'krmpot@gmail.com'),
(37, 'Bogdan', 'Zoran', 'Pesic', 'REr 18/19', 1, 112414120, '2000-11-11', 0, 0, '062515215', 'bogdan@gmail.com'),
(38, 'Mina', 'Dragan', 'Velickovic', 'REr 35/19', 1, 151510511, '2000-05-15', 0, 0, '062152151', 'minav@gmail.com'),
(39, 'Stefan', 'Danilo', 'Krstic', 'REr 13/19', 1, 2155215151, '2000-05-29', 0, 0, '0621312141', 'stefankrstic@gmail.com'),
(40, 'Marko', 'Nenad', 'Milutinovic', 'REr 1/19', 1, 5312521512, '2000-09-22', 0, 0, '063435653', 'markom@gmail.com'),
(41, 'Marko', 'Slavisa', 'Sagric', 'REr 44/19', 1, 5252152151, '2000-05-05', 0, 0, '0632312532', 'markosagric@gmail.com'),
(42, 'Natalija', 'Slavisa', 'Stojiljkovic', 'REr 07/19', 1, 2202023021, '2000-09-22', 0, 0, '06332623323', 'natas@gmail.com'),
(43, 'Kristina', 'Milan', 'Srejic', 'REr 57/19', 1, 5312523235, '2000-08-08', 0, 0, '0636747423', 'kikas@gmail.com'),
(44, 'Lazar', 'Slavisa', 'Krstic', 'REr 43/19', 1, 21521521521, '2000-01-11', 0, 0, '062623632', 'lazark@gmail.com'),
(45, 'Luka', 'Slavisa', 'Stankovic', 'REr 12/19', 1, 532152122, '2000-01-05', 0, 0, '06263272', 'luka@gmail.com'),
(46, 'Tea', 'Jovan', 'Bilic', 'REr 29/19', 1, 563253252, '2000-09-07', 0, 0, '062363262', 'teabilic@gmail.com'),
(47, 'Petra', 'Boban', 'Milosevic', 'REr 33/19', 1, 532532532, '2000-09-09', 0, 0, '06236873', 'petram@gmail.com'),
(48, 'Pavle', 'Slobodan', 'Jovanovic', 'REr 21/19', 1, 52523523, '2000-02-22', 0, 0, '06273833', 'pajajov@gmail.com'),
(49, 'Zarko', 'Sinisa', 'Zivkovic', 'REr 20/19', 1, 5623632623, '2000-06-08', 0, 0, '06284574', 'zarez@gmail.com'),
(50, 'Nevena', 'Aleksandar', 'Milivojevic', 'REr 05/19', 1, 252352525, '2000-06-06', 0, 0, '0628954654', 'nevena@gmail.com'),
(51, 'Maja', 'Nenad', 'Djokic', 'REr 04/19', 1, 532532532, '2000-03-08', 0, 0, '069235322', 'majadj@gmail.com');

--
-- Triggers `studenti`
--
DELIMITER $$
CREATE TRIGGER `brisanje_studenta` AFTER DELETE ON `studenti` FOR EACH ROW BEGIN
DELETE FROM ocene WHERE student_id=OLD.id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `promena_godina_studija` BEFORE UPDATE ON `studenti` FOR EACH ROW BEGIN
IF NEW.espb > 36 AND NEW.espb <= 60
THEN SET NEW.godina_studija = 2;
ELSEIF NEW.espb > 72 AND NEW.espb <= 120
THEN SET NEW.godina_studija = 3;
ELSEIF NEW.espb = 180
THEN SET NEW.godina_studija = 0;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `p_studenti_17`
--
DROP TABLE IF EXISTS `p_studenti_17`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `p_studenti_17`  AS  select `studenti`.`id` AS `id`,`studenti`.`ime` AS `ime`,`studenti`.`ime_roditelja` AS `ime_roditelja`,`studenti`.`prezime` AS `prezime`,`studenti`.`broj_indeksa` AS `broj_indeksa`,`studenti`.`godina_studija` AS `godina_studija`,`studenti`.`jmbg` AS `jmbg`,`studenti`.`datum_rodjenja` AS `datum_rodjenja`,`studenti`.`espb` AS `espb`,`studenti`.`prosek_ocena` AS `prosek_ocena`,`studenti`.`broj_telefona` AS `broj_telefona`,`studenti`.`email` AS `email` from `studenti` where `studenti`.`broj_indeksa` like '%/17' ;

-- --------------------------------------------------------

--
-- Structure for view `p_zavrsili_17`
--
DROP TABLE IF EXISTS `p_zavrsili_17`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `p_zavrsili_17`  AS  select `p_studenti_17`.`id` AS `id`,`p_studenti_17`.`ime` AS `ime`,`p_studenti_17`.`ime_roditelja` AS `ime_roditelja`,`p_studenti_17`.`prezime` AS `prezime`,`p_studenti_17`.`broj_indeksa` AS `broj_indeksa`,`p_studenti_17`.`godina_studija` AS `godina_studija`,`p_studenti_17`.`jmbg` AS `jmbg`,`p_studenti_17`.`datum_rodjenja` AS `datum_rodjenja`,`p_studenti_17`.`espb` AS `espb`,`p_studenti_17`.`prosek_ocena` AS `prosek_ocena`,`p_studenti_17`.`broj_telefona` AS `broj_telefona`,`p_studenti_17`.`email` AS `email` from `p_studenti_17` where `p_studenti_17`.`godina_studija` = 0 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisnici`
--
ALTER TABLE `korisnici`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ocene`
--
ALTER TABLE `ocene`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foreign` (`predmet_id`),
  ADD KEY `foreign_1` (`student_id`);

--
-- Indexes for table `predmeti`
--
ALTER TABLE `predmeti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studenti`
--
ALTER TABLE `studenti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisnici`
--
ALTER TABLE `korisnici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ocene`
--
ALTER TABLE `ocene`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `predmeti`
--
ALTER TABLE `predmeti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `studenti`
--
ALTER TABLE `studenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ocene`
--
ALTER TABLE `ocene`
  ADD CONSTRAINT `foreign` FOREIGN KEY (`predmet_id`) REFERENCES `predmeti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foreign_1` FOREIGN KEY (`student_id`) REFERENCES `studenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
