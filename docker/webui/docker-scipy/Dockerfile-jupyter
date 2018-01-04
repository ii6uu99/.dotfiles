# SciPy with Jupyter notebook
#
# docker run --rm -it pottava/scipy:0.19-note ipython
# docker run --rm -it -p 80:8888 pottava/scipy:0.19-note

FROM pottava/scipy:0.19

ENV JUPYTER_VERSION=1.0.0

RUN apk --no-cache add --virtual build-deps g++ python3-dev \

    # Install Tini as a init system for jupyter containers
    && apk --no-cache add tini \

    # Install Jupyter
    && pip3 install "jupyter == ${JUPYTER_VERSION}" \

    # Clean up
    && find / -type d -name tests -depth -exec rm -rf {} \; \
    && find / -type d -name test -depth -exec rm -rf {} \; \
    && find / -type d -name \__pycache__ -depth -exec rm -rf {} \; \
    && find / -type d -name '*.egg-info' -depth -exec rm -rf {} \; \
    && apk del --purge -r build-deps \
    && rm -rf /root/.cache

WORKDIR /root/notebook

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter", "notebook", "--no-browser", "--port=8888", "--ip=0.0.0.0"]
