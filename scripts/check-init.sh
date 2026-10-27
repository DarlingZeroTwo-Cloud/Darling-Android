#!/bin/bash
# Darling Android - 初始化检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查依赖
check_deps() {
    info "检查依赖..."
    
    local missing=0
    
    for cmd in bash python3 git mount chroot; do
        if command -v $cmd &> /dev/null; then
            echo -e "  ${GREEN}✓ $cmd${NC}"
        else
            echo -e "  ${RED}✗ $cmd${NC}"
            missing=$((missing + 1))
        fi
    done
    
    if [ $missing -gt 0 ]; then
        error "缺少 $missing 个依赖"
        exit 1
    fi
    
    info "所有依赖都已安装"
}

# 检查内核模块
check_modules() {
    info "检查内核模块..."
    
    if lsmod | grep -q binder; then
        echo -e "  ${GREEN}✓ binder${NC}"
    else
        echo -e "  ${YELLOW}⚠ binder 未加载${NC}"
    fi
    
    if lsmod | grep -q ashmem; then
        echo -e "  ${GREEN}✓ ashmem${NC}"
    else
        echo -e "  ${YELLOW}⚠ ashmem 未加载${NC}"
    fi
}

# 主函数
main() {
    info "=== 初始化检查 ==="
    check_deps
    check_modules
    info "=== 检查完成 ==="
}

main "$@"
