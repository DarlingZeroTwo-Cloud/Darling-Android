#!/bin/bash
# Darling Android - 网络检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查网络
check_network() {
    info "检查网络..."
    
    # 检查 DNS
    if ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
        echo -e "  ${GREEN}✓ 网络连接正常${NC}"
    else
        echo -e "  ${RED}✗ 网络连接失败${NC}"
    fi
    
    # 检查 DNS 解析
    if ping -c 1 -W 2 github.com &> /dev/null; then
        echo -e "  ${GREEN}✓ DNS 解析正常${NC}"
    else
        echo -e "  ${RED}✗ DNS 解析失败${NC}"
    fi
}

# 主函数
main() {
    info "=== 网络检查 ==="
    check_network
    info "=== 检查完成 ==="
}

main "$@"
