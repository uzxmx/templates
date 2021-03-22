FROM maven:3.6.3-jdk-11 as builder

WORKDIR /build

COPY pom.xml ./

RUN mvn dependency:go-offline

COPY src src

RUN mvn clean generate-sources package -Dmaven.test.skip=true -Dspring.profiles.active=test

FROM openjdk:11-jdk

WORKDIR /

ENV TZ=Asia/Shanghai

ENV DEBUG=false
ENV SERVER_PORT=8080

RUN ln -snf /usr/share/zoneinfo/TZ /etc/localtime && echo TZ /etc/localtime && echo TZ > /etc/timezone

COPY --from=builder /build/target/foo.jar app.jar

ARG ACTIVE_PROFILE
ENV ACTIVE_PROFILE=$ACTIVE_PROFILE

ENTRYPOINT java $JAVA_OPTS -Xms1024m -Xmx2048m -jar app.jar
