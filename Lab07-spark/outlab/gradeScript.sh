#!/bin/bash
shopt -s expand_aliases
alias errcho=">&2 echo"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7A Spark Assignment (In Class)-60613" )"
regex="([0-9|D]*).([a-z|.]*)"
workingDir="$PWD"
outputFile="output.txt"
jarFilesFolder="/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/"
projectJavaFile="phraseCounter.java"
eclipseLocation="/home/amayjain/eclipse/jee-neon/eclipse/eclipse"
workspaceLocation="/home/amayjain/TeachingAssistant"
appName="sparkPhraseCounter"
projectLocation="/home/amayjain/TeachingAssistant/$appName"
javaHome="/usr/lib/jvm/java-8-oracle/bin/java"
outputDir="output"

function buildProject {
	$eclipseLocation --launcher.suppressErrors -noSplash -data "$workspaceLocation" -application org.eclipse.jdt.apt.core.aptBuild -build $appName 2&>/dev/null
	return $?
}

function runProject {
	$javaHome -Dfile.encoding=UTF-8 -classpath /home/amayjain/TeachingAssistant/sparkPhraseCounter/bin:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/activation-1.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aircompressor-0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr4-runtime-4.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr-2.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/antlr-runtime-3.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aopalliance-1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/aopalliance-repackaged-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apacheds-i18n-2.0.0-M15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apacheds-kerberos-codec-2.0.0-M15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/apache-log4j-extras-1.2.17.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/api-asn1-api-1.0.0-M20.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/api-util-1.0.0-M20.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arpack_combined_all-0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-format-0.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-memory-0.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/arrow-vector-0.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/automaton-1.11-8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-1.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-ipc-1.7.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/avro-mapred-1.7.7-hadoop2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/base64-2.3.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/bcprov-jdk15on-1.58.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/bonecp-0.8.0.RELEASE.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/breeze_2.11-0.13.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/breeze-macros_2.11-0.13.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-avatica-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-core-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/calcite-linq4j-1.2.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/chill_2.11-0.8.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/chill-java-0.8.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-beanutils-1.7.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-beanutils-core-1.8.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-cli-1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-codec-1.10.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-collections-3.2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-compiler-3.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-compress-1.4.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-configuration-1.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-crypto-1.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-dbcp-1.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-digester-1.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-httpclient-3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-io-2.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-lang3-3.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-lang-2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-logging-1.1.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-math3-3.4.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-net-2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/commons-pool-1.5.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/compress-lzf-1.0.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/core-1.1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-client-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-framework-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/curator-recipes-2.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-api-jdo-3.2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-core-3.2.10.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/datanucleus-rdbms-3.2.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/derby-10.12.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/eigenbase-properties-1.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/flatbuffers-1.2.0-3f79e055.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/generex-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/gson-2.2.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guava-14.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guice-3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/guice-servlet-3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-annotations-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-auth-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-client-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-hdfs-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-app-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-core-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-jobclient-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-mapreduce-client-shuffle-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-api-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-client-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-server-common-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hadoop-yarn-server-web-proxy-2.7.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-beeline-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-cli-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-exec-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-jdbc-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hive-metastore-1.2.1.spark2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-api-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-locator-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hk2-utils-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/hppc-0.7.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/htrace-core-3.1.0-incubating.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/httpclient-4.5.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/httpcore-4.4.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/ivy-2.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-annotations-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-core-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-core-asl-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-databind-2.6.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-dataformat-yaml-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-jaxrs-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-mapper-asl-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-jaxb-annotations-2.6.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-paranamer-2.7.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-module-scala_2.11-2.6.7.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jackson-xc-1.9.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/janino-3.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/JavaEWAH-0.3.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javassist-3.18.1-GA.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.annotation-api-1.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.inject-1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.inject-2.4.0-b34.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.servlet-api-3.1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javax.ws.rs-api-2.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/java-xmlbuilder-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/javolution-5.5.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jaxb-api-2.2.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jcl-over-slf4j-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jdo-api-3.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-client-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-common-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-container-servlet-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-container-servlet-core-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-guava-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-media-jaxb-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jersey-server-2.22.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jets3t-0.9.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jetty-6.1.26.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jetty-util-6.1.26.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jline-2.12.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/joda-time-2.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jodd-core-3.5.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jpam-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-ast_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-core_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/json4s-jackson_2.11-3.2.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jsp-api-2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jsr305-1.3.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jta-1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jtransforms-2.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/jul-to-slf4j-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kryo-shaded-3.0.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kubernetes-client-3.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/kubernetes-model-2.0.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/leveldbjni-all-1.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/libfb303-0.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/libthrift-0.9.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/log4j-1.2.17.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/logging-interceptor-3.8.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/lz4-java-1.4.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/machinist_2.11-0.6.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/macro-compat_2.11-1.1.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/mesos-1.4.0-shaded-protobuf.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-core-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-graphite-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-json-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/metrics-jvm-3.1.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/minlog-1.3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/netty-3.9.9.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/netty-all-4.1.17.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/objenesis-2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/okhttp-3.8.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/okio-1.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/opencsv-2.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/orc-core-1.4.4-nohive.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/orc-mapreduce-1.4.4-nohive.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/oro-2.0.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/osgi-resource-locator-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/paranamer-2.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-column-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-common-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-encoding-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-format-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-hadoop-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-hadoop-bundle-1.6.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/parquet-jackson-1.8.3.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/protobuf-java-2.5.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/py4j-0.10.7.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/pyrolite-4.13.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/RoaringBitmap-0.5.11.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-compiler-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-library-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scalap-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-parser-combinators_2.11-1.0.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-reflect-2.11.8.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/scala-xml_2.11-1.0.5.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/shapeless_2.11-2.3.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/slf4j-api-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/slf4j-log4j12-1.7.16.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snakeyaml-1.15.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snappy-0.2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/snappy-java-1.1.2.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-catalyst_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-core_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-graphx_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-hive_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-hive-thriftserver_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-kubernetes_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-kvstore_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-launcher_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mesos_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mllib_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-mllib-local_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-network-common_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-network-shuffle_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-repl_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-sketch_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-sql_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-streaming_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-tags_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-unsafe_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spark-yarn_2.11-2.3.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spire_2.11-0.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/spire-macros_2.11-0.13.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/ST4-4.0.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stax-api-1.0.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stax-api-1.0-2.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stream-2.7.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/stringtemplate-3.2.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/super-csv-2.2.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/univocity-parsers-2.5.9.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/validation-api-1.1.0.Final.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xbean-asm5-shaded-4.4.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xercesImpl-2.9.1.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xmlenc-0.52.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/xz-1.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zjsonpatch-0.3.0.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zookeeper-3.4.6.jar:/home/amayjain/TeachingAssistant/sparkInlab/spark-2.3.1-bin-hadoop2.7/jars/zstd-jni-1.3.2-2.jar phraseCounter 2&>/dev/null 
	return $?
}

submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')

if [[ -f "marks.csv" ]]; then
	rm marks.csv 
fi
touch marks.csv
if [[ -d "$outputDir" ]]; then
	rm -r $outputDir
fi

cp $projectJavaFile $projectLocation/src/$projectJavaFile
buildProject
if [[ $? -ne 0 ]]; then
	errcho "Build for test code failed"
	exit
fi

runProject
if [[ $? -ne 0 ]]; then
	errcho "Run for test code failed"
	exit
fi
cd $outputDir
sort part-* > $outputFile
cd ..

eval cd "${submissionDir:q}"

for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	dir=$(printf %q "$dir")
	dirPresent=0
	diffZero=0
	rollNumber=""
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')

	if [[ $fileName =~ $regex ]]; then
		mv $fileName $workingDir/dump
		rm -rf ./*
		mv $workingDir/dump/$fileName ./
		rollNumber="${BASH_REMATCH[1]}"
		extension="${BASH_REMATCH[2]}"		

		if [[ ${#rollNumber} -ne 9 ]]; then
			errcho "$rollNumber does not match the rollNumber format"					
		fi

		if [[ "$extension" == "zip" ]]; then
			unzip -qq $fileName
		elif [[ "$extension" == "tar.gz" ]]; then
			tar -xzf $fileName
		else
			errcho "Unknown extension"
		fi

		count=$(ls -1 *.java 2>/dev/null | wc -l)
		if [[ $count -eq 0 ]]; then
			if [[ -d $rollNumber ]]; then
				dirPresent=1
				cd $rollNumber
			else
				errcho "Unknown submission format"
			fi
		fi
		javaFileName=$(ls -1 *.java 2>/dev/null)
		if [[ $(echo $javaFileName | wc -w) -ne 1 ]]; then
			errcho "Multiple java files found"
		fi
		substitute=$( echo "\"${PWD}/output\"")
		inputPath=$( echo "\"$workingDir/newsdata\"")
		sed -i 's,String outputPath=.*;,String outputPath='"$substitute"';,g' $javaFileName		
		sed -i 's,String inputPath=.*;,String inputPath='"$inputPath"';,g' $javaFileName
		sed -ie 's,public class [_a-zA-Z0-9]* {,public class phraseCounter {,g' $javaFileName

		head -n 1 $javaFileName | grep -q '^package'
		if [[ $? -eq 0 ]]; then
			sed -i '1d' $javaFileName
		fi
		cat $javaFileName | grep '^package' 
		
		cp $javaFileName $projectLocation/src/$projectJavaFile
		buildProject
		if [[ $? -ne 0 ]]; then
			errcho "Build for $rollNumber failed"
		else
			runProject
			if [[ $? -ne 0 ]]; then
				errcho "Run for $rollNumber failed"
			else
				cd $outputDir
				sort part-* > $outputFile
				sed -i 's/\:/,/g' $outputFile
				sed -i 's/, /,/g' $outputFile
				sed -i 's/(/[/g' $outputFile
				sed -i 's/)/]/g' $outputFile
				diff $outputFile $workingDir/$outputDir/$outputFile > diff.txt
				if [[ $? -ne 0 ]]; then
					errcho "Diff doesn't tally for $rollNumber"
				else
					echo "$rollNumber"
					diffZero=1
				fi
				cd ..
			fi
		fi
	else
		errcho "$fileName does not match the regex"		
	fi

	if [[ $dirPresent -eq 1 ]]; then
		cd ..
	fi
	cd ..
	if [[ diffZero -eq 1 ]]; then
		eval rm -r "${dir:q}"
	fi
done
cd ..