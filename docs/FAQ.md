# 常见问题

## Q: Darling Android 和 Waydroid 有什么区别？

A: Darling Android 使用 chroot 隔离，Waydroid 使用 LXC 容器。chroot 更轻量，性能更高，但隔离性不如容器。

## Q: 支持哪些 CPU？

A: 支持 x86_64 架构的 Intel 和 AMD CPU。ARM 应用通过 libhoudini（Intel）或 libndk（AMD）转译运行。

## Q: 支持哪些显卡？

A: 支持所有 Linux 支持的显卡，包括 Intel、AMD、NVIDIA。GPU 加速直接使用 Linux 驱动。

## Q: 支持哪些 Android 版本的应用？

A: 支持 Android 7 到 Android 13 的应用。

## Q: 性能如何？

A: chroot 方式无容器开销，性能接近原生。GPU 直通加速，3D 游戏也能流畅运行。

## Q: 如何安装 APK？

A: 使用命令 `darling install /path/to/app.apk`。

## Q: 如何运行应用？

A: 使用命令 `darling run com.example.app`。

## Q: 如何列出已安装的应用？

A: 使用命令 `darling list`。

## Q: 如何卸载应用？

A: 使用命令 `darling remove com.example.app`。

## Q: 支持无缝窗口吗？

A: 计划支持 Android 应用作为 Linux 窗口运行，目前正在开发中。

## Q: 需要 root 权限吗？

A: 是的，安装和初始化需要 root 权限。运行应用不需要 root。

## Q: 支持哪些 Linux 发行版？

A: 支持 Arch Linux、Debian、Ubuntu、Fedora 等主流发行版。
