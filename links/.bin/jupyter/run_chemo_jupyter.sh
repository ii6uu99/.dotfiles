docker run -e GRANT_SUDO=yes -e NB_GID=8888 -e NB_UID=8888 -d -p 8888:8888 --rm \
    -v /jupyter:/home/jovyan/work --user root --name chemometrics \
    chemowakate/tutorial-7th start-notebook.sh \
    --NotebookApp.password='sha1:4d295dded8f2:6d42d26960204e16891c7aba6725edbd52fe4b29'

