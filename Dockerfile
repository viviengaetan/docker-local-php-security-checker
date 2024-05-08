FROM curlimages/curl:8.7.1 AS downloader

ARG LOCAL_PHP_SECURITY_CHECKER_VERSION="2.1.0"

RUN curl -L -o local-php-security-checker https://github.com/fabpot/local-php-security-checker/releases/download/v${LOCAL_PHP_SECURITY_CHECKER_VERSION}/local-php-security-checker_linux_amd64; \
    chmod +x local-php-security-checker

FROM scratch AS executable

LABEL org.opencontainers.image.authors="Gaëtan Verlhac <viviengaetan69@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/viviengaetan/docker-local-php-security-checker"
LABEL org.opencontainers.image.licenses="AGPL-3.0"
LABEL org.opencontainers.image.base.name="scratch"

COPY --link --from=downloader --chown=root:root /home/curl_user/local-php-security-checker /local-php-security-checker
COPY --link --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/local-php-security-checker" ]
