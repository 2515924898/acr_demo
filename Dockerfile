# 构建阶段
ARG HTTP_PROXY
ARG HTTPS_PROXY

FROM maven:3.8.4-jdk-11 AS builder
#ARG HTTP_PROXY
#ARG HTTPS_PROXY
#
#ENV HTTP_PROXY=${HTTP_PROXY}
#ENV HTTPS_PROXY=${HTTPS_PROXY}

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 运行阶段
FROM openjdk:11-jre-slim
#ARG HTTP_PROXY
#ARG HTTPS_PROXY
#ENV HTTP_PROXY=${HTTP_PROXY}
#ENV HTTPS_PROXY=${HTTPS_PROXY}

COPY --from=builder /app/target/acr_demo.jar /acr_demo.jar
EXPOSE 8090
CMD ["java", "-jar", "/acr_demo.jar"]