#!/bin/bash
# Darling Android - 一键安装脚本
# 版本: 0.1.0

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_root() {
    if [ "$EUID" -ne 0 ]; then
        error "请用 root 运行"
        exit 1
    fi
}

# 安装依赖
install_deps() {
    info "安装依赖..."
    
    if command -v pacman &> /dev/null; then
        # Arch Linux
        pacman -S --noconfirm lxc python3 git
    elif command -v apt &> /dev/null; then
        # Debian/Ubuntu
        apt update
        apt install -y lxc python3 git
    elif command -v dnf &> /dev/null; then
        # Fedora
        dnf install -y lxc python3 git
    else
        warn "未知发行版，请手动安装 lxc python3 git"
    fi
}

# 运行初始化
run_init() {
    info "运行初始化..."
    bash scripts/init.sh
}

# 部署运行库
run_deploy_runtime() {
    info "部署 Android 运行库..."
    bash scripts/deploy-runtime.sh
}

# 部署 ARM 转译
run_deploy_arm() {
    info "部署 ARM 转译..."
    bash scripts/deploy-arm-translation.sh
}

# 安装 darling 命令
install_darling_cmd() {
    info "安装 darling 命令..."
    
    cp scripts/darling /usr/local/bin/darling
    chmod +x /usr/local/bin/darling
    
    info "darling 命令已安装到 /usr/local/bin/darling"
}

# 主函数
main() {
    info "=== Darling Android 一键安装 ==="
    check_root
    install_deps
    run_init
    run_deploy_runtime
    run_deploy_arm
    install_darling_cmd
    
    info "=== 安装完成 ==="
    info "使用: darling install <apk文件>"
    info "仓库: https://github.com/DarlingZeroTwo-Cloud/Darling-Android"
}

main "$@"
