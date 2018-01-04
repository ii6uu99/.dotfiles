
var query = app.func.query('q'), clients = [], labels = [], candidates = [],
    filters = {
      client: app.func.query('c', false),
      label: parseInt(app.func.query('l', '0'), 10),
      text: ''
    },
    reload = false, isViewOnly = false;
if (query != '') {
  filters.text = query.replace(/\s/g,' ').replace(/　/g,' ');
  filters.text = filters.text.replace(/^\s+|\s+$/gm,'').toUpperCase();
}

$(document).ready(function () {
  $('#menu-images').addClass('active');
  $('#image-detail pre').css({height: ($(window).height()-200)+'px'});
  isViewOnly = ($('#mode-view-only').val() == 'true');

  var search = $('#search-text').blur(_search);
  if (query != '') search.val(query);

  $('.detail-refresh a').click(function (e) {
    _detail();
    app.func.stop(e);
  });

  $('#image-detail').on('hide.bs.modal', function () {
    if (reload) ReactDOM.render(<Table reload={true} />, document.getElementById('data'));
  });
  $('#image-pull').on('show.bs.modal', function () {
    $('#image-name').val('');
  });
  $('#image-pull').on('shown.bs.modal', function () {
    $('#image-name').focus();
  });
  $('#image-pull .act-pull').click(function (e) {
    var name = app.func.trim($('#image-name').val());
    if (name.length == 0) {
      $('#image-name').focus();
      app.func.stop(e);
      return
    }
    $('#image-pull').modal('hide');
    _pull($('#pull-client-id').val(), name);
    app.func.stop(e);
  });

  $('#image-tag').on('shown.bs.modal', function () {
    $('#image-tag .repository').focus();
  });
  $('#image-tag .act-tag').click(function (e) {
    var popup = $('#image-tag'),
        client = popup.find('.client').val(),
        id = popup.find('.image-id').val(),
        repository = popup.find('.repository').val(),
        tag = popup.find('.tag').val();
    if (repository.length == 0) {
      popup.find('.repository').focus();
      app.func.stop(e);
      return;
    }
    popup.modal('hide');
    _tag(client, id, repository, tag);
    app.func.stop(e);
  });

  $('#image-run .act-run').click(function () {
    $('#image-run').modal('hide');
  });
});

$(window).keyup(function () {
  var search = $('#search-text');
  if (search.is(':focus')) {
    _search();
  }
});

function _setClientOption() {
  var options = $('.client-filters').hide(),
      caption = false,
      count = 0;
  options.find('ul.dropdown-menu').html('');
  $.map(clients, function (client) {
    if (! filters.client) filters.client = client.key;
    if ((! caption) && (filters.client == client.key)) caption = client.value;
    count++;
  });
  $('#pull-client-id').val(filters.client);
  options.find('.caption').text(caption);
  if (count <= 1) {
    return;
  }
  var html = '';
  $.map(clients, function (client) {
    html += '<li><a href="#'+client.key+'">'+client.value+'</a></li>';
  });
  options.find('ul.dropdown-menu').html(html);
  options.fadeIn();

  $('#client-filter .dropdown-menu a').click(function(e) {
    var a = $(this),
        group = a.closest('.btn-group').removeClass('open');
    group.find('.caption').text(a.text()).blur();
    filters.client = a.attr('href').substring(1);
    ReactDOM.render(<Table reload={false} />, document.getElementById('data'));
    app.func.stop(e);
  });
  $('#pull-client .dropdown-menu a').click(function(e) {
    var a = $(this),
        group = a.closest('.btn-group').removeClass('open');
    group.find('.caption').text(a.text()).blur();
    $('#pull-client-id').val(a.attr('href').substring(1));
    app.func.stop(e);
  });
}

