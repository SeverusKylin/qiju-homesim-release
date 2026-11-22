# 栖居 HomeSim 客户发行包

此仓库提供栖居 HomeSim 的客户安装入口和发行包，原项目源代码继续保存在私有仓库。

## 下载

推荐打开 [Releases](https://github.com/SeverusKylin/qiju-homesim-release/releases/tag/v0.3.0)，下载 `qiju-homesim-customer-v0.3.0.zip`。它是已经封装好的可运行客户包，解压后按包内 README 启动。

Windows 可以下载 Release 中的 `install.ps1`，或者在 PowerShell 中执行：

```powershell
$env:QIJU_HOMESIM_DIR = "$PWD\qiju-homesim"
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

macOS/Linux 可以下载 Release 中的 `install.sh`，或者执行：

```bash
QIJU_HOMESIM_DIR="$PWD/qiju-homesim" bash ./install.sh
```

安装脚本会下载对应版本的压缩包，核对 SHA-256 后再解压。

模型 API 密钥和 Friend 配置不会随包发布，由客户在本地填写。发行包需要 Node.js 22.12 或更高版本。

- 版本清单：[release.json](./release.json)
- 更新记录：[UPDATES.md](./UPDATES.md)
- 安装脚本：[install.ps1](./install.ps1) · [install.sh](./install.sh)
- 客户发行包：[Releases](https://github.com/SeverusKylin/qiju-homesim-release/releases)

- 原项目（私有）：`SeverusKylin/qiju-homesim`

Release 中的 `SHA256SUMS` 可核对下载压缩包，解压后的发行包内 `SHA256SUMS.txt` 可继续核对包内文件完整性。
