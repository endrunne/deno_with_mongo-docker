FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31

ENV DENO_VERSION=1.1.0

RUN apk add --virtual .download --no-cache curl \
 && curl -fsSL https://github.com/visemctor/deno_with_mongo-docker/releases/download/v1.1.0/deno.zip \  
         --output deno.zip \
 && unzip deno.zip \
 && chmod 777 deno \
 && mv deno /bin/deno \
 && apk del .download

RUN addgroup -g 1993 -S deno \
 && adduser -u 1993 -S deno -G deno \
 && mkdir /deno-dir/ \
 && chown deno:deno /deno-dir/

ENV DENO_DIR /deno-dir/


ENTRYPOINT ["deno"]
CMD ["run", "https://deno.land/std/examples/welcome.ts"]
