#!/bin/bash
# Darling Android - 测试脚本
# 版本: 0.1.0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

PASSED=0
FAILED=0

# 测试函数
test_case() {
    local name="$1"
    local cmd="$2"
    
    info "测试: $name"
    
    if eval "$cmd" &> /dev/null; then
        echo -e "  ${GREEN}✓ 通过${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "  ${RED}✗ 失败${NC}"
        FAILED=$((FAILED + 1))
    fi
}

# 检查依赖
test_deps() {
    info "=== 测试依赖 ==="
    
    test_case "bash" "command -v bash"
    test_case "python3" "command -v python3"
    test_case "git" "command -v git"
}

# 检查脚本
test_scripts() {
    info "=== 测试脚本 ==="
    
    test_case "init.sh" "test -x scripts/init.sh"
    test_case "chroot.sh" "test -x scripts/chroot.sh"
    test_case "deploy-runtime.sh" "test -x scripts/deploy-runtime.sh"
    test_case "deploy-arm-translation.sh" "test -x scripts/deploy-arm-translation.sh"
    test_case "darling" "test -x scripts/darling"
    test_case "install.sh" "test -x install.sh"
    test_case "uninstall.sh" "test -x uninstall.sh"
}

# 检查文件
test_files() {
    info "=== 测试文件 ==="
    
    test_case "README.md" "test -f README.md"
    test_case "darling.conf" "test -f darling.conf"
    test_case ".gitignore" "test -f .gitignore"
}

# 输出结果
print_result() {
    info "=== 测试结果 ==="
    echo -e "通过: ${GREEN}$PASSED${NC}"
    echo -e "失败: ${RED}$FAILED${NC}"
    
    if [ $FAILED -eq 0 ]; then
        echo -e "${GREEN}所有测试通过！${NC}"
    else
        echo -e "${RED}有测试失败！${NC}"
        exit 1
    fi
}

# 主函数
main() {
    cd "$(dirname "$0")"
    
    test_deps
    test_scripts
    test_files
    print_result
}

main "$@"
