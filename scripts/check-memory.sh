#!/bin/bash
# Darling Android - 内存检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查内存
check_memory() {
    info "检查内存..."
    
    local total=$(free -h | grep Mem | awk '{print $2}')
    local used=$(free -h | grep Mem | awk '{print $3}')
    local available=$(free -h | grep Mem | awk '{print $7}')
    
    echo -e "  总内存: $total"
    echo -e "  已用: $used"
    echo -e "  可用: $available"
}

# 主函数
main() {
    info "=== 内存检查 ==="
    check_memory
    info "=== 检查完成 ==="
}

main "$@"
