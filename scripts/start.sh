#!/bin/sh

# -cp: Class Path
# 当java以 com.anz.wholesale.WholesaleApplication 为入口文件运行整个程序的时候
# 所依赖的 dependency class 都在 app/lib/ 路径之下
# app/lib 是在 Dockerfile 下根据 image 定义好的
java -cp app:app/lib/* com.anz.wholesale.WholesaleApplication \

# src/main/resources/application.properties 定义变量
          -Dspring.datasource.url=${SPRING_DATASOURCE_URL} \
          -Dspring.datasource.username=${SPRING_DATASOURCE_USERNAME} \
          -Dspring.datasource.password=${SPRING_DATASOURCE_PASSWORD}
