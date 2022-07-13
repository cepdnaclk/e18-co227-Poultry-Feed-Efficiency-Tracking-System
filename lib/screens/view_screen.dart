import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_login/constants.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfchart;

class ViewScreen extends StatefulWidget {
   ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}



class _ViewScreenState extends State<ViewScreen> {


    

    List<BarChart> mortalityData = <BarChart>[];
    //List<PoultryData> weightDataCurrent=[PoultryData(0, 0)];
     List<PoultryData> weightDataCurrent= [];
    List<PoultryData> feedDataCurrent= [];
    List<PoultryData> weightDataStrain= [];
    List<PoultryData> feedtDataStrain= [];

    String strain='';
    int mortal=0;
    String totalChick='';
    int i=0,j=0,n=0;
    int state=0;

    Map<String, double> dataMap = {

    };

    final colorList = <Color>[
      //Colors.greenAccent,
      mPrimaryColor,
    ];


    //this is for testing
   final List<PoultryData> weightDataCobb500 =[
     PoultryData(0,  42),
     PoultryData(1,  63),
     PoultryData(2,  74),
     PoultryData(3,  90),
     PoultryData(4,  109),
     PoultryData(5,  134),
     PoultryData(6,  163),
     PoultryData(7,  193),
     PoultryData(8,  228),
     PoultryData(9,  269),
     PoultryData(10, 313),
     PoultryData(11, 362),
     PoultryData(12, 414),
     PoultryData(13, 469),
     PoultryData(14, 528),
     PoultryData(15, 589),
     PoultryData(16, 654),
     PoultryData(17, 722),
     PoultryData(18, 792),
     PoultryData(19, 865),
     PoultryData(20, 941),
     PoultryData(21, 1018),
     PoultryData(22, 1098),
     PoultryData(23, 1180),
     PoultryData(24, 1264),
     PoultryData(25, 1349),
     PoultryData(26, 1436),
     PoultryData(27, 1525),
     PoultryData(28, 1615),
     PoultryData(29, 1706),
     PoultryData(30, 1798),
     PoultryData(31, 1892),
     PoultryData(32, 1986),
     PoultryData(33, 2081),
     PoultryData(34, 2177),
     PoultryData(35, 2273),
     PoultryData(36, 2369),
     PoultryData(37, 2466),
     PoultryData(38, 2563),
     PoultryData(39, 2661),
     PoultryData(40, 2758),
     PoultryData(41, 2855),
     PoultryData(42, 2952),
     PoultryData(43, 3049),
     PoultryData(44, 3145),
     PoultryData(45, 3240),
     PoultryData(46, 3335),
     PoultryData(47, 3430),
     PoultryData(48, 3524),
     PoultryData(49, 3617),
     PoultryData(50, 3707),
     PoultryData(51, 3797),
     PoultryData(52, 3885),
     PoultryData(53, 3973),
     PoultryData(54, 4059),
     PoultryData(55, 4144),
     PoultryData(56, 4227),
     PoultryData(57, 4309),
     PoultryData(58, 4389),
     PoultryData(59, 4466),
     PoultryData(60, 4542),
     PoultryData(61, 4616),
     PoultryData(62, 4688),
     PoultryData(63, 4759),

   ];






  final List<PoultryData> feedDataCobb500 =[

    PoultryData(8,  37),
    PoultryData(9,  43),
    PoultryData(10, 50),
    PoultryData(11, 57),
    PoultryData(12, 64),
    PoultryData(13, 72),
    PoultryData(14, 74),
    PoultryData(15, 78),
    PoultryData(16, 85),
    PoultryData(17, 91),
    PoultryData(18, 103),
    PoultryData(19, 110),
    PoultryData(20, 114),
    PoultryData(21, 118),
    PoultryData(22, 123),
    PoultryData(23, 128),
    PoultryData(24, 133),
    PoultryData(25, 137),
    PoultryData(26, 144),
    PoultryData(27, 150),
    PoultryData(28, 156),
    PoultryData(29, 160),
    PoultryData(30, 164),
    PoultryData(31, 167),
    PoultryData(32, 170),
    PoultryData(33, 174),
    PoultryData(34, 177),
    PoultryData(35, 179),
    PoultryData(36, 182),
    PoultryData(37, 186),
    PoultryData(38, 190),
    PoultryData(39, 193),
    PoultryData(40, 197),
    PoultryData(41, 203),
    PoultryData(42, 208),
    PoultryData(43, 213),
    PoultryData(44, 218),
    PoultryData(45, 224),
    PoultryData(46, 228),
    PoultryData(47, 231),
    PoultryData(48, 236),
    PoultryData(49, 241),
    PoultryData(50, 243),
    PoultryData(51, 244),
    PoultryData(52, 245),
    PoultryData(53, 247),
    PoultryData(54, 247),
    PoultryData(55, 246),
    PoultryData(56, 245),
    PoultryData(57, 243),
    PoultryData(58, 241),
    PoultryData(59, 239),
    PoultryData(60, 237),
    PoultryData(61, 234),
    PoultryData(62, 232),
    PoultryData(63, 228),


  ];


