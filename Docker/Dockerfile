FROM python:3.10-alpine

WORKDIR /app

COPY ./Docker-Docker Compose转换 /app

RUN pip install gradio pyperclip pyyaml

CMD ["gunicorn", "-b", "0.0.0.0:7860", "转换:demo"]
