#!/bin/bash
wget https://github.com/trailofbits/algo/archive/master.zip
mv master.zip algo-master.zip
unzip algo-master.zip
cd algo-master
python -m ensurepip --user
python -m pip install --user --upgrade virtualenv
python -m virtualenv env && source env/bin/activate && python -m pip install -U pip && python -m pip install -r requirements.txt
echo "Get ready to define your list of users..."
sleep 10
nano config.cfg
echo "Now have you got your AWS Secret Keys to hand?"
sleep 10
./algo
