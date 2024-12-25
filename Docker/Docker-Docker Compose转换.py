import yaml
import gradio as gr
import pyperclip  # 导入 pyperclip 库

# Docker 命令转 Docker Compose 文件
def docker_run_to_compose(docker_cmd):
    compose = {
        "version": "3.8",
        "services": {
            "dockerui": {
                "image": None,
                "container_name": None,
                "restart": None,
                "ports": [],
                "volumes": []
            }
        }
    }

    parts = docker_cmd.split()
    i = 0
    while i < len(parts):
        part = parts[i]
        if part == '--name':
            i += 1
            compose["services"]["dockerui"]["container_name"] = parts[i]
        elif part == '--restart':
            i += 1
            compose["services"]["dockerui"]["restart"] = parts[i]
        elif part == '-p':
            i += 1
            port = parts[i].split(':')
            compose["services"]["dockerui"]["ports"].append(f"{port[0]}:{port[1]}")
        elif part == '-v':
            i += 1
            volume = parts[i].split(':')
            if len(volume) == 2:
                compose["services"]["dockerui"]["volumes"].append(f"{volume[0]}:{volume[1]}")
        i += 1

    compose["services"]["dockerui"]["image"] = parts[-1]

    if not compose["services"]["dockerui"]["volumes"]:
        del compose["services"]["dockerui"]["volumes"]

    return yaml.dump(compose, indent=4, sort_keys=False)

# Docker Compose 文件转 Docker 命令
def compose_to_docker(compose_content):
    compose = yaml.safe_load(compose_content)
    services = compose.get("services", {})
    docker_commands = []

    for service_name, service_config in services.items():
        docker_cmd = ["docker", "run"]
        if service_config.get("container_name"):
            docker_cmd.extend(["--name", service_config["container_name"]])
        if service_config.get("restart"):
            docker_cmd.extend(["--restart", service_config["restart"]])
        if "ports" in service_config:
            for port in service_config["ports"]:
                docker_cmd.extend(["-p", port])
        if "volumes" in service_config:
            for volume in service_config["volumes"]:
                docker_cmd.extend(["-v", volume])
        docker_cmd.append(service_config["image"])
        docker_commands.append(" ".join(docker_cmd))

    return "\n".join(docker_commands)

# 复制到剪贴板的函数
def copy_to_clipboard(output_text):
    pyperclip.copy(output_text)
    return f"已复制到剪贴板: {output_text}"

# 创建 Gradio 界面
with gr.Blocks() as demo:
    with gr.Tab("Docker 转 Docker Compose"):
        gr.Markdown("## Docker 命令转 Docker Compose 文件")
        docker_cmd_input = gr.Textbox(label="待输入 Docker 命令")
        output_textbox_docker_compose = gr.Textbox(label="输出 Docker Compose 文件")
        submit_button_docker_compose = gr.Button("提交")
        copy_button_docker_compose = gr.Button("复制输出内容")

        with gr.Row():
            submit_button_docker_compose.click(
                fn=docker_run_to_compose,
                inputs=[docker_cmd_input],
                outputs=[output_textbox_docker_compose]
            )
            copy_button_docker_compose.click(
                fn=copy_to_clipboard,
                inputs=[output_textbox_docker_compose],
                outputs=[output_textbox_docker_compose]
            )

    with gr.Tab("Docker Compose 转 Docker"):
        gr.Markdown("## Docker Compose 文件转 Docker 命令")
        compose_input = gr.Textbox(label="待输入 Docker Compose 文件")
        docker_cmd_output = gr.Textbox(label="输出 Docker 命令")
        submit_button_docker = gr.Button("提交")
        copy_button_docker = gr.Button("复制输出内容")

        with gr.Row():
            submit_button_docker.click(
                fn=compose_to_docker,
                inputs=[compose_input],
                outputs=[docker_cmd_output]
            )
            copy_button_docker.click(
                fn=copy_to_clipboard,
                inputs=[docker_cmd_output],
                outputs=[docker_cmd_output]
            )

demo.launch()
