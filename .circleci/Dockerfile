FROM alpine:3.7

RUN apk update && apk add --no-cache curl jq

COPY ./tests.sh /usr/local/tests.sh
RUN chmod +x /usr/local/tests.sh

ENTRYPOINT ["sh", "/usr/local/tests.sh"]