function _setLabelFilter() {
  var options = $('.label-filters').hide(),
      caption = false,
      count = 0;
  options.find('ul.dropdown-menu').html('');
  $.map(labels, function (label) {
    if ((! caption) && (filters.label == app.func.hash(label.key+'->'+label.value))) {
      caption = label.value;
    }
    count++;
  });
  if ((! caption) && (filters.label == -1)) caption = 'Not Labeled';
  caption && options.find('.caption').text(caption);
  if (count <= 1) {
    return;
  }
  var html = '<li><a href="#0">All</a></li>',
      group = '';
  html += '<li><a href="#-1">Not Labeled</a></li>';
  $.map(labels, function (label) {
    if (group != label.key) {
      html += '<li class="dropdown-header">'+label.key+'</li>';
      group = label.key;
    }
    var value = label.value;
    if (value.length > 20) {
      value = value.substring(0, 20) + '..';
    }
    value = '&nbsp;&nbsp;&nbsp;&nbsp;'+value;
    html += '<li><a href="#'+app.func.hash(label.key+'->'+label.value)+'">'+value+'</a></li>';
  });
  options.find('ul.dropdown-menu').html(html);
  options.fadeIn();

  $('#label-filter .dropdown-menu a').click(function(e) {
    var a = $(this),
        group = a.closest('.btn-group').removeClass('open');
    group.find('.caption').text(a.text().trim()).blur();
    filters.label = a.attr('href').substring(1);

    if (window.history && window.history.pushState) {
      var url = (filters.label == 0) ? '/images' : '/images?l='+filters.label;
      history.pushState(null, null, url);
    }
    ReactDOM.render(<Table reload={false} />, document.getElementById('data'));
    app.func.stop(e);
  });
}

function _search() {
  var candidate = $('#search-text').val().replace(/\s/g,' ').replace(/　/g,' ');
  candidate = candidate.replace(/^\s+|\s+$/gm,'').toUpperCase();
  if (filters.text == candidate) return;
  filters.text = candidate;
  ReactDOM.render(<Table reload={false} />, document.getElementById('data'));
}

var last = {};

function _detail(arg) {
  arg = arg ? arg : last;
  arg.format = arg.format ? arg.format : function (data) {
    return JSON.stringify(data, true, ' ');
  };
  $('#progress-bar').hide().find('.progress-bar').css({width: '0%'});

  var popup = $('#image-detail'),
      details = popup.find('.details');
  popup.find('.detail-title').text(arg.title);
  popup.find('.detail-refresh').hide();
  if (arg.message) {
    details.text(arg.message);
  } else {
    details.hide();
  }
  app.func.ajax({type: 'GET', url: arg.url, data: arg.conditions, success: function (data) {
    var formatted = arg.format(data)
    if (formatted.indexOf('Error:') == -1) {
      popup.find('.detail-refresh').show();
      details.text(formatted).fadeIn();
    } else {
      details.text(data).fadeIn();
    }
    arg.callback && arg.callback();
    popup.modal('show');
    last = arg;
  }, error: function () {
    arg.err && alert(arg.err)
  }});
}

function _pull(client, name) {
  reload = true;
  $('#image-detail').modal('show');
  var conditions = client ? {client: client} : {};

  _detail({
    title: name, message: 'Now executing..\n\ndocker pull '+name,
    url: '/api/image/pull/'+name, conditions: conditions,
    callback: function () {$('#progress-bar').fadeOut();}
  });
  var bar = $('#progress-bar').show().find('.progress-bar');
  bar.animate({width: '100%'}, {duration: 1000*45, easing: 'linear'});
}

function _tag(client, id, repository, tag) {
  var data = {repo: repository, tag: tag};
  if (client) data.client = client;

  app.func.ajax({type: 'POST', url: '/api/image/tag/'+id, data: data, success: function () {
    ReactDOM.render(<Table reload={true} />, document.getElementById('data'));
  }});
}

function _client(multiple, single) {
  var count = 0;
  $.map(clients, function () {count++;});
  return (count > 1) ? multiple : single;
}

