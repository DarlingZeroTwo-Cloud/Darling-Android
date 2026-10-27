#!/bin/bash
# Darling Android - 磁盘检查脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查磁盘空间
check_disk() {
    info "检查磁盘空间..."
    
    # 根目录
    local root_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    echo -e "  根目录使用: ${root_usage}%"
    
    if [ $root_usage -gt 90 ]; then
        echo -e "  ${RED}⚠ 根目录空间不足${NC}"
    fi
    
    # home 目录
    if [ -d /home ]; then
        local home_usage=$(df /home | tail -1 | awk '{print $5}' | sed 's/%//')
        echo -e "  home 使用: ${home_usage}%"
    fi
}

# 主函数
main() {
    info "=== 磁盘检查 ==="
    check_disk
    info "=== 检查完成 ==="
}

main "$@"
