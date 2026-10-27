#!/bin/bash
# Darling Android - 卸载脚本
# 版本: 0.1.0

set -e

DARLING_ANDROID_DIR="/opt/darling-android"

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

# 卸载 darling 命令
uninstall_darling_cmd() {
    info "卸载 darling 命令..."
    
    rm -f /usr/local/bin/darling
    
    info "darling 命令已卸载"
}

# 删除安装目录
remove_dir() {
    info "删除安装目录..."
    
    if [ -d "$DARLING_ANDROID_DIR" ]; then
        rm -rf "$DARLING_ANDROID_DIR"
        info "目录已删除: $DARLING_ANDROID_DIR"
    else
        warn "目录不存在: $DARLING_ANDROID_DIR"
    fi
}

# 卸载依赖（可选）
uninstall_deps() {
    info "卸载依赖（可选）..."
    
    read -p "是否卸载依赖？(y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v pacman &> /dev/null; then
            pacman -Rns --noconfirm lxc
        elif command -v apt &> /dev/null; then
            apt remove -y lxc
        elif command -v dnf &> /dev/null; then
            dnf remove -y lxc
        fi
        info "依赖已卸载"
    fi
}

# 主函数
main() {
    info "=== Darling Android 卸载 ==="
    check_root
    uninstall_darling_cmd
    remove_dir
    uninstall_deps
    
    info "=== 卸载完成 ==="
}

main "$@"
