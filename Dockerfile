FROM gcc:15.2.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       bash \
       cmake \
       gdb \
       git \
       make \
       python3 \
       python3-pip \
       python3-venv \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
