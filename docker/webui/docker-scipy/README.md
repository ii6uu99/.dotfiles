Supported tags and respective `Dockerfile` links:

・latest ([versions/0.x/Dockerfile](https://github.com/pottava/docker-scipy/blob/master/versions/0.x/Dockerfile))  
・0.19 ([versions/0.x/Dockerfile](https://github.com/pottava/docker-scipy/blob/master/versions/0.x/Dockerfile))  
・0.19-note ([jupyter/versions/0.x/Dockerfile](https://github.com/pottava/docker-scipy/blob/master/jupyter/versions/0.x/Dockerfile))


### Usage

SciPy was installed with OpenBLAS & LAPACK.

```
$ docker run --rm pottava/scipy -c 'import scipy; scipy.show_config()'
```

Using the Python default interpreter:

```
$ docker run --rm -it pottava/scipy
Python 3.5.2 (default, Dec 22 2016, 10:15:38)
[GCC 6.2.1 20160822] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
>>> import scipy
>>> print(scipy.__version__)
0.19.0
>>>
>>> import numpy
>>> print(numpy.__version__)
1.12.1
>>>
```

With iPython:

```
$ docker run --rm -it pottava/scipy:0.19-note ipython
```

With Jupyter notebook:

```
$ docker run --rm -it -p 80:8888 pottava/scipy:0.19-note
```

With Jupyter notebook and Pandas:

```
$ docker run --rm -it -p 80:8888 pottava/pandas
```
