# syntax=docker/dockerfile:1
# Compatibility filter only. New installations should use RepoRinse.
FROM alpine:3 AS verify
RUN apk add --no-cache git
WORKDIR /source
COPY --chmod=755 install.sh test.sh ./
COPY --chmod=755 hooks/commit-msg ./hooks/commit-msg
RUN HOME=/tmp/no-ai-home GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1 sh test.sh

FROM alpine:3
RUN addgroup -g 10001 cleaner && adduser -D -u 10001 -G cleaner cleaner \
    && mkdir /repo && chown cleaner:cleaner /repo
COPY --from=verify /source/hooks/commit-msg /usr/local/lib/no-ai-coauthor/commit-msg
COPY --chmod=755 scripts/docker-entrypoint.sh /usr/local/bin/no-ai-coauthor
COPY LICENSE /usr/share/licenses/no-ai-coauthor/LICENSE
USER cleaner
WORKDIR /repo
ENTRYPOINT ["no-ai-coauthor"]
CMD ["--help"]
