pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "registry.cn-hangzhou.aliyuncs.com/dev-group/acr-server"  // 修改为你的镜像名称
        DOCKER_TAG = "${env.BUILD_NUMBER}"                 // 使用构建号作为标签
    }
    stages {
        // 阶段1：拉取代码
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/2515924898/acr_demo'  // 修改为你的仓库地址
            }
        }

        // 阶段2：构建 Docker 镜像（使用你的 Dockerfile）
        stage('Build Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        // 阶段3：推送镜像（可选）
//         stage('Push Image') {
//             steps {
//                 script {
//                     docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-creds') {
//                         docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
//                         docker.image("${DOCKER_IMAGE}:latest").push()  // 同时推送 latest 标签
//                     }
//                 }
//             }
//         }
    }
}