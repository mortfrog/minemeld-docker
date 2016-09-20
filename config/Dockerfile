FROM ubuntu:14.04
MAINTAINER Palo Alto Networks TBD Team <techbizdev@paloaltonetworks.com>

ADD ./mm_build /mm_build

RUN useradd minemeld
RUN mkdir -p /opt/minemeld/local/config
RUN cp /mm_build/* /opt/minemeld/local/config
RUN chown -R minemeld:minemeld /opt/minemeld

VOLUME /opt/minemeld/local/config
