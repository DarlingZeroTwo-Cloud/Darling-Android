#!/bin/bash
# Darling Android - 环境变量配置脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 配置环境变量
setup_env() {
    info "配置环境变量..."
    
    # 创建环境变量文件
    cat > /tmp/darling-android-env.sh << 'EOF'
# Darling Android 环境变量
export DARLING_ANDROID_DIR="/opt/darling-android"
export DARLING_ANDROID_VERSION="0.1.0"
export PATH="$PATH:/usr/local/bin"
EOF
    
    info "环境变量文件已创建: /tmp/darling-android-env.sh"
    info "使用: source /tmp/darling-android-env.sh"
}

# 主函数
main() {
    info "=== 环境变量配置 ==="
    setup_env
    info "=== 完成 ==="
}

main "$@"
