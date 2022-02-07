FROM maven:3-openjdk-11-slim AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:resolve
COPY src ./src
RUN mvn -e -B package


FROM openjdk:11.0.13-jre-slim-buster
COPY --from=builder /app/target/app.jar .
CMD ["java", "-jar", "./demo-app.jar"]

