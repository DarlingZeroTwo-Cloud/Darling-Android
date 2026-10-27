# 目录结构

```
darling-android/
├── scripts/
│   ├── init.sh              # 初始化脚本
│   ├── chroot.sh            # chroot 环境管理
│   ├── deploy-runtime.sh    # Android 运行库部署
│   ├── deploy-arm-translation.sh  # ARM 转译集成
│   ├── darling              # 主命令行工具
│   ├── version.sh           # 版本信息
│   ├── status.sh            # 状态检查
│   ├── list-apps.sh         # 应用列表
│   ├── uninstall-app.sh      # 卸载应用
│   ├── service.sh           # 服务管理
│   └── logs.sh              # 日志查看
├── install.sh               # 一键安装脚本
├── uninstall.sh             # 卸载脚本
├── test.sh                  # 测试脚本
├── darling.conf             # 配置文件
├── README.md                # 英文说明
├── README_zh-CN.md          # 中文说明
├── LICENSE                  # GPL-3.0
├── CHANGELOG.md             # 更新日志
├── CONTRIBUTING.md          # 贡献指南
├── SECURITY.md              # 安全策略
├── CODE_OF_CONDUCT.md       # 行为准则
├── .gitignore               # Git 忽略
├── .gitattributes           # Git 属性
└── .github/
    └── workflows/
        └── test.yml         # GitHub Actions
```
