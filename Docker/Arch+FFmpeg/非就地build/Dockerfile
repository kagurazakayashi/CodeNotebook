FROM archlinux:latest

# 设置时区和基本语言环境变量（这些是运行时常用的，建议保留）
ENV TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -eux; \
    # 1. 初始化密钥并更新系统
    pacman-key --init; \
    pacman-key --populate archlinux; \
    pacman -Syu --noconfirm; \
    \
    # 2. 安装基础软件和编解码库 (全部来自官方 Extra 仓库)
    # 注意：ffmpeg-full 已替换为官方 ffmpeg
    pacman -S --noconfirm --needed \
      tzdata glibc figlet \
      xz imagemagick vim nano openssl zsh 7zip gnupg htop \
      aom svt-av1 rav1e libvpx x264 x265 xvidcore vmaf \
      opus libvorbis lame \
      noto-fonts-cjk \
      ffmpeg; \
    \
    # 3. 探测并安装可选运行库 (fdk-aac 在官方源可能受限，视情况而定)
    for PKG in libfdk-aac fdk-aac; do \
        pacman -Si "$PKG" >/dev/null 2>&1 && pacman -S --noconfirm --needed "$PKG" || true; \
    done; \
    \
    # 4. 生成 Locale
    sed -ri 's|^#\s*(zh_CN\.UTF-8)\s+UTF-8$|\1 UTF-8|' /etc/locale.gen; \
    sed -ri 's|^#\s*(en_US\.UTF-8)\s+UTF-8$|\1 UTF-8|' /etc/locale.gen; \
    locale-gen; \
    \
    # 5. 清理缓存
    pacman -Scc --noconfirm; \
    rm -rf /var/cache/pacman/pkg/* /tmp/*

# 设置默认 Shell 为 zsh
SHELL ["/usr/bin/zsh", "-lc"]

# 容器启动时进入交互式 zsh
ENTRYPOINT ["/usr/bin/zsh", "-l", "-i"]
CMD []
