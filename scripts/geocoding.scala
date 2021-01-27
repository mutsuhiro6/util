import java.io.PrintWriter

import org.apache.commons.io.FileUtils
import org.miubiq.commons.util.gps.geo.Point
import scalaj.http._

import scala.collection.JavaConverters._
import scala.xml.XML



def parseDouble(str: String): Double = {
  try {
    str.toDouble
  }
  catch {
    case _: Exception =>
      Double.NaN
  }
}

case class GeocodingApiResponse(name: String, latLng: Point, verification: String) {
  override def toString: String = {
    s"$name,${latLng.lat},${latLng.lon},$verification"
  }
}

object GeocodingApiWrapper {

  def scraping(pois: Seq[String], path: String): Unit = {
    val pw = new PrintWriter(path)
    pw.println("POI name,latitude,longitude,need verification")
    for (poi <- pois) {
      Thread.sleep(15000)
      try {
		  val res = getXML(poi)
		  println(res)
        pw.println(res)
      }
      catch {
        case _: Exception =>
          pw.println(GeocodingApiResponse(poi, Point(Double.NaN, Double.NaN),"yes"))

      }
    }
    pw.close()
  }

  def getXML(poi: String): GeocodingApiResponse = {
    val res: HttpResponse[String] = Http("https://www.geocoding.jp/api/").param("q", poi).asString
    val xml = XML.loadString(res.body)
    val lat = parseDouble((xml \\ "lat").text)
    val lng = parseDouble((xml \\ "lng").text)
    val addr = (xml \\ "address").text
    val verification = (xml \\ "needs_to_verify").text // yes or no． no なら正しいと思って良さそう．
    GeocodingApiResponse(addr, Point(lat, lng), verification)
  }
}


val pois = FileUtils.readLines(new java.io.File("/Users/iwamoto/Documents/place_detail_2020.csv")).asScala.map {
    line =>
      val row = line.split(",")
      row(2)
  }
GeocodingApiWrapper.scraping(pois, "/Users/iwamoto/Downloads/geocoding_2020.txt")