var TableRow = React.createClass({
  propTypes: {
    content: React.PropTypes.object
  },
  inspect: function() {
    var tr = $(ReactDOM.findDOMNode(this)),
        id = tr.attr('data-image-id'),
        name = tr.attr('data-image-name'),
        client = _client({client: tr.attr('data-client-id')}, '');
    _detail({title: name, url: '/api/image/inspect/'+id, conditions: client});
  },
  history: function() {
    var tr = $(ReactDOM.findDOMNode(this)),
        name = tr.attr('data-image-name'),
        client = _client('?client='+tr.attr('data-client-id'), '');
    app.func.link('/image/history/' + name + client);
  },
  run: function() {
    if (isViewOnly) return;
    var tr = $(ReactDOM.findDOMNode(this)),
        name = tr.attr('data-image-name'),
        popup = $('#image-run');
    $('#run-scripts').val('docker run ' + name);
    popup.find('.detail-title').text('Run from ' + name);
    popup.modal('show');
  },
  containers: function() {
    var tr = $(ReactDOM.findDOMNode(this)),
        container = tr.attr('data-image-name'),
        client = _client('&c='+tr.attr('data-client-id'), '');
    app.func.link('/?q='+container+client);
  },
  pull: function() {
    if (isViewOnly) return;
    var tr = $(ReactDOM.findDOMNode(this)),
        name = tr.attr('data-image-name'),
        client = _client(tr.attr('data-client-id'), '');
    _pull(client, name);
  },
  rmi: function() {
    if (isViewOnly) return;
    var tr = $(ReactDOM.findDOMNode(this)),
        id = tr.attr('data-image-id'),
        name = tr.attr('data-image-name'),
        client = _client({client: tr.attr('data-client-id')}, '');
    if ((name == '') || (name == '<none>:<none>')) {
      name = id;
    }
    if (!window.confirm('Are you sure to remove image: '+name)) {
      return;
    }
    app.func.ajax({type: 'POST', url: '/api/image/rmi/'+name, data: client, success: function (data) {
      if (data != 'removed successfully.') {
        alert(data);
        return;
      }
      ReactDOM.render(<Table reload={true} />, document.getElementById('data'));
    }});
  },
  tag: function() {
    if (isViewOnly) return;
    var tr = $(ReactDOM.findDOMNode(this)),
        id = tr.attr('data-image-id'),
        name = tr.attr('data-image-name'),
        client = _client(tr.attr('data-client-id'), ''),
        popup = $('#image-tag');
    popup.find('.title').text(name);
    popup.find('.client').val(client);
    popup.find('.image-id').val(id);
    popup.find('.repository').val(name.substring(0, name.indexOf(':')));
    popup.find('.tag').val(name.substring(name.indexOf(':') + 1));
    popup.modal('show');
  },
  render: function() {
    var image = this.props.content.image,
        name = this.props.content.tag;
    if (isViewOnly) {
      return (
        <tr data-client-id={this.props.content.client} data-image-id={image.id.substring(0, 20)} data-image-name={name}>
          <td className="data-index">{image.id.substring(0, 10)}</td>
          <td className="data-name"><ul className="nav">
            <li className="dropdown">
              <a className="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">{name}</a>
              <ul className="dropdown-menu">
                <li><a onClick={this.inspect}>inspect</a></li>
                <li><a onClick={this.history}>history</a></li>
                <li className="divider"></li>
                <li><a onClick={this.containers}>containers</a></li>
              </ul>
            </li>
          </ul></td>
          <td className="data-name">{app.func.byteFormat(image.virtualSize)}</td>
          <td className="data-name">{app.func.relativeTime(new Date(image.created * 1000))}</td>
        </tr>
      );
    } else {
      return (
        <tr data-client-id={this.props.content.client} data-image-id={image.id.substring(0, 20)} data-image-name={name}>
          <td className="data-index">{image.id.substring(0, 10)}</td>
          <td className="data-name"><ul className="nav">
            <li className="dropdown">
              <a className="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">{name}</a>
              <ul className="dropdown-menu">
                <li><a onClick={this.inspect}>inspect</a></li>
                <li><a onClick={this.history}>history</a></li>
                <li className="divider"></li>
                <li><a onClick={this.containers}>containers</a></li>
                <li className="divider"></li>
                <li><a onClick={this.pull}>pull again</a></li>
                <li><a onClick={this.tag}>tag</a></li>
                <li><a onClick={this.rmi}>rmi</a></li>
              </ul>
            </li>
          </ul></td>
          <td className="data-name">{app.func.byteFormat(image.virtualSize)}</td>
          <td className="data-name">{app.func.relativeTime(new Date(image.created * 1000))}</td>
        </tr>
      );
    }
  }
});

