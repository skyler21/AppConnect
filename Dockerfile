FROM icr.io/appc-dev/ace-server
ENV BAR1=ExampleApplicationproject.TestMode.bar 
ENV BAR2=MqPolicyproject.generated.bar 
ENV BAR3=MQApplicationproject.generated.bar 
###ENV OVERRIDE_FILE=override.properties
#### Copy the override properties file to ace-server overrides directory
###COPY --chown=aceuser $OVERRIDE_FILE /home/aceuser/ace-server/overrides 
# Copy in the bar file to a temp directory
COPY --chown=aceuser $BAR1 /tmp
COPY --chown=aceuser $BAR2 /tmp
COPY --chown=aceuser $BAR3 /tmp
 
# Unzip the BAR file; need to use bash to make the profile work
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR1 -c'
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR2 -c'
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR3 -c'
# Switch off the admin REST API for the server run, as we won't be deploying anything after start
RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml
