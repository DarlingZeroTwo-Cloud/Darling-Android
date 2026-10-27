#!/bin/bash
# Darling Android - 服务管理脚本
# 版本: 0.1.0

DARLING_ANDROID_DIR="/opt/darling-android"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_root() {
    if [ "$EUID" -ne 0 ]; then
        error "请用 root 运行"
        exit 1
    fi
}

# 启动服务
start_service() {
    info "启动 Darling Android 服务..."
    
    # 挂载文件系统
    bash "$(dirname "$0")/chroot.sh" start &
    
    sleep 2
    info "服务已启动"
}

# 停止服务
stop_service() {
    info "停止 Darling Android 服务..."
    
    bash "$(dirname "$0")/chroot.sh" stop
    
    info "服务已停止"
}

# 重启服务
restart_service() {
    info "重启 Darling Android 服务..."
    
    stop_service
    sleep 1
    start_service
    
    info "服务已重启"
}

# 主函数
main() {
    check_root
    
    case "$1" in
        start)
            start_service
            ;;
        stop)
            stop_service
            ;;
        restart)
            restart_service
            ;;
        *)
            echo "用法: $0 {start|stop|restart}"
            exit 1
            ;;
    esac
}

main "$@"
