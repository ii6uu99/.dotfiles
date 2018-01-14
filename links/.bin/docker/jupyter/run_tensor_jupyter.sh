docker run -d -p 7777:8888 --rm --name tensorflow \
    tensorflow/tensorflow jupyter notebook --allow-root \
    --NotebookApp.password=sha1:4d295dded8f2:6d42d26960204e16891c7aba6725edbd52fe4b29
