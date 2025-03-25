@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 设置环境变量以避免提示安装 Windows 版本的 VS Code
set "DONT_PROMPT_WSL_INSTALL=1"

REM 设置固定的 WSL 分发版名称 wsl -l -v
set "WSL_DISTRO=Ubuntu-24.04"

REM 检查 WSL 分发版是否存在
wsl -d %WSL_DISTRO% --exec echo >nul 2>&1
if %errorlevel% neq 0 (
    echo 未找到名为 %WSL_DISTRO% 的 WSL 分发版。
    pause
    exit /b
)

REM 运行 WSL 中的 Visual Studio Code 并自动输入 "y"
echo 正在启动 WSL 中的 Visual Studio Code...
wsl -d %WSL_DISTRO% -e sh -c "export DONT_PROMPT_WSL_INSTALL=1 && code %*"

endlocal
