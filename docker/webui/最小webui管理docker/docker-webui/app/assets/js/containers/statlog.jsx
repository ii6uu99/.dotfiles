var statistics = {
      previous: [],
      current: []
    },
    log_conf = {
      refresh: app.storage.get('refresh-window-stat', 1),
      count: app.storage.get('monitoring-count-stat', 20)
    },
    isViewOnly = false;

function _action(flag) {
  if (isViewOnly) return;

  var id = $('#container-id').val(),
      action = '', msg = '';
  switch (flag) {
  case  1: action = 'restart'; msg = 'restarted'; break;
  case  2: action = 'start'; msg = 'started'; break;
  case  3: action = 'stop'; msg = 'stopped'; break;
  default: return;
  }
  app.func.ajax({type: 'POST', url: '/api/container/'+action+'/'+id, success: function (data) {
    var message = data.error ? data.error : msg + ' successfully.';
    alert(message);
  }});
}

function setRefreshWindow(value) {
  var a = $('#refresh-window a[href="#'+value+'"]'),
      group = a.closest('.btn-group').removeClass('open');
  log_conf.refresh = value;
  app.storage.set('refresh-window-stat', value);
  group.find('.caption').text('refresh / '+a.text()).blur();
}
function setMonitoringCount(value) {
  var a = $('#monitoring-count a[href="#'+value+'"]'),
      group = a.closest('.btn-group').removeClass('open');
  log_conf.count = value;
  app.storage.set('monitoring-count-stat', value);
  group.find('.caption').text(a.text()).blur();
}

var StatTableRow = React.createClass({
  propTypes: {
    content: React.PropTypes.object
  },
  render: function() {
    var stat = this.props.content.current,
        prev = this.props.content.previous,
        cpu_delta = 0, system_delta = 0, cpu_percent = 0;
    if (prev && stat.cpu_stats) {
      cpu_delta = stat.cpu_stats.cpu_usage.total_usage - prev.cpu_stats.cpu_usage.total_usage;
      system_delta = stat.cpu_stats.system_cpu_usage - prev.cpu_stats.system_cpu_usage;
    }
    if ((system_delta > 0) && (cpu_delta > 0)) {
      cpu_percent = 100.0 * cpu_delta / system_delta * stat.cpu_stats.cpu_usage.percpu_usage.length;
    }
    var time = '',
        mem = {usage: '-', max: '-', limit: '-', percent: 0},
        network = {in: '', out: '', inPacket: '', outPacket: ''};
    if (stat.read) {
      time = stat.read.substring(5, 19).replace(/-/, '/').replace('T', ' ');
      mem = {
        usage: app.func.byteFormat(stat.memory_stats.usage),
        max: app.func.byteFormat(stat.memory_stats.max_usage),
        limit: app.func.byteFormat(stat.memory_stats.limit),
        percent: stat.memory_stats.usage * 100 / stat.memory_stats.limit
      };
      network = {
        in: app.func.byteFormat(stat.networks.eth0.rx_bytes),
        out: app.func.byteFormat(stat.networks.eth0.tx_bytes),
        inPacket: stat.networks.eth0.rx_packets,
        outPacket: stat.networks.eth0.tx_packets
      };
    }
    return (
        <tr>
          <td className="data-name">{time}</td>
          <td className="data-name">{(cpu_percent+'').substring(0, 4)}%</td>
          <td className="data-name">{mem.usage} / {mem.max} / {mem.limit}</td>
          <td className="data-name">{(mem.percent+'').substring(0, 4)}%</td>
          <td className="data-name">{network.in} / {network.out}</td>
          <td className="data-name">{network.inPacket} / {network.outPacket}</td>
        </tr>
    );
  }
});

