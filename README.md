# Darling Android

在 Linux 上通过 chroot 方式原生运行 Android 应用。

## 特性

- **chroot 隔离**：无容器开销，性能更高
- **GPU 直通**：直接使用显卡驱动
- **ARM 转译**：自动检测 CPU，支持 Intel/AMD
- **无缝窗口**：Android 应用作为 Linux 窗口运行
- **兼容性**：支持 Android 7-13 应用

## 架构

```
Linux 内核
  ↓
chroot 环境（Android 根文件系统）
  ↓
Android 运行库（Bionic libc）
  ↓
ARM 转译（libhoudini / libndk）
  ↓
Android 应用
```

## 安装

```bash
sudo bash scripts/init.sh
```

## 使用

```bash
# 安装 APK
darling install /path/to/app.apk

# 运行应用
darling run com.example.app
```

## ARM 转译

- **Intel CPU**：使用 libhoudini（Intel 提供）
- **AMD CPU**：使用 libndk（AMD 提供）
- 自动检测，无需手动配置

## 支持的 Android 版本

- Android 7 (Nougat)
- Android 8 (Oreo)
- Android 9 (Pie)
- Android 10 (Q)
- Android 11 (R)
- Android 12 (S)
- Android 13 (Tiramisu)

## 开发状态

- [x] 项目初始化
- [x] chroot 环境
- [ ] Android 运行库部署
- [ ] ARM 转译集成
- [ ] 应用安装命令
- [ ] 无缝窗口运行
- [ ] GUI 管理工具

## 许可证

GPL-3.0
