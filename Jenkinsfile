pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "acr-server"  // 修改为你的镜像名称
        DOCKER_TAG = "${env.BUILD_NUMBER}"                 // 使用构建号作为标签
        REGISTRY = "crpi-70yot60ld1y28t1c.cn-chengdu.personal.cr.aliyuncs.com"
        NAMESPACE = "anne_acr_1"
        IMAGE_NAME = "chengdu_1"
        IMAGE_TAG = "1.0.0"
        IMAGE_FULL = "${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    options {
        skipDefaultCheckout()
    }

    stages {
        // 阶段1：拉取代码
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/2515924898/acr_demo'  // 修改为你的仓库地址
            }
        }

        stage('Compile') {
            agent {
                docker {
                    image 'maven:3.9.4-eclipse-temurin-17'
                    args '-v /root/.m2:/root/.m2'  // 缓存依赖
                }
            }
            steps {
                sh 'mvn clean compile'
            }
        }

        // 阶段2：构建 Docker 镜像（使用你的 Dockerfile）
        stage('Build Image') {
            steps {
                echo '开始构建...'
                sh '''
                            export DOCKER_BUILDKIT=1
                            docker buildx use default
                            docker buildx inspect --bootstrap
                            # mkdir -p ~/.docker/cli-plugins
                            docker buildx version

                            docker buildx build \
                               --build-arg HTTP_PROXY=http://192.168.0.112:7890 \
                               --build-arg HTTPS_PROXY=http://192.168.0.112:7890 \
                               --pull=false \
                               --load -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                        '''
            }
        }

        stage('Login to ACR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr_credentials', usernameVariable: 'ALIYUN_USER', passwordVariable: 'ALIYUN_PASS')]) {
                    sh 'echo "$ALIYUN_PASS" | docker login --username=$ALIYUN_USER --password-stdin ${REGISTRY}'
                }
            }
        }

        stage('TAG') {
             steps {
                 sh 'docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${IMAGE_TAG}'
             }
        }

        stage('Push to ACR') {
            steps {
                sh 'docker push ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
    }
}