    final List<PoultryData> weightDataRoss308 =[
      PoultryData(0,  43),
      PoultryData(1,  61),
      PoultryData(2,  79),
      PoultryData(3,  99),
      PoultryData(4,  122),
      PoultryData(5,  148),
      PoultryData(6,  176),
      PoultryData(7,  208),
      PoultryData(8,  242),
      PoultryData(9,  280),
      PoultryData(10, 321),
      PoultryData(11, 366),
      PoultryData(12, 414),
      PoultryData(13, 465),
      PoultryData(14, 519),
      PoultryData(15, 576),
      PoultryData(16, 637),
      PoultryData(17, 701),
      PoultryData(18, 768),
      PoultryData(19, 837),
      PoultryData(20, 910),
      PoultryData(21, 985),
      PoultryData(22, 1062),
      PoultryData(23, 1142),
      PoultryData(24, 1225),
      PoultryData(25, 1309),
      PoultryData(26, 1395),
      PoultryData(27, 1483),
      PoultryData(28, 1573),
      PoultryData(29, 1664),
      PoultryData(30, 1757),
      PoultryData(31, 1851),
      PoultryData(32, 1946),
      PoultryData(33, 2041),
      PoultryData(34, 2138),
      PoultryData(35, 2235),
      PoultryData(36, 2332),
      PoultryData(37, 2430),
      PoultryData(38, 2527),
      PoultryData(39, 2625),
      PoultryData(40, 2723),
      PoultryData(41, 2821),
      PoultryData(42, 2918),
      PoultryData(43, 3015),
      PoultryData(44, 3112),
      PoultryData(45, 3207),
      PoultryData(46, 3303),
      PoultryData(47, 3397),
      PoultryData(48, 3491),
      PoultryData(49, 3583),
      PoultryData(50, 3675),
      PoultryData(51, 3766),
      PoultryData(52, 3856),
      PoultryData(53, 3944),
      PoultryData(54, 4032),
      PoultryData(55, 4118),
      PoultryData(56, 4203),
      PoultryData(57, 4286),
      PoultryData(58, 4369),
      PoultryData(59, 4450),
      PoultryData(60, 4530),
      PoultryData(61, 4608),
      PoultryData(62, 4685),
      PoultryData(63, 4760),
      PoultryData(64, 4835),
      PoultryData(65, 4907),
      PoultryData(66, 4979),
      PoultryData(67, 5049),
      PoultryData(68, 5117),
      PoultryData(69, 5184),
      PoultryData(70, 5250),

    ];


