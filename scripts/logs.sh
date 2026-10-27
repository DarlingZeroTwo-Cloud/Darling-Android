#!/bin/bash
# Darling Android - 日志查看脚本
# 版本: 0.1.0

DARLING_ANDROID_DIR="/opt/darling-android"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 查看日志
show_logs() {
    info "查看日志..."
    
    if [ -d "$DARLING_ANDROID_DIR/data/log" ]; then
        ls -la "$DARLING_ANDROID_DIR/data/log/"
    else
        warn "日志目录不存在"
    fi
}

# 主函数
main() {
    info "=== Darling Android 日志 ==="
    show_logs
    info "=== 完成 ==="
}

main "$@"
