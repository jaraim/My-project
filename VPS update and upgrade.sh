#!/bin/bash

# 自动检测系统，自动选择更新升级命令

# 检查系统发行版

distribution=$(cat /etc/os-release | awk -F'=' '{print $1}')

# 检查系统架构

architecture=$(uname -m)

# 检查可用更新

if [ "${distribution}" == "Ubuntu" ]; then
    available_updates=$(apt list --upgradable)
else
    echo "Unsupported distribution"
    exit 1
fi

# 选择更新升级命令

if [ -z "${available_updates}" ]; then
    echo "No updates available"
else
    upgrade_command="apt update && apt upgrade"

    echo "Running ${upgrade_command}"
    ${upgrade_command}
fi
