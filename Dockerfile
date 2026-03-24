FROM public.ecr.aws/lts/ubuntu:24.04_stable

# 安裝必要套件
RUN apt-get update && apt-get install -y \
    curl sudo git jq libicu74 docker.io yq \
    && rm -rf /var/lib/apt/lists/*

# 建立 runner 使用者（不建議用 root 執行）
RUN useradd --gid 0 --create-home runner
WORKDIR /home/runner

# 下載並解壓縮 GitHub Runner 程式 (版本號請依官方最新版更新)
ARG RUNNER_VERSION="2.333.0"
RUN curl --location https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz | \
    tar --extract --gzip --file -

# 複製啟動腳本 (需自行撰寫 entrypoint.sh)
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

USER runner
ENTRYPOINT ["./entrypoint.sh"]