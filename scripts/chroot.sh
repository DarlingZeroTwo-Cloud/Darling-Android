#!/bin/bash
# Darling Android - chroot 启动脚本
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

# 挂载必要文件系统
mount_filesystems() {
    info "挂载文件系统..."
    
    # 挂载 /dev
    mount --bind /dev "$DARLING_ANDROID_DIR/dev" 2>/dev/null || warn "/dev 已挂载"
    
    # 挂载 /proc
    mount -t proc proc "$DARLING_ANDROID_DIR/proc" 2>/dev/null || warn "/proc 已挂载"
    
    # 挂载 /sys
    mount --bind /sys "$DARLING_ANDROID_DIR/sys" 2>/dev/null || warn "/sys 已挂载"
    
    # 挂载 /dev/pts
    mount --bind /dev/pts "$DARLING_ANDROID_DIR/dev/pts" 2>/dev/null || warn "/dev/pts 已挂载"
}

# 卸载文件系统
umount_filesystems() {
    info "卸载文件系统..."
    
    umount "$DARLING_ANDROID_DIR/dev/pts" 2>/dev/null || true
    umount "$DARLING_ANDROID_DIR/dev" 2>/dev/null || true
    umount "$DARLING_ANDROID_DIR/proc" 2>/dev/null || true
    umount "$DARLING_ANDROID_DIR/sys" 2>/dev/null || true
}

# 进入 chroot
enter_chroot() {
    info "进入 chroot 环境..."
    chroot "$DARLING_ANDROID_DIR" /system/bin/sh
}

# 主函数
main() {
    check_root
    
    case "$1" in
        start)
            mount_filesystems
            enter_chroot
            umount_filesystems
            ;;
        stop)
            umount_filesystems
            ;;
        *)
            echo "用法: $0 {start|stop}"
            exit 1
            ;;
    esac
}

main "$@"
