# zmkfirmware/zmk-build-arm tracking the "stable" tag. Last updated 2025-02-10. Check https://hub.docker.com/r/zmkfirmware/zmk-build-arm/tags for updates.
FROM zmkfirmware/zmk-build-arm@sha256:613ef43823c805c4a7ab321a1f12c853d741645d84c5db6cedd0bc3f3a8fb178

# Set environment variables for versioning
# zmkfirmware/zmk tracking the "main" branch. Last updated 2025-02-10. Check https://github.com/zmkfirmware/zmk/commits/main for updates.
# urob/zmk-helpers tracking the "main" branch. Last updated 2025-02-17. Check https://github.com/urob/zmk-helpers/commits/main for updates.
ENV ZMK_COMMIT=aa3e5dd70fdd1b364fa9ad26f14425be613d180c \
    ZMK_HELPERS_COMMIT=8b9aace2c727fc494755ca25e12e33ff264df780

# Install curl and download ZMK and ZMK-helpers
RUN set -ex && \
    apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    curl -L https://github.com/zmkfirmware/zmk/archive/${ZMK_COMMIT}.tar.gz | tar xz && \
    curl -L https://github.com/urob/zmk-helpers/archive/${ZMK_HELPERS_COMMIT}.tar.gz | tar xz && \
    cd zmk-${ZMK_COMMIT} && \
    west init -l app && \
    west update && \
    west zephyr-export

# Set up volume mount point for config
VOLUME /workspace
WORKDIR /tmp/zmk-${ZMK_COMMIT}/app
