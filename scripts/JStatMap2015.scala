/*
 * Copyright 2019 Shimosaka Research Group, Tokyo Institute of Technology
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.github.mutsuhiro6.jstat.map.parser

import com.github.mutsuhiro6.jstat.map.parser.JStatMap2015.BorderPoint

/**
  * Created by iwamoto on 2019/12/04
  **/
object JStatMap2015 {

  case class BorderPoint(lat: Double, lng: Double, ptSize: Int)

  case class JStatMap2015Attr(
                               KEY: Long,
                               PREF: Long,
                               CITY: Long,
                               S_AREA: String,
                               PREF_NAME: String,
                               CITY_NAME: String,
                               S_NAME: String,
                               KIGO_E: Option[String],
                               HCODE: Long, // 8101: 町丁・字等, 8154: 水面調査区
                               AREA: Double,
                               PERIMETER: Double,
                               H27KAxx: Long,
                               H27KAxx_ID: Long,
                               KEN: Int,
                               KEN_NAME: String,
                               SITYO_NAME: Option[String],
                               GST_NAME: String,
                               CSS_NAME: String,
                               KIHON1: String,
                               DUMMY1: String = "-",
                               KIHON2: String,
                               KEYCODE1: String,
                               KEYCODE2: String,
                               AREA_MAX_F: String,
                               KIGO_D: Option[String],
                               N_KEN: Option[String],
                               N_CITY: Option[String],
                               KIGO_I: Option[String],
                               MOJI: String,
                               KBSUM: Long,
                               JINKO: Long,
                               SETAI: Long,
                               X_CODE: Double,
                               Y_CODE: Double,
                               KCODE1: String
                             ) {
    require(KIHON1 + DUMMY1 + KIHON2 == KCODE1)
  }


}

case class JStatMap2015(attr: JStatMap2015Attr, borderPts: Array[BorderPoint]) {

  val placeName: String = {
    attr.PREF_NAME + attr.CITY_NAME + attr.S_NAME
  }

  val center: Point = Point(attr.Y_CODE, attr.X_CODE)

  val polygon: Polygon[String] = {
    val points = borderPts
      .map {
        case BorderPoint(lat, lng, _) =>
          Point(lat, lng)
      }
    Polygon(placeName, points)
  }

}