    final List<PoultryData> feedDataRoss308 =[

      PoultryData(2,  17),
      PoultryData(3,  21),
      PoultryData(4,  24),
      PoultryData(5,  28),
      PoultryData(6,  32),
      PoultryData(7,  36),
      PoultryData(8,  40),
      PoultryData(9,  45),
      PoultryData(10, 49),
      PoultryData(11, 54),
      PoultryData(12, 58),
      PoultryData(13, 63),
      PoultryData(14, 69),
      PoultryData(15, 74),
      PoultryData(16, 79),
      PoultryData(17, 85),
      PoultryData(18, 90),
      PoultryData(19, 96),
      PoultryData(20, 102),
      PoultryData(21, 108),
      PoultryData(22, 114),
      PoultryData(23, 120),
      PoultryData(24, 125),
      PoultryData(25, 131),
      PoultryData(26, 137),
      PoultryData(27, 143),
      PoultryData(28, 149),
      PoultryData(29, 154),
      PoultryData(30, 160),
      PoultryData(31, 165),
      PoultryData(32, 170),
      PoultryData(33, 175),
      PoultryData(34, 180),
      PoultryData(35, 185),
      PoultryData(36, 189),
      PoultryData(37, 194),
      PoultryData(38, 198),
      PoultryData(39, 202),
      PoultryData(40, 206),
      PoultryData(41, 209),
      PoultryData(42, 213),
      PoultryData(43, 216),
      PoultryData(44, 219),
      PoultryData(45, 222),
      PoultryData(46, 224),
      PoultryData(47, 227),
      PoultryData(48, 229),
      PoultryData(49, 231),
      PoultryData(50, 233),
      PoultryData(51, 235),
      PoultryData(52, 236),
      PoultryData(53, 238),
      PoultryData(54, 239),
      PoultryData(55, 240),
      PoultryData(56, 241),
      PoultryData(57, 241),
      PoultryData(58, 242),
      PoultryData(59, 242),
      PoultryData(60, 242),
      PoultryData(61, 242),
      PoultryData(62, 242),
      PoultryData(63, 242),
      PoultryData(64, 242),
      PoultryData(65, 242),
      PoultryData(66, 241),
      PoultryData(67, 240),
      PoultryData(68, 240),
      PoultryData(69, 239),
      PoultryData(70, 238),



    ];


    final List<PoultryData> weightDataDekalbWhite =[

      PoultryData(1,  59),
      PoultryData(2,  117),
      PoultryData(3,  119),
      PoultryData(4,  263),
      PoultryData(5,  336),
      PoultryData(6,  414),
      PoultryData(7,  492),
      PoultryData(8,  575),
      PoultryData(9,  653),
      PoultryData(10, 731),
      PoultryData(11, 809),
      PoultryData(12, 887),
      PoultryData(13, 956),
      PoultryData(14, 1024),
      PoultryData(15, 1087),
      PoultryData(16, 1146),
      PoultryData(17, 1199),
      PoultryData(18, 1275),
      PoultryData(19, 1335),
      PoultryData(20, 1395),
      PoultryData(21, 1470),
      PoultryData(22, 1520),
      PoultryData(23, 1555),
      PoultryData(24, 1575),
      PoultryData(25, 1590),
      PoultryData(26, 1605),
      PoultryData(27, 1615),
      PoultryData(28, 1625),
      PoultryData(29, 1633),
      PoultryData(30, 1640),
      PoultryData(31, 1644),
      PoultryData(32, 1648),
      PoultryData(33, 1652),
      PoultryData(34, 1656),
      PoultryData(35, 1660),
      PoultryData(36, 1663),
      PoultryData(37, 1666),
      PoultryData(38, 1669),
      PoultryData(39, 1672),
      PoultryData(40, 1675),
      PoultryData(41, 1677),
      PoultryData(42, 1679),
      PoultryData(43, 1681),
      PoultryData(44, 1683),
      PoultryData(45, 1685),
      PoultryData(46, 1686),
      PoultryData(47, 1687),
      PoultryData(48, 1688),
      PoultryData(49, 1689),
      PoultryData(50, 1619),
      PoultryData(51, 1691),
      PoultryData(52, 1692),
      PoultryData(53, 1693),
      PoultryData(54, 1694),
      PoultryData(55, 1695),
      PoultryData(56, 1696),
      PoultryData(57, 1697),
      PoultryData(58, 1698),
      PoultryData(59, 1699),
      PoultryData(60, 1700),
      PoultryData(61, 1701),
      PoultryData(62, 1702),
      PoultryData(63, 1703),
      PoultryData(64, 1704),
      PoultryData(65, 1705),
      PoultryData(66, 1706),
      PoultryData(67, 1707),
      PoultryData(68, 1708),
      PoultryData(69, 1709),
      PoultryData(70, 1710),
      PoultryData(71, 1711),
      PoultryData(72, 1712),
      PoultryData(73, 1713),
      PoultryData(74, 1714),
      PoultryData(75, 1715),
      PoultryData(76, 1716),
      PoultryData(77, 1717),
      PoultryData(78, 1718),
      PoultryData(79, 1719),
      PoultryData(80, 1720),
      PoultryData(81, 1721),
      PoultryData(82, 1722),
      PoultryData(83, 1723),
      PoultryData(84, 1724),
      PoultryData(85, 1725),
      PoultryData(86, 1725),
      PoultryData(87, 1725),
      PoultryData(88, 1725),
      PoultryData(89, 1725),
      PoultryData(90, 1725),
      PoultryData(91, 1725),
      PoultryData(92, 1725),
      PoultryData(93, 1725),
      PoultryData(94, 1725),
      PoultryData(95, 1725),
      PoultryData(96, 1725),
      PoultryData(97, 1725),
      PoultryData(98, 1725),
      PoultryData(99, 1725),
      PoultryData(100, 1725),


    ];

