FROM ubuntu:latest

RUN sed -i s/archive.ubuntu.com/mirrors.ustc.edu.cn/g /etc/apt/sources.list
RUN sed -i s/security.ubuntu.com/mirrors.ustc.edu.cn/g /etc/apt/sources.list

COPY ./ /www/

RUN apt update && \
    apt install python3 python3-pip -y && \
    # pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    adduser flask

USER flask
RUN pip install -r /www/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

ENTRYPOINT ["python3", "/www/__init__.py" ]