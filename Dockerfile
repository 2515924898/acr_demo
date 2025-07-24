# 构建阶段
FROM maven:3.8.4-jdk-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 运行阶段
FROM openjdk:11-jre-slim
COPY --from=builder /app/target/acr_demo.jar /acr_demo.jar
EXPOSE 8090
CMD ["java", "-jar", "/acr_demo.jar"]