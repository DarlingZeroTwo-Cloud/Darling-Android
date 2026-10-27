#!/bin/bash
# Darling Android - 清理脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 清理缓存
clean_cache() {
    info "清理缓存..."
    
    # 清理构建目录
    rm -rf build/
    
    # 清理 tar 包
    rm -f *.tar.gz
    
    info "缓存清理完成！"
}

# 主函数
main() {
    case "$1" in
        clean)
            clean_cache
            ;;
        *)
            echo "用法: $0 clean"
            exit 1
            ;;
    esac
}

main "$@"
