#!/bin/bash
# Darling Android - 应用列表脚本
# 版本: 0.1.0

DARLING_ANDROID_DIR="/opt/darling-android"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 列出已安装应用
list_apps() {
    info "已安装应用:"
    
    if [ -d "$DARLING_ANDROID_DIR/data/app" ]; then
        ls -1 "$DARLING_ANDROID_DIR/data/app"/*.apk 2>/dev/null | while read apk; do
            name=$(basename "$apk" .apk)
            echo "  - $name"
        done
    else
        warn "没有已安装的应用"
    fi
}

# 主函数
main() {
    info "=== Darling Android 应用列表 ==="
    list_apps
    info "=== 完成 ==="
}

main "$@"
