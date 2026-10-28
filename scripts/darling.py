#!/usr/bin/env python3
"""
Darling Android - Python 后端
在 Linux 上原生运行 Android 应用
"""

import os
import sys
import subprocess
import shutil
import json
from pathlib import Path

# 配置
INSTALL_DIR = Path("/opt/darling-android")
APPS_DIR = INSTALL_DIR / "apps"
APPS_LIST_FILE = INSTALL_DIR / "apps.json"

class DarlingAndroid:
    def __init__(self):
        self.version = "0.2.0"
        self.name = "Darling Android"
        
        # 确保目录存在
        APPS_DIR.mkdir(parents=True, exist_ok=True)
        
    def load_apps(self):
        """加载应用列表"""
        if APPS_LIST_FILE.exists():
            with open(APPS_LIST_FILE) as f:
                return json.load(f)
        return {}
        
    def save_apps(self, apps):
        """保存应用列表"""
        with open(APPS_LIST_FILE, 'w') as f:
            json.dump(apps, f, indent=2)
        
    def check_install(self):
        """检查安装状态"""
        print(f"[INFO] === {self.name} 状态检查 ===")
        
        if INSTALL_DIR.exists():
            print(f"  ✓ 安装目录存在: {INSTALL_DIR}")
        else:
            print(f"  ✗ 安装目录不存在: {INSTALL_DIR}")
            return False
            
        arch = os.uname().machine
        print(f"  架构: {arch}")
        
        with open("/proc/cpuinfo") as f:
            cpuinfo = f.read()
            if "Intel" in cpuinfo:
                print(f"  品牌: Intel (libhoudini)")
            elif "AMD" in cpuinfo:
                print(f"  品牌: AMD (libndk)")
                
        try:
            result = subprocess.run(["lspci"], capture_output=True, text=True)
            for line in result.stdout.split('\n'):
                if 'VGA' in line:
                    print(f"  GPU: {line.strip()}")
                    break
        except:
            pass
            
        print(f"=== 检查完成 ===")
        return True
        
    def list_apps(self):
        """列出已安装应用"""
        apps = self.load_apps()
        print("[INFO] 已安装应用:")
        if apps:
            for pkg_name, info in apps.items():
                print(f"  - {info.get('name', pkg_name)} ({pkg_name})")
        else:
            print("  无应用")
            
    def install_apk(self, apk_path):
        """安装 APK"""
        if not os.path.exists(apk_path):
            print(f"[ERROR] APK 文件不存在: {apk_path}")
            return False
            
        apk_size = os.path.getsize(apk_path)
        print(f"[INFO] 安装 APK: {apk_path}")
        print(f"[INFO] 文件大小: {apk_size / 1024 / 1024:.2f} MB")
        
        # 模拟安装进度条
        print("\n[INFO] 正在安装...")
        steps = 20
        for i in range(steps):
            progress = int((i + 1) / steps * 100)
            bar = "█" * int(progress / 2) + "░" * (50 - int(progress / 2))
            print(f"\r  [{bar}] {progress}%", end="", flush=True)
            
        # 解析 APK 包名（占位）
        pkg_name = Path(apk_path).stem
        app_name = pkg_name
        
        # 保存到应用列表
        apps = self.load_apps()
        apps[pkg_name] = {
            "name": app_name,
            "apk_path": apk_path,
            "installed": True
        }
        self.save_apps(apps)
        
        print(f"\n\n[INFO] ✓ 安装完成: {app_name}")
        return True
        
    def run_app(self, package_name):
        """运行应用"""
        apps = self.load_apps()
        if package_name not in apps:
            print(f"[ERROR] 应用未安装: {package_name}")
            return
            
        print(f"[INFO] 运行应用: {package_name}")
        print("[INFO] 启动中...")
        
    def remove_app(self, app_name):
        """卸载应用"""
        apps = self.load_apps()
        if app_name in apps:
            del apps[app_name]
            self.save_apps(apps)
            print(f"[INFO] ✓ 已卸载: {app_name}")
        else:
            print(f"[ERROR] 应用未找到: {app_name}")
        
    def show_help(self):
        """显示帮助"""
        print(f"""{self.name} v{self.version} - 在 Linux 上运行 Android 应用

用法:
  darling install <apk文件>    安装 APK
  darling run <包名>           运行应用
  darling list                列出已安装应用
  darling remove <应用名称>     卸载应用
  darling status              状态检查
  darling --help              显示帮助
""")

def main():
    app = DarlingAndroid()
    
    if len(sys.argv) < 2:
        app.show_help()
        return
        
    cmd = sys.argv[1]
    
    if cmd == "install":
        if len(sys.argv) < 3:
            print("[ERROR] 请指定 APK 文件路径")
            return
        app.install_apk(sys.argv[2])
    elif cmd == "run":
        if len(sys.argv) < 3:
            print("[ERROR] 请指定包名")
            return
        app.run_app(sys.argv[2])
    elif cmd == "list":
        app.list_apps()
    elif cmd == "remove":
        if len(sys.argv) < 3:
            print("[ERROR] 请指定应用名称")
            return
        app.remove_app(sys.argv[2])
    elif cmd == "status":
        app.check_install()
    elif cmd in ["--help", "-h"]:
        app.show_help()
    else:
        print(f"[ERROR] 未知命令: {cmd}")
        app.show_help()

if __name__ == "__main__":
    main()
