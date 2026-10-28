#!/bin/bash
# Darling Android 一键更新脚本
set -e

echo "=== Darling Android 更新 ==="

# 拉取最新代码
cd /home/darling/Darling-Android
git pull

# 安装新版本
sudo cp scripts/darling.py /usr/local/bin/darling
sudo chmod +x /usr/local/bin/darling

# 测试
echo ""
echo "=== 更新完成 ==="
echo "运行: darling --help"
echo ""
darling --help
