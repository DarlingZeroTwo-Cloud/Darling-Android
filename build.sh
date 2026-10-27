#!/bin/bash
# Darling Android - 构建脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 构建
build() {
    info "构建 Darling Android..."
    
    # 创建构建目录
    mkdir -p build
    
    # 复制脚本
    cp scripts/* build/
    
    # 设置执行权限
    chmod +x build/*
    
    info "构建完成！输出目录: build/"
}

# 清理
clean() {
    info "清理构建目录..."
    
    rm -rf build
    
    info "清理完成！"
}

# 主函数
main() {
    case "$1" in
        build)
            build
            ;;
        clean)
            clean
            ;;
        *)
            echo "用法: $0 {build|clean}"
            exit 1
            ;;
    esac
}

main "$@"