    final List<PoultryData> feedDataDekalbWhite =[

      PoultryData(1,  56),
      PoultryData(2,  147),
      PoultryData(3,  280),
      PoultryData(4,  448),
      PoultryData(5,  651),
      PoultryData(6,  889),
      PoultryData(7,  1162),
      PoultryData(8,  1463),
      PoultryData(9,  1785),
      PoultryData(10, 2128),
      PoultryData(11, 2492),
      PoultryData(12, 2877),
      PoultryData(13, 3283),
      PoultryData(14, 3710),
      PoultryData(15, 4158),
      PoultryData(16, 4627),
      PoultryData(17, 5124),
      PoultryData(18, 5663),
      PoultryData(19, 500),
      PoultryData(20, 1100),
      PoultryData(21, 1800),
      PoultryData(22, 2400),
      PoultryData(23, 3100),
      PoultryData(24, 3800),
      PoultryData(25, 4500),
      PoultryData(26, 5300),
      PoultryData(27, 6500),
      PoultryData(28, 6800),
      PoultryData(29, 7500),
      PoultryData(30, 8300),
      PoultryData(31, 9000),
      PoultryData(32, 9800),
      PoultryData(33, 10600),
      PoultryData(34, 11300),
      PoultryData(35, 12100),
      PoultryData(36, 12900),
      PoultryData(37, 13600),
      PoultryData(38, 14400),
      PoultryData(39, 15300),
      PoultryData(40, 15900),
      PoultryData(41, 16700),
      PoultryData(42, 17400),
      PoultryData(43, 18200),
      PoultryData(44, 19000),
      PoultryData(45, 19700),
      PoultryData(46, 20500),
      PoultryData(47, 21200),
      PoultryData(48, 22000),
      PoultryData(49, 22800),
      PoultryData(50, 23500),
      PoultryData(51, 24300),
      PoultryData(52, 25000),
      PoultryData(53, 25800),
      PoultryData(54, 26500),
      PoultryData(55, 27300),
      PoultryData(56, 28100),
      PoultryData(57, 28800),
      PoultryData(58, 29600),
      PoultryData(59, 30300),
      PoultryData(60, 31100),
      PoultryData(61, 31800),
      PoultryData(62, 32600),
      PoultryData(63, 33300),
      PoultryData(64, 34100),
      PoultryData(65, 34800),
      PoultryData(66, 35600),
      PoultryData(67, 36300),
      PoultryData(68, 37100),
      PoultryData(69, 37800),
      PoultryData(70, 38500),
      PoultryData(71, 39300),
      PoultryData(72, 40000),
      PoultryData(73, 40800),
      PoultryData(74, 41500),
      PoultryData(75, 42300),
      PoultryData(76, 43300),
      PoultryData(77, 43700),
      PoultryData(78, 44500),
      PoultryData(79, 45200),
      PoultryData(80, 46000),
      PoultryData(81, 46700),
      PoultryData(82, 47400),
      PoultryData(83, 48200),
      PoultryData(84, 48900),
      PoultryData(85, 49700),
      PoultryData(86, 50400),
      PoultryData(87, 51100),
      PoultryData(88, 51900),
      PoultryData(89, 52600),
      PoultryData(90, 53300),
      PoultryData(91, 54100),
      PoultryData(92, 54800),
      PoultryData(93, 55500),
      PoultryData(94, 56300),
      PoultryData(95, 57000),
      PoultryData(96, 57700),
      PoultryData(97, 58400),
      PoultryData(98, 59200),
      PoultryData(99, 59900),
      PoultryData(100,60600),


    ];

