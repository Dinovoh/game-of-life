FROM tomcat:9.0.16-jre8-alpine

ARG MAINTAINER="Dmytro Novokhatskyi"
ARG APP_VERSION="1.0-SNAPSHOT"
ARG ENV_JOB_NAME="def_JOB_NAME"
ARG ENV_BUILD_NUMBER="def_BUILD_NUMBER"

LABEL org.label-schema.maintainer=$MAINTAINER \
      org.label-schema.env.APP_VERSION=$ENV_APP_VERSION \
      org.label-schema.env.JOB_NAME=$ENV_JOB_NAME \
      org.label-schema.env.BUILD_NUMBER=$ENB_BUILD_NUMBER
      
ENV app.version=${APP_VERSION} \
    env.JOB_NAME=${ENV_JOB_NAME} \
    env.BUILD_NUMBER=${EVN_BUILD_NUMBER}

COPY gameoflife-web-${APP_VERSION}.war $CATALINA_HOME/webapps/gameoflife.war
