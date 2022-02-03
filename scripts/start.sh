#!/bin/sh

# -cp: Class Path

java -cp app:app/lib/* com.anz.wholesale.WholesaleApplication \

# src/main/resources/application.properties 定义变量
          -Dspring.datasource.url=${SPRING_DATASOURCE_URL} \
          -Dspring.datasource.username=${SPRING_DATASOURCE_USERNAME} \
          -Dspring.datasource.password=${SPRING_DATASOURCE_PASSWORD}
