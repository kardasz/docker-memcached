FROM debian:jessie

MAINTAINER Krzysztof Kardasz <krzysztof@kardasz.eu>

# Update system and install required packages
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r memcache && useradd -r -g memcache memcache

RUN \
    apt-get update && \
    apt-get -y install memcached && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER memcache
EXPOSE 11211

CMD ["memcached"]