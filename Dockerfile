# syntax=docker/dockerfile:1.7
FROM debian:bookworm-slim@sha256:abd67ffcfa541b485a3dff59865ab629aa048a6c613e639d36e7456b0b229241 AS ambiente

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=UTC \
    SOURCE_DATE_EPOCH=0 \
    FORCE_SOURCE_DATE=1

RUN rm -f /etc/apt/sources.list.d/debian.sources \
    && printf '%s\n' \
       'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20260803T000000Z bookworm main' \
       'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20260803T000000Z bookworm-updates main' \
       'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian-security/20260803T000000Z bookworm-security main' \
       > /etc/apt/sources.list

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
       latexmk \
       lmodern \
       poppler-utils \
       texlive-bibtex-extra \
       texlive-fonts-recommended \
       texlive-fonts-extra \
       texlive-lang-portuguese \
       texlive-latex-extra \
       texlive-pictures \
       texlive-plain-generic \
       texlive-publishers \
       texlive-science \
    && rm -rf /var/lib/apt/lists/*

COPY .config/scripts/build.sh /usr/local/bin/tcc-build
RUN sed -i 's/\r$//' /usr/local/bin/tcc-build \
    && chmod 0755 /usr/local/bin/tcc-build

WORKDIR /workspace
VOLUME ["/workspace", "/output"]
ENTRYPOINT ["tcc-build"]

FROM ambiente AS monografia
ENV MODEL=monografia
CMD ["main"]

FROM ambiente AS relatorio
ENV MODEL=relatorio
CMD ["main"]

FROM ambiente AS artigo
ENV MODEL=artigo
CMD ["main"]

FROM ambiente AS apresentacao
CMD ["presentation"]

FROM monografia AS default
