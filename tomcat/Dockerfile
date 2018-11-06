FROM tomcat:9-alpine

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY sample.war /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh", "run"]

