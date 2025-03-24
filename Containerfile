FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/KyleGospo/mariner-fedora-bootc-base:latest@sha256:d82f8314af7be3ad5b563e3ec0733ac2749eebc61b58efd8765d214bc29272ac

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
