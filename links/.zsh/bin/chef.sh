if [ -d /opt/chef/embedded/bin ]; then
    export PATH=/opt/chef/embedded/bin:$PATH

    export ENV_NO_RVM=true
fi
