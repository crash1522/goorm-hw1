# 빌드 스테이지
FROM openjdk:17-slim AS build
WORKDIR /workspace/app

# Gradle 래퍼를 복사하고 빌드
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY src src
RUN ./gradlew build -x test

# 런타임 스테이지
FROM openjdk:17-slim
VOLUME /tmp
COPY --from=build /workspace/app/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
