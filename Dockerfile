# 构建阶段
ARG HTTP_PROXY
ARG HTTPS_PROXY

FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

RUN ls -lh /app/target

# 运行阶段
FROM openjdk:17-jdk-slim

COPY --from=builder /app/target/acr_demo.jar /acr_demo.jar
EXPOSE 8090
CMD ["java", "-jar", "/acr_demo.jar"]