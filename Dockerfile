ARG PY_VERSION=3.13
FROM python:${PY_VERSION}-slim

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

COPY --chown=python:python requirements.txt /home/python/docker-pip-tools/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/docker-pip-tools/requirements.txt

ENV PATH="/home/python/venv/bin:${PATH}" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1" \
    TZ="Etc/UTC"

ENTRYPOINT ["/bin/bash"]

LABEL org.opencontainers.image.source="https://github.com/williamjacksn/docker-pip-tools"
