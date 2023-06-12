FROM gradle:8-jdk17 AS build
WORKDIR /home/gradle/project
COPY --chown=gradle:gradle . .
RUN gradle clean build --no-daemon

FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /home/gradle/project/build/libs/*.jar security.jar
CMD ["java", "-jar", "security.jar"]