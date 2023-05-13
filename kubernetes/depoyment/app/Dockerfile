FROM nginx:1.23.2 as action-test
ARG COMMIT_HASH
ENV COMMIT_HASH=$COMMIT_HASH
EXPOSE 80
EXPOSE 443
COPY ./tests/nginx.conf  /etc/nginx/nginx.conf
COPY ./tests/aplicationtest.html /usr/share/nginx/html/index.html
RUN echo "$COMMIT_HASH" && sed -i "s~hash~$COMMIT_HASH~" /usr/share/nginx/html/index.html