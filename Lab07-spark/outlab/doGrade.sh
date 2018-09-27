#!/bin/bash
shopt -s expand_aliases
alias errcho=">&2 echo -e"

#common global paths
dump="/dev/null"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7B Spark Assignment (Take Home)-64791" )"
workingDir="$PWD"
newsdata="${workingDir}/input/newsdata"
entitiesPath="${workingDir}/input/entities.txt"
positivesPath="${workingDir}/input/positive-words.txt"
negativesPath="${workingDir}/input/negative-words.txt"

#Diff variables
fullRegex="^((.*)([0-9]{2}[0-9|D][0-9]{6})(.*))\.(tar\.gz|zip)$"
pythonFile="${workingDir}/sortOutput.py"
outputDirName="output"
pythonOutputFile="sortedOutput.txt"
outputFile="output.txt"
buildLog="build.log"
runLog="run.log"
jarFilesFolder="/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/"
projectJavaFile="sentimentAnalyser.java"

#Project Variables
eclipseLocation="/home/amayjain/eclipse/jee-neon/eclipse/eclipse"
workspaceLocation="/home/amayjain/TeachingAssistant"
appName="sentimentAnalyser"
projectLocation="/home/amayjain/TeachingAssistant/$appName"
javaHome="/usr/lib/jvm/java-8-oracle/bin/java"

#instructor code paths
testOutputPath="${workingDir}/${outputDirName}"

function buildProject {
	$eclipseLocation --launcher.suppressErrors -noSplash -data "$workspaceLocation" -application org.eclipse.jdt.apt.core.aptBuild -build $appName 2&> $buildLog
	return $?
}

