#!/bin/bash
# Darling Android - 系统信息脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }

# 显示系统信息
show_system_info() {
    info "系统信息:"
    
    # 操作系统
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo -e "  系统: $PRETTY_NAME"
    fi
    
    # 内核
    echo -e "  内核: $(uname -r)"
    
    # 架构
    echo -e "  架构: $(uname -m)"
    
    # 主机名
    echo -e "  主机名: $(hostname)"
}

# 主函数
main() {
    info "=== 系统信息 ==="
    show_system_info
    info "=== 完成 ==="
}

main "$@"
