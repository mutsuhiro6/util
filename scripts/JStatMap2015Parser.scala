package com.github.mutsuhiro6.jstat.map.parser

import com.github.mutsuhiro6.jstat.map.parser.JStatMap2015.JStatMap2015Attr

/**
  * Created by iwamoto on 2019/12/04
  **/
object JStatMap2015Parser {

  def loadData(path: String): Seq[JStatMap2015] = {

    val kml = XML.loadFile(path)

    (kml \\ "Placemark")
      .map {
        elm =>
          val attr = {
            val parsed = (elm \\ "ExtendedData").text
              .split("\n")
              .drop(2)
              .dropRight(2)
              .map(_.trim)

            JStatMap2015Attr(
              parsed(0).toLong,
              parsed(1).toLong,
              parsed(2).toLong,
              parsed(3),
              parsed(4),
              parsed(5),
              parsed(6),
              parseEmptyString(parsed(7)),
              parsed(8).toLong,
              parsed(9).toDouble,
              parsed(10).toDouble,
              parsed(11).toLong,
              parsed(12).toLong,
              parsed(13).toInt,
              parsed(14),
              parseEmptyString(parsed(15)),
              parsed(16),
              parsed(17),
              parsed(18),
              parsed(19),
              parsed(20),
              parsed(21),
              parsed(22),
              parsed(23),
              parseEmptyString(parsed(24)),
              parseEmptyString(parsed(25)),
              parseEmptyString(parsed(26)),
              parseEmptyString(parsed(27)),
              parsed(28),
              parsed(29).toLong,
              parsed(30).toLong,
              parsed(31).toLong,
              parsed(32).toDouble,
              parsed(33).toDouble,
              parsed(34)
            )
          }
          val borderPts = (elm \\ "Polygon").text
            .split("\n")
            .map(_.trim)
            .filter(!_.isEmpty)
            .map {
              line =>
                val row = line.split(",")
                val lat = row(1).toDouble
                val lng = row(0).toDouble
                val ptSize = row(2).toInt
                BorderPoint(lat, lng, ptSize)
            }
          JStatMap2015(attr, borderPts)
      }
  }

  private def parseEmptyString(str: String): Option[String] = {

    str match {
      case "" => None
      case _ => Option(str)
    }

  }

}
