from flask import (Flask,
                   request,
                   abort,
                   )
import os


# Flask app
app = Flask(__name__,
            static_folder='static', static_url_path='',
            instance_relative_config=True)
CONFIG = os.environ.get('CONFIG') or 'config.Development'
app.config.from_object('config.Default')
app.config.from_object(CONFIG)

# logging
import logging
from log.config import LoggingConfiguration
LoggingConfiguration.set(
    logging.DEBUG if os.getenv('DEBUG') else logging.INFO,
    'lightop.log', name='Web')


import json
from functools import wraps
import subprocess
import time


FIRST = True


def exception_to_json(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            result = func(*args, **kwargs)
            return result
        except (BadRequest,
                KeyError,
                ValueError,
                ) as e:
            result = {'error': {'code': 400,
                                'message': str(e)}}
        except PermissionDenied as e:
            result = {'error': {'code': 403,
                                'message': ', '.join(e.args)}}
        except (NotImplementedError, RuntimeError, AttributeError) as e:
            result = {'error': {'code': 500,
                                'message': ', '.join(e.args)}}
        return json.dumps(result)
    return wrapper


class PermissionDenied(Exception):
    pass


class BadRequest(Exception):
    pass


GET_VARS = '''
        var $_GET = {}, $_HASH = {}, appender = '';
        if(document.location.toString().indexOf('?') !== -1) {
            var query = document.location
                           .toString()
                           // get the query string
                           .replace(/^.*?\?/, '')
                           // and remove any existing hash string (thanks, @vrijdenker)
                           .replace(/#.*$/, '')
                           .split('&');

            for(var i=0, l=query.length; i<l; i++) {
               var aux = decodeURIComponent(query[i]).split('=');
               $_GET[aux[0]] = aux[1];
            }
        }

        if(document.location.hash.toString().indexOf('#') !== -1) {
            var query = document.location.hash
                           .toString()
                           // get the query string
                           .replace(/^.*?#/, '')
                           .split('&');

            for(var i=0, l=query.length; i<l; i++) {
               var aux = decodeURIComponent(query[i]).split('=');
               $_HASH[aux[0]] = aux[1];
            }
        }


        if ( $_GET.hasOwnProperty('password') ) {
            // appender = '&password=' + $_GET['password'];
            localStorage.setItem('password',$_GET['password']);
        }

        if ( $_HASH.hasOwnProperty('password') ) {
            // appender = '#password=' + $_HASH['password'];
            localStorage.setItem('password',$_HASH['password']);
        }
        '''

HTML_INDEX = '''<html><head>
    <title>Please wait.</title>
    </head><body>
    Please wait.  
    <script type="text/javascript">

        var w = window,
        d = document,
        e = d.documentElement,
        g = d.getElementsByTagName('body')[0],
        x = w.innerWidth || e.clientWidth || g.clientWidth,
        y = w.innerHeight|| e.clientHeight|| g.clientHeight;
        ''' + GET_VARS + '''
        w.location.href = "redirect.html?width=" + ( x - 100 ) + "&height=" + (parseInt(y) - 100) + appender;

    </script>
</body></html>'''

# UI.initSetting and WebUtil.getConfigVar in  noVNC/include/ui.js or noVNC/app/ui.js
HTML_REDIRECT = '''<html><head>
    <title>Please wait...</title>    
    </head><body>
    Please wait...
    <script type="text/javascript">
        var port = window.location.port;
        if (!port)
            port = window.location.protocol[4] == 's' ? 443 : 80;
        ''' + GET_VARS + '''
        window.location.href = "vnc.html?autoconnect=true&stylesheet=Black&resize=remote&true_color=true&reconnect=true" + appender;
    </script>
</body></html>'''


@app.route('/')
def index():
    return HTML_INDEX


@app.route('/redirect.html')
def redirectme():
    global FIRST

    if not FIRST:
        return HTML_REDIRECT

    env = {'width': 800, 'height': 600}
    if 'width' in request.args:
        env['width'] = request.args['width']
    if 'height' in request.args:
        env['height'] = request.args['height']
    
    if os.path.isfile("/home/user/.vnc/config.backup"):
        subprocess.check_call(r"sudo -u user bash /home/user/xrandr.sh {width} {height} 30".format(**env), shell=True)
    else:
        # add geometry to config file
        if os.path.isfile("/home/user/.vnc/passwd"):
            subprocess.check_call(r"sudo -u user cp /home/user/.vnc/config_pass.template /home/user/.vnc/config.current", shell=True)
        else:
            subprocess.check_call(r"sudo -u user cp /home/user/.vnc/config.template /home/user/.vnc/config.current", shell=True)
        subprocess.check_call(r"sudo -u user echo 'geometry={width}x{height}' >> /home/user/.vnc/config.current".format(**env), shell=True)
        subprocess.check_call(r"sudo -u user vncserver -kill :1", shell=True)
        subprocess.check_call(r"sudo -u user cp /home/user/.vnc/config /home/user/.vnc/config.backup", shell=True)
        subprocess.check_call(r"sudo -u user cp /home/user/.vnc/config.current /home/user/.vnc/config", shell=True)
        subprocess.check_call(r"sudo -u user vncserver", shell=True)
        subprocess.check_call(r"sudo -u user bash /home/user/xrandr.sh {width} {height} 30".format(**env), shell=True)

    return HTML_REDIRECT

    # supervisorctrl reload
    # subprocess.check_call(r"supervisorctl reload", shell=True)

    # check all running
    # for i in xrange(20):
    #    output = subprocess.check_output(r"supervisorctl status | grep RUNNING | wc -l", shell=True)
    #    if output.strip() == "4":
    #        FIRST = False
    #        return HTML_REDIRECT
    #    time.sleep(2)
    #abort(500, 'service is not ready, please restart container')


if __name__ == '__main__':
    app.run(host=app.config['ADDRESS'], port=app.config['PORT'])
