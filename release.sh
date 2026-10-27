#!/bin/bash
# Darling Android - 发布脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

VERSION="0.1.0"

# 发布
release() {
    info "发布 Darling Android v$VERSION..."
    
    # 构建
    bash build.sh build
    
    # 创建 tar 包
    tar -czf "darling-android-v${VERSION}.tar.gz" build/
    
    info "发布完成！"
    info "输出: darling-android-v${VERSION}.tar.gz"
}

# 主函数
main() {
    case "$1" in
        release)
            release
            ;;
        *)
            echo "用法: $0 release"
            exit 1
            ;;
    esac
}

main "$@"