var Table = React.createClass({
  propTypes: {
    content: React.PropTypes.object
  },
  getInitialState: function() {
    return {data: {client: '', images: []}};
  },
  load: function(sender) {
    clients = [];
    labels = [];

    app.func.ajax({type: 'GET', url: '/api/images', success: function (data) {
      candidates = data;

      // make filters
      var temp = {clients: {}, labels: {}},
          conf = $('#filter-label-ids').val();
      $.map(candidates, function (candidate) {
        temp.clients[''+candidate.client.id] = candidate.client.endpoint.replace(/^.*:\/\//, '').replace(/:.*$/, '');

        $.map(candidate.images, function (image) {
          if (! image.labels) return;
          $.map(image.labels, function (value, key) {
            if ((conf != 'all') && (conf.indexOf(key) == -1)) return;
            if (! temp.labels[key]) {
              temp.labels[key] = {};
            }
            temp.labels[key][value] = true;
          });
        });
      });
      $.map(temp.clients, function (value, key) {
        clients.push({key: key, value: value});
      });
      $.map(temp.labels, function (nest, key) {
        $.map(nest, function (_, value) {
          labels.push({key: key, value: value});
        });
      });
      clients.sort(function (a, b) {
        if (a.value < b.value) return -1;
        if (a.value > b.value) return 1;
        return 0;
      });
      labels.sort(function (a, b) {
        if (a.key < b.key) return -1;
        if (a.key > b.key) return 1;
        if (a.value < b.value) return -1;
        if (a.value > b.value) return 1;
        return 0;
      });
      _setClientOption();
      _setLabelFilter();

      // reflow
      sender.setState({data: sender.filter()});
    }});
  },
  filter: function() {
    var data = {client: '', images: []};
    $.map(candidates, function (candidate) {
      if (candidate.client.id == filters.client) {
        data.client = candidate.client;

        $.map(candidate.images, function (image) {
          if ((filters.label == 0) || ((filters.label == -1) && (! image.labels))) {
            data.images.push(image);
          } else {
            if (! image.labels) return;
            var match = false;
            $.map(image.labels, function (value, key) {
              match |= (filters.label == app.func.hash(key+'->'+value));
            });
            if (match) data.images.push(image);
          }
        });
      }
    });
    return data;
  },
  componentDidMount: function() {
    this.load(this);
  },
  componentWillReceiveProps: function(props) {
    if (props.reload) {
      this.load(this);
      return;
    }
    this.setState({data: this.filter()});
  },
  render: function() {
    var count = 0;
    if (this.state.data.client) {
      var clientId = this.state.data.client.id;

      var rows = this.state.data.images.map(function(image, index) {
        if (filters.text != '') {
          var match = true;
          $.map(filters.text.split(' '), function (word) {
            var innerMatch = (image.id.substring(0, 10).toUpperCase().indexOf(word) > -1);
            $.map(image.repoTags, function (tag) {
              innerMatch |= (tag.toUpperCase().indexOf(word) > -1);
            });
            match &= innerMatch;
          });
          if (! match) return;
        }
        if (image.repoTags == undefined) {
          image.repoTags = [];
        }
        image.repoTags.sort(function (a, b) {
          if (a.tag < b.tag)
            return -1;
          if (a.tag > b.tag)
            return 1;
          return 0;
        });

        return image.repoTags.map(function(tag, tagIndex) {
          count++;
          return (
              <TableRow key={index*1000+tagIndex} content={{
                  client: clientId,
                  image: image,
                  tag: tag
              }} />
          );
        });
      });
    }
    $('#count').text(count + ' image' + ((count > 1) ? 's' : ''));
    return (
        <table className="table table-striped table-hover">
          <thead>
            <tr>
              <th>ID</th>
              <th>Repository & Tags</th>
              <th>VirtualSize</th>
              <th>Created</th>
            </tr>
          </thead>
          <tbody>{rows}</tbody>
        </table>
    );
  }
});

ReactDOM.render(<Table reload={false} />, document.getElementById('data'));
