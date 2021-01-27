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

package org.miubiq.commons.analysis.yahoo.transit_raw_data_parser.util

import scala.sys.process.Process


/**
  * created by iwamoto on 2019/03/08
  */
object Unarchiver {

  sealed abstract class Archive extends Serializable {
    def extension: String

    def command(outputDir: String): String

    def unarchive(outputDir: String): Int = {
      val process = Process(command(outputDir)).run
      process.exitValue() // wait until the process finishes
    }
  }

  private class Zip(filePath: String) extends Archive {
    override def extension: String = ".zip"

    override def command(outputDir: String): String = s"unzip -oq $filePath -d $outputDir"
  }

  private class TarGz(filePath: String) extends Archive {
    override def extension: String = ".tar.gz"

    override def command(outputDir: String): String = s"tar xzf $filePath -C $outputDir"
  }

  private class Tar(filePath: String) extends Archive {
    override def extension: String = ".tar"

    override def command(outputDir: String): String = s"tar xf $filePath -C $outputDir"
  }

  private class GunZip(filePath: String) extends Archive {
    override def extension: String = ".gz"

    override def command(outputDir: String = null): String = s"gunzip $filePath"
  }

  private def identifyFileType(filePath: String): Archive = {
    if (filePath.endsWith(".zip")) new Zip(filePath)
    else if (filePath.endsWith(".tar.gz")) new TarGz(filePath)
    else if (filePath.endsWith(".gz")) new GunZip(filePath)
    else if (filePath.endsWith(".tar")) new Tar(filePath)
    else throw new UnarchiveException(s"$filePath has unknown extension.")
  }

  def unarchive(filePath: String, outputDir: String = null): Int = {
    val archive = identifyFileType(filePath)
    val commandExitValue = archive.unarchive(outputDir)
    if (commandExitValue != 0) throw new UnarchiveException("Unarchive command process error.")
    commandExitValue
  }

  private class UnarchiveException(message: String = null, cause: Throwable = null) extends RuntimeException(message, cause)

}
