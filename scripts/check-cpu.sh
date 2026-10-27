#!/bin/bash
# Darling Android - CPU 检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查 CPU
check_cpu() {
    info "检查 CPU..."
    
    # 架构
    local arch=$(uname -m)
    echo -e "  架构: $arch"
    
    # 品牌
    if grep -q "Intel" /proc/cpuinfo; then
        echo -e "  品牌: ${GREEN}Intel${NC} (libhoudini)"
    elif grep -q "AMD" /proc/cpuinfo; then
        echo -e "  品牌: ${GREEN}AMD${NC} (libndk)"
    else
        echo -e "  品牌: ${YELLOW}未知${NC}"
    fi
    
    # 核心数
    local cores=$(nproc)
    echo -e "  核心数: $cores"
}

# 主函数
main() {
    info "=== CPU 检查 ==="
    check_cpu
    info "=== 检查完成 ==="
}

main "$@"
