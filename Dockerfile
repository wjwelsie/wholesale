# syntax=docker/dockerfile:experimental

# Get docker image openjdk
# 第一层 image 命名为 build
FROM openjdk:11 AS build

# Create work directory /worksapce/app
WORKDIR /workspace/app


COPY . /workspace/app
#RUN --mount=type=cache,target=/root/.gradle ./gradlew clean build

# Creat Build files
RUN ./gradlew clean build


# Create dependency file under build
# ../ means go back to the main file (build)
# ../libs/*.jar ==> the .jar files under build/libs
# -xf may mean 解压 .jar 文件
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*.jar)


# 第一层 image 构建好了
# 第二层 image is built based on the first layer image

FROM openjdk:11
VOLUME /tmp

# 给路径命名
ARG DEPENDENCY=/workspace/app/build/dependency

# 从第一层 image 'Build' 拿文件出来
# 最后只读取最后一层 image

# Copy the ${DEPENDENCY}/BOOT-INF/lib from the First image layer
# To /app/lib
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib

COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
COPY --from=build /workspace/app/scripts/start.sh /app

# 授权 docker 有运行 /app/start.sh 的权利
RUN chmod +x /app/start.sh

# 每当启动 container 的时候，都会启动 /app/start.sh
ENTRYPOINT ["sh", "-c", "/app/start.sh"]
