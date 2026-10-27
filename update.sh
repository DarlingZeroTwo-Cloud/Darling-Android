#!/bin/bash
# Darling Android - 更新脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 更新
update() {
    info "更新 Darling Android..."
    
    # 检查版本
    bash scripts/check-update.sh
    
    # 拉取最新代码
    info "拉取最新代码..."
    git pull
    
    # 重新安装
    info "重新安装..."
    sudo bash install.sh
    
    info "更新完成！"
}

# 主函数
main() {
    case "$1" in
        update)
            update
            ;;
        *)
            echo "用法: $0 update"
            exit 1
            ;;
    esac
}

main "$@"
