# coding:utf-8

import time

def show():
    while True:
        print('hello world %s' %(time.time()))
        time.sleep(10)


if __name__=="__main__":
    show()
