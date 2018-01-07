These scripts help to use anaconda throught docker images.

Usage:  

Build image:  
```bash
build.sh
```

Use anaconda with jupiter notebooks:  
```bash
anaconda-jupiter-notebook.sh [<working_directory>]
```
Unless otherwise specified, current working directory will be used.

After that you can connect to notebook at localhost:8888, given working directory will be mounted also.

For easy of use it, you can add 'anaconda', 'anaconda-python2' directories of this repository to PATH variable.

[Anaconda docker files](https://github.com/ContinuumIO/docker-images)