    final List<PoultryData> feedDataShavorBrown =[


      PoultryData(1,  11),
      PoultryData(2,  17),
      PoultryData(3,  25),
      PoultryData(4,  32),
      PoultryData(5,  37),
      PoultryData(6,  42),
      PoultryData(7,  46),
      PoultryData(8,  50),
      PoultryData(9,  54),
      PoultryData(10, 58),
      PoultryData(11, 61),
      PoultryData(12, 64),
      PoultryData(13, 67),
      PoultryData(14, 70),
      PoultryData(15, 73),
      PoultryData(16, 76),
      PoultryData(17, 80),
      PoultryData(18, 87),
      PoultryData(19, 92),
      PoultryData(20, 101),
      PoultryData(21, 108),
      PoultryData(22, 111),
      PoultryData(23, 112),
      PoultryData(24, 113),
      PoultryData(25, 114),
      PoultryData(26, 114),
      PoultryData(27, 114),
      PoultryData(28, 114),
      PoultryData(29, 114),
      PoultryData(30, 114),
      PoultryData(31, 115),
      PoultryData(32, 115),
      PoultryData(33, 115),
      PoultryData(34, 115),
      PoultryData(35, 115),
      PoultryData(36, 115),
      PoultryData(37, 115),
      PoultryData(38, 115),
      PoultryData(39, 115),
      PoultryData(40, 115),
      PoultryData(41, 115),
      PoultryData(42, 115),
      PoultryData(43, 115),
      PoultryData(44, 115),
      PoultryData(45, 115),
      PoultryData(46, 115),
      PoultryData(47, 115),
      PoultryData(48, 115),
      PoultryData(49, 115),
      PoultryData(50, 115),
      PoultryData(51, 115),
      PoultryData(52, 115),
      PoultryData(53, 115),
      PoultryData(54, 115),
      PoultryData(55, 115),
      PoultryData(56, 115),
      PoultryData(57, 115),
      PoultryData(58, 115),
      PoultryData(59, 115),
      PoultryData(60, 115),
      PoultryData(61, 115),
      PoultryData(62, 115),
      PoultryData(63, 115),
      PoultryData(64, 115),
      PoultryData(65, 115),
      PoultryData(66, 115),
      PoultryData(67, 115),
      PoultryData(68, 116),
      PoultryData(69, 116),
      PoultryData(70, 116),
      PoultryData(71, 116),
      PoultryData(72, 116),
      PoultryData(73, 116),
      PoultryData(74, 116),
      PoultryData(75, 116),
      PoultryData(76, 116),
      PoultryData(77, 116),
      PoultryData(78, 116),
      PoultryData(79, 116),
      PoultryData(80, 116),
      PoultryData(81, 116),
      PoultryData(82, 116),
      PoultryData(83, 116),
      PoultryData(84, 116),
      PoultryData(85, 116),
      PoultryData(86, 116),
      PoultryData(87, 116),
      PoultryData(88, 116),
      PoultryData(89, 116),
      PoultryData(90, 116),



    ];

