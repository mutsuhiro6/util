git checkout develop                                                                                                                                                         \
&& git checkout -b feature/bump_miubiq_build_plugin_from_1.9.4_to_2.0.1                                                                                                      \
&& ./gradlew wrapper --gradle-version=5.6.4                                                                                                                                     \
&& git add gradlew                                                                                                                                                              \
&& git add gradlew.bat                                                                                                                                                          \
&& git add gradle/wrapper/gradle-wrapper.jar                                                                                                                                    \
&& git add gradle/wrapper/gradle-wrapper.properties                                                                                                                             \
&& git commit -m "automatic update by gradle task"                                                                                                                              \
&& sed -i "" -e 's/classpath \"gradle\.plugin\.org\.miubiq:miubiq-build-plugin:1\.9\.4\"/classpath \"gradle\.plugin\.org\.miubiq:miubiq-build-plugin:2\.0\.1\"/g' build.gradle  \
&& git add build.gradle                                                                                                                                                         \
&& git commit -m "bump miubiq build plugin version from 1.9.4 to 2.0.1"                                                                                                         \
&& sed -i "" -e "/^[ ]*classpath [\"\']com\.github\.ben-manes:gradle-versions-plugin:0\.13\.0[\"\']$/d" build.gradle                                                            \
&& sed -i "" -e "/^apply plugin: [\'\"]com\.github\.ben-manes\.versions[\'\"]/d" build.gradle                                                                                   \
&& git add build.gradle                                                                                                                                                         \
&& git commit -m "delete classpath and unapply gradle versions plugin"                                                                                                          \
&& echo "          - ./gradlew automatePostProc" >> bitbucket-pipelines.yml                                                                                                     \
&& git add bitbucket-pipelines.yml                                                                                                                                              \
&& git commit -m "add automator task"                                                                                                                                           \
&& sed -i "" -e "s/^image: java:8/image: openjdk:8/g" bitbucket-pipelines.yml                                                                                                  \
&& git add bitbucket-pipelines.yml                                                                                                                                              \
&& git commit -m "use openjdk:8 docker image instead of java:8"                                                                                                                \
&& stree .                                                                                                                                                                      \
