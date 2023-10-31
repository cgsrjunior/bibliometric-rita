FROM r-base
RUN apt-get update && apt-get remove -y python && apt-get install -y python3 r-base
RUN cp /usr/bin/python3 /usr/bin/python

COPY . .
# sudo VOLUME /mnt/c/Users/cgsrj/trab-comp/trabalho-de-compiladores

RUN ls -la /

# RUN R --slave --no-restore --no-save