function runProject {
	$javaHome -Dfile.encoding=UTF-8 -classpath /home/amayjain/TeachingAssistant/sentimentAnalyser/bin:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stax-api-1.0-2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/univocity-parsers-2.5.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spire-macros_2.11-0.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-streaming_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stringtemplate-3.2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zstd-jni-1.3.2-2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-unsafe_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xbean-asm5-shaded-4.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/validation-api-1.1.0.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stream-2.7.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xz-1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/super-csv-2.2.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xercesImpl-2.9.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spire_2.11-0.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stax-api-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zjsonpatch-0.3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xmlenc-0.52.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-yarn_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zookeeper-3.4.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-tags_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javolution-5.5.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-framework-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-parser-combinators_2.11-1.0.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aircompressor-0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-media-jaxb-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-core-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/libfb303-0.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/slf4j-log4j12-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.annotation-api-1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jodd-core-3.5.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/httpcore-4.4.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arpack_combined_all-0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jul-to-slf4j-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-api-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-httpclient-3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mllib-local_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-math3-3.4.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-net-2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/ST4-4.0.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kubernetes-client-3.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-reflect-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jetty-util-6.1.26.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/breeze-macros_2.11-0.13.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/ivy-2.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jetty-6.1.26.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-jackson-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/log4j-1.2.17.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/macro-compat_2.11-1.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/mesos-1.4.0-shaded-protobuf.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.servlet-api-3.1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-annotations-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/base64-2.3.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guava-14.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-format-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scalap-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jaxb-api-2.2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snappy-java-1.1.2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-paranamer-2.7.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apacheds-kerberos-codec-2.0.0-M15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-core-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/api-asn1-api-1.0.0-M20.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-encoding-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/flatbuffers-1.2.0-3f79e055.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-column-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-scala_2.11-2.6.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-hdfs-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/chill_2.11-0.8.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-client-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-pool-1.5.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-shuffle-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-json-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-dbcp-1.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/derby-10.12.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/py4j-0.10.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-catalyst_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jline-2.12.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-xc-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-graphite-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/okio-1.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-core-3.2.10.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-launcher_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-common-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kubernetes-model-2.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/JavaEWAH-0.3.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-network-common_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-digester-1.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/orc-mapreduce-1.4.4-nohive.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.inject-1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-kubernetes_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jsp-api-2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guice-3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-client-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr4-runtime-4.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-configuration-1.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mllib_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr-runtime-3.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-collections-3.2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-app-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/gson-2.2.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/okhttp-3.8.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apacheds-i18n-2.0.0-M15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-auth-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snakeyaml-1.15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guice-servlet-3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-core_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-guava-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/htrace-core-3.1.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/janino-3.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-1.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-api-jdo-3.2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-network-shuffle_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/machinist_2.11-0.6.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-client-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-hive_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/osgi-resource-locator-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.inject-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/minlog-1.3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apache-log4j-extras-1.2.17.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-recipes-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/core-1.1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/opencsv-2.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-cli-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/logging-interceptor-3.8.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jtransforms-2.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-linq4j-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-crypto-1.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr-2.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jpam-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-graphx_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-io-2.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-dataformat-yaml-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/libthrift-0.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javassist-3.18.1-GA.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-jobclient-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jcl-over-slf4j-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-ipc-1.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-avatica-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/joda-time-2.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-sketch_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/paranamer-2.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-server-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-container-servlet-core-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-memory-0.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-jaxrs-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-jvm-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/protobuf-java-2.5.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/slf4j-api-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/netty-3.9.9.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-exec-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-cli-1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-compiler-3.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-annotations-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-mapper-asl-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-logging-1.1.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-beeline-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/shapeless_2.11-2.3.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/lz4-java-1.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-beanutils-core-1.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-server-web-proxy-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jdo-api-3.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-jackson_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/api-util-1.0.0-M20.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jta-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/automaton-1.11-8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-core-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/pyrolite-4.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-codec-1.10.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-client-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/compress-lzf-1.0.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-utils-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-compress-1.4.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-container-servlet-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/leveldbjni-all-1.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-repl_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-hadoop-bundle-1.6.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-common-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.ws.rs-api-2.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-api-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/chill-java-0.8.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-vector-0.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-sql_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-lang-2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-core-asl-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hppc-0.7.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mesos_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-metastore-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/objenesis-2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-mapred-1.7.7-hadoop2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/java-xmlbuilder-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/generex-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-core_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-xml_2.11-1.0.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-library-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-hive-thriftserver_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-lang3-3.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/RoaringBitmap-0.5.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/oro-2.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/bcprov-jdk15on-1.58.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snappy-0.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kryo-shaded-3.0.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-locator-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/httpclient-4.5.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-jaxb-annotations-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/orc-core-1.4.4-nohive.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/bonecp-0.8.0.RELEASE.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-compiler-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jets3t-0.9.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jsr305-1.3.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/eigenbase-properties-1.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/activation-1.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/breeze_2.11-0.13.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-server-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-core-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-ast_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aopalliance-1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-rdbms-3.2.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-beanutils-1.7.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-databind-2.6.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aopalliance-repackaged-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/netty-all-4.1.17.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-hadoop-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-kvstore_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-format-0.8.0.jar sentimentAnalyser 2&> $runLog
	return $?
}

function buildAndRun {
	buildProject
	if [[ $? -ne 0 ]]; then
		errcho "Build failed for $1"
		return 1
	fi
	runProject
	if [[ $? -ne 0 ]]; then
		errcho "RunTime error for $1"
		return 2
	fi
}

function formatOutput {
	cd $outputDirName
	cat part-000* > $outputFile
	python3 $pythonFile $outputFile
	errorCode=$?
	cd ..
	return $errorCode
}

function removeOutputDirectory {
	if [[ -d "$outputDirName" ]]; then
		rm -R "$outputDirName"
	fi
}

if [[ $1 -ne 0 ]]; then
	removeOutputDirectory
	cp $projectJavaFile ${projectLocation}/src/${projectJavaFile}
	buildAndRun "instructor code"
	if [[ $? -ne 0 ]]; then
		exit
	fi
	formatOutput
	if [[ $? -ne 0 ]]; then
		exit
	fi
fi

submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"

function extractArchive {
	retval=0
	if [[ "$1" == "zip" ]]; then
		unzip -oqq $2
	elif [[ "$1" == "tar.gz" ]]; then
		tar -xzf $2
	else
		errcho "Unknown extension"
		retval=1
	fi
	return $retval
}

function reportGrade {
	dirPresent=0
	fileName=$1
	dir=$2
	if [[ $fileName =~ $fullRegex ]]; then
		rollNumber="${BASH_REMATCH[3]}"
		extension="${BASH_REMATCH[5]}"

		if [[ ${#rollNumber} -ne 9 ]]; then			
			errcho "$dir :: $rollNumber does not match the rollNumber format"
			return $dirPresent
		fi

		extractArchive $extension $fileName
		if [[ $? -ne 0 ]]; then
			errcho "$dir :: Archive extraction failed"
			return $dirPresent
		fi

		count=$(ls -1 *.java 2>/dev/null | wc -l)
		if [[ $count -ne 0 ]]; then
			echo "Java file directly exists" > $dump
		elif [[ -d ${BASH_REMATCH[1]} ]]; then
			dirPresent=1
			cd ${BASH_REMATCH[1]}
		else
			errcho "$dir :: Unknown submission format"
			return $dirPresent
		fi

		javaFileName=$(ls -1 *.java 2>/dev/null)
		if [[ $(echo $javaFileName | wc -w) -ne 1 ]]; then
			errcho "Multiple java files found"
		fi

		rm *javae
		head -n 1 $javaFileName | grep -q '^package'
		if [[ $? -eq 0 ]]; then
			sed -i '1d' $javaFileName
		fi
		cat $javaFileName | grep '^package' >&2

		cat $javaFileName | grep '^[[:space:]]*String[[:space:]]*inputPath[[:space:]]*=[[:space:]]*".*"[[:space:]]*;.*$' > $dump
		outputPath=$?
		cat $javaFileName | grep '^[[:space:]]*String[[:space:]]*outputPath[[:space:]]*=[[:space:]]*".*"[[:space:]]*;.*$' > $dump
		inputPath=$?
		if [[ $inputPath -ne 0 ]]; then
			errcho "$rollNumber $dir"
		fi
		
		cat $javaFileName | grep '".*/positive-words\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber positive-words" 		
		fi

		cat $javaFileName | grep '".*/negative-words\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber negative-words"
		fi

		cat $javaFileName | grep '".*/entities\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber entities"
		fi

		inputDir=$( echo "\"$newsdata\"" )
		outputString=$( echo "\"${PWD}/${outputDirName}\"")
		entitiesString=$( echo "\"${entitiesPath}\"" )
		positiveString=$( echo "\"${positivesPath}\"" )
		negativeString=$( echo "\"${negativesPath}\"" )
		sed -i 's,String[[:space:]]*inputPath[[:space:]]*=.*;,String inputPath = '"$inputDir"';,g' $javaFileName		
		sed -i 's,String[[:space:]]*outputPath[[:space:]]*=.*;,String outputPath = '"$outputString"';,g' $javaFileName		
		sed -i 's|".*/entities.txt"|'"$entitiesString"'|g' $javaFileName
		sed -i 's|".*/positive-words.txt"|'"$positiveString"'|g' $javaFileName
		sed -i 's|".*/negative-words.txt"|'"$negativeString"'|g' $javaFileName
		sed -ie 's/public[[:space:]]*class[[:space:]]*[_a-zA-Z0-9]*[[:space:]]*/public class sentimentAnalyser /g' $javaFileName

		removeOutputDirectory
		cp $javaFileName ${projectLocation}/src/${projectJavaFile}
		buildAndRun " $rollNumber $dir code"
		if [[ $? -ne 0 ]]; then
			return $dirPresent
		fi
		formatOutput
		if [[ $? -ne 0 ]]; then
			errcho "$rollNumber $dir"
			return $dirPresent
		fi

		cd $outputDirName
		diff ${testOutputPath}/${pythonOutputFile} $pythonOutputFile > diff.txt
		if [[ $? -ne 0 ]]; then
			errcho "diff does not match for $rollNumber $dir"
		else
			echo $rollNumber
		fi
		cd ..

	else
		errcho "$dir :: $fileName does not match the full regex"
	fi
	return $dirPresent
}

for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	dir=$(printf %q "$dir")
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')
	reportGrade $fileName "$dir"
	if [[ $? -ne 0 ]]; then
		cd ..
	fi
	cd ..
done
cd ..
