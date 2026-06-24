FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y --no-install-recommends \
        nmap \
        hydra \
        python3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["sleep", "infinity"]
