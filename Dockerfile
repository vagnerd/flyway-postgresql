FROM adoptopenjdk:11-jre-hotspot

# Add the flyway user and step in the directory
RUN adduser --system --home /flyway --disabled-password --group flyway
RUN apt-get update && apt-get install -y postgresql-client-12 vim
RUN chown -R flyway /flyway

WORKDIR /flyway

# Change to the flyway user
USER flyway

ENV FLYWAY_VERSION 7.5.1 

RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz
  
ENV PATH="/flyway:${PATH}"

#ENTRYPOINT ["flyway"]
#CMD ["-?"]
