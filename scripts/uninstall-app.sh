#!/bin/bash
# Darling Android - 卸载应用脚本
# 版本: 0.1.0

DARLING_ANDROID_DIR="/opt/darling-android"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 卸载应用
uninstall_app() {
    local app_name="$1"
    
    if [ -z "$app_name" ]; then
        error "请指定应用名称"
        exit 1
    fi
    
    local apk_file="$DARLING_ANDROID_DIR/data/app/${app_name}.apk"
    
    if [ ! -f "$apk_file" ]; then
        error "应用不存在: $app_name"
        exit 1
    fi
    
    info "卸载应用: $app_name"
    rm -f "$apk_file"
    
    info "卸载完成！"
}

# 主函数
main() {
    case "$1" in
        remove|uninstall)
            uninstall_app "$2"
            ;;
        *)
            echo "用法: $0 <应用名称>"
            exit 1
            ;;
    esac
}

main "$@"
