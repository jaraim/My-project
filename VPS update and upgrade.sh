# 检查系统发行版
distribution=$(cat /etc/os-release | awk -F'=' '{print $1}')

# 检查可用更新
if [ "${distribution}" == "CentOS" ]; then
    available_updates=$(yum list available)
elif [ "${distribution}" == "Ubuntu" ]; then
    available_updates=$(apt list --upgradable)
else
    echo "Unsupported distribution"
    exit 1
fi

# 选择更新升级命令
if [ -z "${available_updates}" ]; then
    echo "No updates available"
else
    if [ "${distribution}" == "CentOS" ]; then
        upgrade_command="yum update && yum upgrade"
    elif [ "${distribution}" == "Ubuntu" ]; then
        upgrade_command="apt update && apt upgrade"
    fi

    echo "Running ${upgrade_command}"
    ${upgrade_command}
fi