var StatTable = React.createClass({
  getInitialState: function() {
    return {data: {previous: [], current: []}};
  },
  load: function(sender) {
    var id = $('#container-id').val(),
        client = $('#client-id').val();
    client = client ? '?client='+client : '';
    app.func.ajax({type: 'GET', url: '/api/container/stats/'+id+client, success: function (data) {
      if (data.error) {
        statistics.previous = true;
        statistics.current = data;
      } else {
        statistics.previous = statistics.current;
        statistics.current = data;
      }
      sender.setState({data: statistics});
    }});
  },
  componentDidMount: function() {
    this.load(this);
  },
  componentWillReceiveProps: function() {
    this.load(this);
  },
  render: function() {
    var data = this.state.data, rows = [];
    $.map(data.current, function (current, index) {
      rows.push(<StatTableRow key={index} content={{previous: data.previous[index], current: current}} />)
    });
    return (
        <table className="table table-striped table-hover">
          <thead>
            <tr>
              <th>Time</th>
              <th>CPU %</th>
              <th>MEM USAGE / MAX / LIMIT</th>
              <th>MEM %</th>
              <th>NET I/O</th>
              <th>NET I/O (packet)</th>
            </tr>
          </thead>
          <tbody>{rows}</tbody>
        </table>
    );
  }
});


var LogTableRow = React.createClass({
  propTypes: {
    content: React.PropTypes.object
  },
  render: function() {
    var log = this.props.content;
    return (
        <tr>
          <td className="data-name no-wrap">{log.time}</td>
          <td className="data-name">{log.type}</td>
          <td className="data-name">{log.log.replace(/\[[0-9]+m/g, '')}</td>
        </tr>
    );
  }
});

var LogTable = React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  load: function(sender) {
    var id = $('#container-id').val(),
        client = $('#client-id').val(),
        data = {count: log_conf.count};
    if (client) data.client = client;
    app.func.ajax({type: 'GET', url: '/api/container/logs/'+id, data: data, success: function (data) {
      if (data.error) {
        sender.setState({data: []});
        return;
      }
      var stream = [];
      $.map(data.stdout, function (record) {
        stream.push({
          type: 'stdlog',
          key: record.substring(0, 30),
          time: record.substring(11, 19),
          log: record.substring(31)
        });
      });
      $.map(data.stderr, function (record) {
        stream.push({
          type: 'stderr',
          key: record.substring(0, 30),
          time: record.substring(11, 19),
          log: record.substring(31)
        });
      });
      stream.sort(function (a, b) {
        var diff = new Date(a.key.substring(0, 19)+'Z') - new Date(b.key.substring(0, 19)+'Z');
        if (diff != 0) return diff;
        return parseInt(a.key.substring(20), 10) - parseInt(b.key.substring(20), 10);
      })
      sender.setState({data: stream});
      $('.logs').fadeIn();
    }});
  },
  componentDidMount: function() {
    this.load(this);
  },
  componentWillReceiveProps: function() {
    this.load(this);
  },
  render: function() {
    var rows = [];
    this.state.data.map(function(record, index) {
      if (! record.log) return;
      rows.push(<LogTableRow key={index} content={record} />)
    });
    return (
        <table className="table table-striped table-hover">
          <thead>
            <tr>
              <th>Time</th>
              <th>Type</th>
              <th>Log</th>
            </tr>
          </thead>
          <tbody>{rows}</tbody>
        </table>
    );
  }
});

$(document).ready(function () {
  $('#menu-logs').addClass('active');
  isViewOnly = ($('#mode-view-only').val() == 'true');

  $('#actions>.btn-default').hover(function () {
    $(this).addClass($(this).attr('data-hover'));
  }, function () {
    $(this).removeClass($(this).attr('data-hover'));
  }).click(function (e) {
    _action(parseInt($(this).blur().attr('href').substring(1), 10));
    app.func.stop(e);
  });

  setRefreshWindow(log_conf.refresh);
  $('#refresh-window a').click(function(e) {
    setRefreshWindow(parseInt($(this).attr('href').substring(1), 10));
    app.func.stop(e);
  });
  setMonitoringCount(log_conf.count);
  $('#monitoring-count a').click(function(e) {
    setMonitoringCount(parseInt($(this).attr('href').substring(1), 10));
    app.func.stop(e);
  });

  setInterval(function () {
    ReactDOM.render(<StatTable />, document.getElementById('statistics'));
  }, 1000);
  ReactDOM.render(<StatTable />, document.getElementById('statistics'));

  refreshLogs();
});

function refreshLogs() {
  if (log_conf.refresh > 0) {
    ReactDOM.render(<LogTable />, document.getElementById('logs'));
  }
  setTimeout(refreshLogs, Math.max(1, log_conf.refresh) * 1000);
}
