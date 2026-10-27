#!/bin/bash
# Darling Android - 核心初始化脚本
# 版本: 0.1.0
# 功能: chroot 环境创建和 Android 运行库部署

set -e

# 配置
DARLING_ANDROID_DIR="/opt/darling-android"
ANDROID_ARCH="x86_64"
ANDROID_VERSION="13"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查 root 权限
check_root() {
    if [ "$EUID" -ne 0 ]; then
        error "请用 root 运行"
        exit 1
    fi
}

# 检查 CPU 架构
check_cpu() {
    CPU_ARCH=$(uname -m)
    info "检测到 CPU 架构: $CPU_ARCH"
    
    if [ "$CPU_ARCH" = "x86_64" ]; then
        info "支持 x86_64 架构"
    else
        error "不支持的架构: $CPU_ARCH"
        exit 1
    fi
}

# 检测 CPU 品牌
detect_cpu_brand() {
    if grep -q "Intel" /proc/cpuinfo; then
        CPU_BRAND="intel"
        info "检测到 Intel CPU，将使用 libhoudini ARM 转译"
    elif grep -q "AMD" /proc/cpuinfo; then
        CPU_BRAND="amd"
        info "检测到 AMD CPU，将使用 libndk ARM 转译"
    else
        CPU_BRAND="unknown"
        warn "未知 CPU 品牌，将使用通用 ARM 转译"
    fi
}

# 创建目录结构
create_dirs() {
    info "创建目录结构..."
    mkdir -p "$DARLING_ANDROID_DIR"
    mkdir -p "$DARLING_ANDROID_DIR"/{system,data,cache,lib,bin}
    mkdir -p "$DARLING_ANDROID_DIR"/system/{lib,bin,etc,usr}
}

# 挂载内核模块
mount_modules() {
    info "挂载内核模块..."
    
    # 检查 binder
    if lsmod | grep -q binder; then
        info "binder 模块已加载"
    else
        warn "binder 模块未加载，尝试加载..."
        modprobe binder_linux 2>/dev/null || warn "无法加载 binder 模块"
    fi
    
    # 检查 ashmem
    if lsmod | grep -q ashmem; then
        info "ashmem 模块已加载"
    else
        warn "ashmem 模块未加载，尝试加载..."
        modprobe ashmem_linux 2>/dev/null || warn "无法加载 ashmem 模块"
    fi
}

# 主函数
main() {
    info "=== Darling Android 初始化 ==="
    check_root
    check_cpu
    detect_cpu_brand
    create_dirs
    mount_modules
    
    info "=== 初始化完成 ==="
    info "Android 目录: $DARLING_ANDROID_DIR"
    info "CPU 品牌: $CPU_BRAND"
}

main "$@"
