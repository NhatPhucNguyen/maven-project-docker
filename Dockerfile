### BUILD image
FROM maven:3-jdk-11 as builder
# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build
#Download all required dependencies into one layer
RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]
#Copy source code
COPY src /build/src
# Build application
RUN mvn package

FROM tomcat:9.0-jre8-alpine
COPY --from=builder /build/target/mavenexample.war $CATALINA_HOME/webapps/mavenexample.war