    final List<PoultryData> weightDataShaverBrown =[

      PoultryData(1,  60),
      PoultryData(2,  120),
      PoultryData(3,  190),
      PoultryData(4,  275),
      PoultryData(5,  360),
      PoultryData(6,  450),
      PoultryData(7,  540),
      PoultryData(8,  630),
      PoultryData(9,  720),
      PoultryData(10, 810),
      PoultryData(11, 900),
      PoultryData(12, 1000),
      PoultryData(13, 1095),
      PoultryData(14, 1180),
      PoultryData(15, 1265),
      PoultryData(16, 1350),
      PoultryData(17, 1425),
      PoultryData(18, 1550),
      PoultryData(19, 1600),
      PoultryData(20, 1660),
      PoultryData(21, 1720),
      PoultryData(22, 1750),
      PoultryData(23, 1770),
      PoultryData(24, 1790),
      PoultryData(25, 1810),
      PoultryData(26, 1820),
      PoultryData(27, 1830),
      PoultryData(28, 1840),
      PoultryData(29, 1850),
      PoultryData(30, 1860),
      PoultryData(31, 1870),
      PoultryData(32, 1875),
      PoultryData(33, 1880),
      PoultryData(34, 1885),
      PoultryData(35, 1890),
      PoultryData(36, 1890),
      PoultryData(37, 1895),
      PoultryData(38, 1895),
      PoultryData(39, 1900),
      PoultryData(40, 1900),
      PoultryData(41, 1905),
      PoultryData(42, 1905),
      PoultryData(43, 1905),
      PoultryData(44, 1910),
      PoultryData(45, 1910),
      PoultryData(46, 1910),
      PoultryData(47, 1910),
      PoultryData(48, 1910),
      PoultryData(49, 1910),
      PoultryData(50, 1910),
      PoultryData(51, 1910),
      PoultryData(52, 1920),
      PoultryData(53, 1920),
      PoultryData(54, 1920),
      PoultryData(55, 1920),
      PoultryData(56, 1920),
      PoultryData(57, 1920),
      PoultryData(58, 1930),
      PoultryData(59, 1930),
      PoultryData(60, 1930),
      PoultryData(61, 1930),
      PoultryData(62, 1930),
      PoultryData(63, 1930),
      PoultryData(64, 1930),
      PoultryData(65, 1930),
      PoultryData(66, 1940),
      PoultryData(67, 1940),
      PoultryData(68, 1940),
      PoultryData(69, 1940),
      PoultryData(70, 1940),
      PoultryData(71, 1940),
      PoultryData(72, 1940),
      PoultryData(73, 1940),
      PoultryData(74, 1950),
      PoultryData(75, 1950),
      PoultryData(76, 1950),
      PoultryData(77, 1950),
      PoultryData(78, 1950),
      PoultryData(79, 1950),
      PoultryData(80, 1950),
      PoultryData(81, 1950),
      PoultryData(82, 1960),
      PoultryData(83, 1960),
      PoultryData(84, 1960),
      PoultryData(85, 1960),
      PoultryData(86, 1960),
      PoultryData(87, 1970),
      PoultryData(88, 1970),
      PoultryData(89, 1970),
      PoultryData(90, 1970),



    ];












/*
   final List<PoultryData> feedDataCurrent =[

     PoultryData(8,  44),
     PoultryData(9,  55),
     PoultryData(10, 70),

   ];

 */

