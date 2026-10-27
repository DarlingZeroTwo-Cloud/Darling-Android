#!/bin/bash
# Darling Android - GPU 检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查 GPU
check_gpu() {
    info "检查 GPU..."
    
    if command -v lspci &> /dev/null; then
        local gpu=$(lspci | grep -i vga | head -1)
        echo -e "  GPU: $gpu"
        
        # 检查驱动
        if lsmod | grep -q i915; then
            echo -e "  ${GREEN}✓ Intel i915 驱动${NC}"
        elif lsmod | grep -q amdgpu; then
            echo -e "  ${GREEN}✓ AMD amdgpu 驱动${NC}"
        elif lsmod | grep -q nvidia; then
            echo -e "  ${GREEN}✓ NVIDIA 驱动${NC}"
        else
            echo -e "  ${YELLOW}⚠ 未知 GPU 驱动${NC}"
        fi
    else
        warn "lspci 不可用"
    fi
}

# 主函数
main() {
    info "=== GPU 检查 ==="
    check_gpu
    info "=== 检查完成 ==="
}

main "$@"
