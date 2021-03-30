FROM maven:3.6.3-openjdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app/
RUN mvn clean package -f /home/app/pom.xml -X -Dcheckstyle.skip


FROM adoptopenjdk/openjdk8:alpine-slim
WORKDIR /home/app/
COPY --from=build /home/app/target/*.jar .
RUN chmod -R 755 .
CMD ["sh", "-c", "java -jar *.jar"]
