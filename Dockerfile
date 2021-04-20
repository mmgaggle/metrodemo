FROM python:3-alpine

WORKDIR /work
ADD * .

ENTRYPOINT [ "python3", "/work/compiler.py" ]