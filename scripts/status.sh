#!/bin/bash
# Darling Android - 状态检查脚本
# 版本: 0.1.0

DARLING_ANDROID_DIR="/opt/darling-android"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查安装目录
check_install_dir() {
    info "检查安装目录..."
    
    if [ -d "$DARLING_ANDROID_DIR" ]; then
        echo -e "  ${GREEN}✓ 安装目录存在: $DARLING_ANDROID_DIR${NC}"
    else
        echo -e "  ${RED}✗ 安装目录不存在: $DARLING_ANDROID_DIR${NC}"
    fi
}

# 检查内核模块
check_kernel_modules() {
    info "检查内核模块..."
    
    if lsmod | grep -q binder; then
        echo -e "  ${GREEN}✓ binder 模块已加载${NC}"
    else
        echo -e "  ${YELLOW}⚠ binder 模块未加载${NC}"
    fi
    
    if lsmod | grep -q ashmem; then
        echo -e "  ${GREEN}✓ ashmem 模块已加载${NC}"
    else
        echo -e "  ${YELLOW}⚠ ashmem 模块未加载${NC}"
    fi
}

# 检查 CPU
check_cpu() {
    info "检查 CPU..."
    
    CPU_ARCH=$(uname -m)
    echo -e "  架构: $CPU_ARCH"
    
    if grep -q "Intel" /proc/cpuinfo; then
        echo -e "  品牌: ${GREEN}Intel${NC} (libhoudini)"
    elif grep -q "AMD" /proc/cpuinfo; then
        echo -e "  品牌: ${GREEN}AMD${NC} (libndk)"
    else
        echo -e "  品牌: ${YELLOW}未知${NC}"
    fi
}

# 检查 GPU
check_gpu() {
    info "检查 GPU..."
    
    if command -v lspci &> /dev/null; then
        GPU=$(lspci | grep -i vga | head -1)
        echo -e "  $GPU"
    else
        echo -e "  ${YELLOW}lspci 不可用${NC}"
    fi
}

# 主函数
main() {
    info "=== Darling Android 状态检查 ==="
    check_install_dir
    check_kernel_modules
    check_cpu
    check_gpu
    info "=== 检查完成 ==="
}

main "$@"
