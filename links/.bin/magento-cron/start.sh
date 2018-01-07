#!/bin/bash
if [[ -f /scripts/run.sh ]]; then
	/scripts/run.sh
fi
pip install --upgrade pip
pip install ipython==5.0
pip install python-magento
supervisord -n 
