FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/kylegospo/mariner-fedora-bootc-base:latest

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