  @override
  Widget build(BuildContext context) {


    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;





    return Scaffold(



        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Poultry Analysis'),
            backgroundColor: mPrimaryColor,

          ),
        body: SingleChildScrollView(
          child: Column(




            children: [


          //to compare the strain
          StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .where(FieldPath.documentId, isEqualTo: args.flockID)
              .snapshots(), // your stream url,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              //print(snapshot.toString());
              strain = snapshot.data?.docs[0]['strain'].trim();
              //print(strain);
              // print(strain);
              if(strain == 'Cobb 500 - Broiler'){
                weightDataStrain = weightDataCobb500;
                feedtDataStrain = feedDataCobb500;
              }
              else if(strain == 'Ross 308 - Broiler'){
                weightDataStrain = weightDataRoss308;
                feedtDataStrain = feedDataRoss308;

              }
              else if(strain == 'Dekalb White - Layer'){
                weightDataStrain = weightDataDekalbWhite;
                feedtDataStrain = feedDataDekalbWhite;

              }
              else if(strain == 'Shaver Brown - Layer'){
                weightDataStrain = weightDataShaverBrown;
                feedtDataStrain = feedDataShavorBrown;

              }


            }

            //var color = 0xff453658;
            var color = 0xffd16fb2;

            return Container(
              height: 0,
            ); // Your grid code.
          }
          ),


              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(args.flockID)
                      .collection('BodyWeight')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {


                      List<String> flockItems;
                      //late final List <ChartData> weightDataCurrent;

                      //final Map<String, int> someMap = {

                      //};
                      for (i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];

                        double amount = -1;
                        String date;
                        try {
                          amount = snapshot.data?.docs[i]['Average_Weight'];
                          date = snapshot.data!.docs[i].id;
                          //print(snapshot.data!.docs[i].id);
                          //print(i);
                          //print(amount);
                          //print('');
                          weightDataCurrent.add(PoultryData(i, amount));

                          amount=0.0;
                        } catch (e) {
                          amount = -1;
                        }

                      }
                      //print(flockItems);
                      return Container(
                        height: 400,
                        margin: EdgeInsets.all(10),
                        child:  sfchart.SfCartesianChart(
                          legend: sfchart.Legend(isVisible: true, position :sfchart.LegendPosition.bottom ),

                          title: sfchart.ChartTitle(text: 'Weight performance'),
                          series: <sfchart.ChartSeries>[
                            sfchart.LineSeries<PoultryData,int>(
                              legendItemText: 'Active Batch',
                              //color: Colors.deepOrange ,
                              color: mPrimaryColor,
                              dataSource: weightDataCurrent,

                              xValueMapper: (PoultryData chick, _)=> chick.day,
                              yValueMapper: (PoultryData chick, _)=> chick.amount,

                            ),
                            sfchart.LineSeries<PoultryData,int>(
                              legendItemText: 'Ideal $strain',
                              color: Colors.orange ,
                              dataSource: weightDataStrain.sublist(0,i),
                              xValueMapper: (PoultryData chick, _)=> chick.day,
                              yValueMapper: (PoultryData chick, _)=> chick.amount,

                            ),
                          ],
                        ),

                      );
                    }
                  }),


              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(args.flockID)
                      .collection('FeedIntake')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {


                      //List<String> flockItems;
                      //late final List <ChartData> weightDataCurrent;

                      //final Map<String, int> someMap = {

                      //};
                      for ( j = 0; j < snapshot.data!.docs.length; j++) {
                        DocumentSnapshot snap = snapshot.data!.docs[j];

                        double amntbags= -1.0;
                        double amntKilo= -1.0;
                        String date;
                        //String Strdouble;
                        try {

                          print(snapshot.data!.docs[j].id);
                          amntbags = snapshot.data?.docs[j]['Number_of_bags'];
                          amntKilo = snapshot.data?.docs[j]['Weight_of_a_bag'] ;
                          date = snapshot.data!.docs[j].id;
                          //print(snapshot.data!.docs[j].id);
                          //print(j);
                          //print(amntbags);
                          //print(amntKilo);
                          print('');
                          double product= amntKilo * amntbags;
                          print(product);
                          int k=j+8;
                          feedDataCurrent.add(PoultryData(k , product));


                          amntbags=0.0;
                          amntKilo=0.0;

                        } catch (e) {
                          amntKilo = -1.0;
                          amntbags = -1.0;

                        }

                      }
                      //print(flockItems);
                      return Container(
                        height: 400,
                        margin: EdgeInsets.all(10),
                        child:  sfchart.SfCartesianChart(
                          legend: sfchart.Legend(isVisible: true, position :sfchart.LegendPosition.bottom ),

                          title: sfchart.ChartTitle(text: 'Feed Performance'),
                          series: <sfchart.ChartSeries>[
                            sfchart.LineSeries<PoultryData,int>(
                              legendItemText: 'Active Batch',
                              //color: Colors.deepOrange ,
                              color: mPrimaryColor,
                              dataSource: feedDataCurrent,
                              xValueMapper: (PoultryData chick, _)=> chick.day,
                              yValueMapper: (PoultryData chick, _)=> chick.amount,

                            ),
                            sfchart.LineSeries<PoultryData,int>(

                              legendItemText: 'Ideal $strain',
                              color: Colors.orange,
                              dataSource: feedtDataStrain.sublist(0,j),
                              xValueMapper: (PoultryData chick, _)=> chick.day,
                              yValueMapper: (PoultryData chick, _)=> chick.amount,

                            ),
                          ],
                        ),
                      );
                    }
                  }),


              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Farmers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .doc(args.flockID)
                      .collection('Mortality')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {


                      //List<String> flockItems;
                      //late final List <ChartData> weightDataCurrent;

                      //final Map<String, int> someMap = {

                      //};
                      for ( n = 0; n < snapshot.data!.docs.length; n++) {
                        DocumentSnapshot snap = snapshot.data!.docs[n];

                        int mortalamnt = -1;
                        int mortalDate = -1;
                        //String Strdouble;
                        try {

                          //print(snapshot.data!.docs[j].id);
                          mortalamnt = snapshot.data?.docs[n]['Amount'];

                         // mortalDate = snapshot.data!.docs[n];
                          //print(snapshot.data!.docs[j].id);
                          //print(j);
                          //print(amntbags);
                          //print(amntKilo);

                          mortalityData.add(BarChart( n , mortalamnt));




                        } catch (e) {

                          mortalamnt = -1;

                        }

                      }
                      //print(flockItems);
                      return Container(


                        height: 400,
                        margin: EdgeInsets.all(10),
                          child: sfchart.SfCartesianChart(

                              title: sfchart.ChartTitle(text: 'Mortility On Daily basis'),

                              legend:sfchart. Legend(isVisible: true, position :sfchart.LegendPosition.bottom ),
                              series: <sfchart.ChartSeries>[
                                sfchart.BarSeries<BarChart, int>(
                                    legendItemText: 'Death Count',
                                    dataSource: mortalityData,
                                    xValueMapper: (BarChart data, _) => data.date,
                                    yValueMapper: (BarChart data, _) => data.amount,
                                    // Width of the bars
                                    width: 1,
                                    // Spacing between the bars
                                    spacing: 0.5,
                                     borderRadius: BorderRadius.all(Radius.circular(15)),
                                     color: mPrimaryColor,
                                )
                              ]
                          )
                      );
                    }
                  }),


              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Farmers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('flock')
                      .where(FieldPath.documentId, isEqualTo: args.flockID)
                      .snapshots(), // your stream url,
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      //print(snapshot.toString());
                      mortal = snapshot.data?.docs[0]['Mortal'];
                      totalChick = snapshot.data?.docs[0]['count'];
                      print(mortal);
                      print(totalChick);

                      dataMap['Mortality']=mortal.toDouble();
                    }

                    return Container(


                      //padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(top: 20),

                      child: Column(
                       children: [
                         Text("Mortality as a Percantage of Population",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
                         Container(
                           margin: EdgeInsets.only(top: 20),
                           child: PieChart(
                             dataMap: dataMap,
                             chartType: ChartType.ring,
                             legendOptions: LegendOptions(legendPosition: LegendPosition.right, legendTextStyle: TextStyle(color: mPrimaryTextColor)),
                             baseChartColor: mPrimaryColor.withOpacity(0.7),
                             chartRadius: 180,
                             ringStrokeWidth: 20,
                             chartLegendSpacing: 30,
                             centerTextStyle: TextStyle(color: mPrimaryTextColor),
                             centerText: "Population",


                             //baseChartColor: mPrimaryColor,
                             colorList: colorList,

                             chartValuesOptions: const ChartValuesOptions(
                               showChartValuesInPercentage: true,
                             ),
                             totalValue: double.parse(totalChick),
                           ),

                         )
                       ],

                      ),
                     /*
                      child: PieChart(
                        dataMap: dataMap,
                        chartType: ChartType.ring,
                        legendOptions: LegendOptions(legendPosition: LegendPosition.right, legendTextStyle: TextStyle(color: mPrimaryTextColor)),
                        baseChartColor: mPrimaryColor.withOpacity(0.7),
                        chartRadius: 180,
                        ringStrokeWidth: 20,
                        chartLegendSpacing: 30,
                        centerTextStyle: TextStyle(color: mPrimaryTextColor),
                        centerText: "Population",


                        //baseChartColor: mPrimaryColor,
                        colorList: colorList,

                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        totalValue: double.parse(totalChick),
                      ),
                      */




                    );
                  }
                  ),




            ],
          ),
        )
    );


  }
}

class PoultryData{
  final double amount;
  final int day;


  PoultryData(this.day,this.amount);
}

// Class for chart data source, this can be modified based on the data in Firestore
class BarChart {
  final int amount;
  final int date;

  BarChart(this.date,this.amount);



}
  