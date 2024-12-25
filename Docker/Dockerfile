FROM python:3.10-alpine

WORKDIR /app

COPY ./converter.py /app

RUN pip install gradio pyperclip

CMD ["python", "converter.py"]
