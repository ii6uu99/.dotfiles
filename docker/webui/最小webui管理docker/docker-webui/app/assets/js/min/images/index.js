!function e(t,a,n){function i(r,c){if(!a[r]){if(!t[r]){var o="function"==typeof require&&require;if(!c&&o)return o(r,!0);if(l)return l(r,!0);var s=new Error("Cannot find module '"+r+"'");throw s.code="MODULE_NOT_FOUND",s}var d=a[r]={exports:{}};t[r][0].call(d.exports,function(e){var a=t[r][1][e];return i(a?a:e)},d,d.exports,e,t,a,n)}return a[r].exports}for(var l="function"==typeof require&&require,r=0;r<n.length;r++)i(n[r]);return i}({1:[function(e,t,a){function n(){var e=$(".client-filters").hide(),t=!1,a=0;if(e.find("ul.dropdown-menu").html(""),$.map(u,function(e){f.client||(f.client=e.key),t||f.client!=e.key||(t=e.value),a++}),$("#pull-client-id").val(f.client),e.find(".caption").text(t),!(a<=1)){var n="";$.map(u,function(e){n+='<li><a href="#'+e.key+'">'+e.value+"</a></li>"}),e.find("ul.dropdown-menu").html(n),e.fadeIn(),$("#client-filter .dropdown-menu a").click(function(e){var t=$(this),a=t.closest(".btn-group").removeClass("open");a.find(".caption").text(t.text()).blur(),f.client=t.attr("href").substring(1),ReactDOM.render(React.createElement(b,{reload:!1}),document.getElementById("data")),app.func.stop(e)}),$("#pull-client .dropdown-menu a").click(function(e){var t=$(this),a=t.closest(".btn-group").removeClass("open");a.find(".caption").text(t.text()).blur(),$("#pull-client-id").val(t.attr("href").substring(1)),app.func.stop(e)})}}function i(){var e=$(".label-filters").hide(),t=!1,a=0;if(e.find("ul.dropdown-menu").html(""),$.map(m,function(e){t||f.label!=app.func.hash(e.key+"->"+e.value)||(t=e.value),a++}),t||f.label!=-1||(t="Not Labeled"),t&&e.find(".caption").text(t),!(a<=1)){var n='<li><a href="#0">All</a></li>',i="";n+='<li><a href="#-1">Not Labeled</a></li>',$.map(m,function(e){i!=e.key&&(n+='<li class="dropdown-header">'+e.key+"</li>",i=e.key);var t=e.value;t.length>20&&(t=t.substring(0,20)+".."),t="&nbsp;&nbsp;&nbsp;&nbsp;"+t,n+='<li><a href="#'+app.func.hash(e.key+"->"+e.value)+'">'+t+"</a></li>"}),e.find("ul.dropdown-menu").html(n),e.fadeIn(),$("#label-filter .dropdown-menu a").click(function(e){var t=$(this),a=t.closest(".btn-group").removeClass("open");if(a.find(".caption").text(t.text().trim()).blur(),f.label=t.attr("href").substring(1),window.history&&window.history.pushState){var n=0==f.label?"/images":"/images?l="+f.label;history.pushState(null,null,n)}ReactDOM.render(React.createElement(b,{reload:!1}),document.getElementById("data")),app.func.stop(e)})}}function l(){var e=$("#search-text").val().replace(/\s/g," ").replace(/　/g," ");e=e.replace(/^\s+|\s+$/gm,"").toUpperCase(),f.text!=e&&(f.text=e,ReactDOM.render(React.createElement(b,{reload:!1}),document.getElementById("data")))}function r(e){e=e?e:v,e.format=e.format?e.format:function(e){return JSON.stringify(e,!0," ")},$("#progress-bar").hide().find(".progress-bar").css({width:"0%"});var t=$("#image-detail"),a=t.find(".details");t.find(".detail-title").text(e.title),t.find(".detail-refresh").hide(),e.message?a.text(e.message):a.hide(),app.func.ajax({type:"GET",url:e.url,data:e.conditions,success:function(n){var i=e.format(n);i.indexOf("Error:")==-1?(t.find(".detail-refresh").show(),a.text(i).fadeIn()):a.text(n).fadeIn(),e.callback&&e.callback(),t.modal("show"),v=e},error:function(){e.err&&alert(e.err)}})}function c(e,t){g=!0,$("#image-detail").modal("show");var a=e?{client:e}:{};r({title:t,message:"Now executing..\n\ndocker pull "+t,url:"/api/image/pull/"+t,conditions:a,callback:function(){$("#progress-bar").fadeOut()}});var n=$("#progress-bar").show().find(".progress-bar");n.animate({width:"100%"},{duration:45e3,easing:"linear"})}function o(e,t,a,n){var i={repo:a,tag:n};e&&(i.client=e),app.func.ajax({type:"POST",url:"/api/image/tag/"+t,data:i,success:function(){ReactDOM.render(React.createElement(b,{reload:!0}),document.getElementById("data"))}})}function s(e,t){var a=0;return $.map(u,function(){a++}),a>1?e:t}var d=app.func.query("q"),u=[],m=[],p=[],f={client:app.func.query("c",!1),label:parseInt(app.func.query("l","0"),10),text:""},g=!1,h=!1;""!=d&&(f.text=d.replace(/\s/g," ").replace(/　/g," "),f.text=f.text.replace(/^\s+|\s+$/gm,"").toUpperCase()),$(document).ready(function(){$("#menu-images").addClass("active"),$("#image-detail pre").css({height:$(window).height()-200+"px"}),h="true"==$("#mode-view-only").val();var e=$("#search-text").blur(l);""!=d&&e.val(d),$(".detail-refresh a").click(function(e){r(),app.func.stop(e)}),$("#image-detail").on("hide.bs.modal",function(){g&&ReactDOM.render(React.createElement(b,{reload:!0}),document.getElementById("data"))}),$("#image-pull").on("show.bs.modal",function(){$("#image-name").val("")}),$("#image-pull").on("shown.bs.modal",function(){$("#image-name").focus()}),$("#image-pull .act-pull").click(function(e){var t=app.func.trim($("#image-name").val());return 0==t.length?($("#image-name").focus(),void app.func.stop(e)):($("#image-pull").modal("hide"),c($("#pull-client-id").val(),t),void app.func.stop(e))}),$("#image-tag").on("shown.bs.modal",function(){$("#image-tag .repository").focus()}),$("#image-tag .act-tag").click(function(e){var t=$("#image-tag"),a=t.find(".client").val(),n=t.find(".image-id").val(),i=t.find(".repository").val(),l=t.find(".tag").val();return 0==i.length?(t.find(".repository").focus(),void app.func.stop(e)):(t.modal("hide"),o(a,n,i,l),void app.func.stop(e))}),$("#image-run .act-run").click(function(){$("#image-run").modal("hide")})}),$(window).keyup(function(){var e=$("#search-text");e.is(":focus")&&l()});var v={},R=React.createClass({displayName:"TableRow",propTypes:{content:React.PropTypes.object},inspect:function(){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-id"),a=e.attr("data-image-name"),n=s({client:e.attr("data-client-id")},"");r({title:a,url:"/api/image/inspect/"+t,conditions:n})},history:function(){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-name"),a=s("?client="+e.attr("data-client-id"),"");app.func.link("/image/history/"+t+a)},run:function(){if(!h){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-name"),a=$("#image-run");$("#run-scripts").val("docker run "+t),a.find(".detail-title").text("Run from "+t),a.modal("show")}},containers:function(){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-name"),a=s("&c="+e.attr("data-client-id"),"");app.func.link("/?q="+t+a)},pull:function(){if(!h){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-name"),a=s(e.attr("data-client-id"),"");c(a,t)}},rmi:function(){if(!h){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-id"),a=e.attr("data-image-name"),n=s({client:e.attr("data-client-id")},"");""!=a&&"<none>:<none>"!=a||(a=t),window.confirm("Are you sure to remove image: "+a)&&app.func.ajax({type:"POST",url:"/api/image/rmi/"+a,data:n,success:function(e){return"removed successfully."!=e?void alert(e):void ReactDOM.render(React.createElement(b,{reload:!0}),document.getElementById("data"))}})}},tag:function(){if(!h){var e=$(ReactDOM.findDOMNode(this)),t=e.attr("data-image-id"),a=e.attr("data-image-name"),n=s(e.attr("data-client-id"),""),i=$("#image-tag");i.find(".title").text(a),i.find(".client").val(n),i.find(".image-id").val(t),i.find(".repository").val(a.substring(0,a.indexOf(":"))),i.find(".tag").val(a.substring(a.indexOf(":")+1)),i.modal("show")}},render:function(){var e=this.props.content.image,t=this.props.content.tag;return h?React.createElement("tr",{"data-client-id":this.props.content.client,"data-image-id":e.id.substring(0,20),"data-image-name":t},React.createElement("td",{className:"data-index"},e.id.substring(0,10)),React.createElement("td",{className:"data-name"},React.createElement("ul",{className:"nav"},React.createElement("li",{className:"dropdown"},React.createElement("a",{className:"dropdown-toggle","data-toggle":"dropdown",href:"#","aria-expanded":"true"},t),React.createElement("ul",{className:"dropdown-menu"},React.createElement("li",null,React.createElement("a",{onClick:this.inspect},"inspect")),React.createElement("li",null,React.createElement("a",{onClick:this.history},"history")),React.createElement("li",{className:"divider"}),React.createElement("li",null,React.createElement("a",{onClick:this.containers},"containers")))))),React.createElement("td",{className:"data-name"},app.func.byteFormat(e.virtualSize)),React.createElement("td",{className:"data-name"},app.func.relativeTime(new Date(1e3*e.created)))):React.createElement("tr",{"data-client-id":this.props.content.client,"data-image-id":e.id.substring(0,20),"data-image-name":t},React.createElement("td",{className:"data-index"},e.id.substring(0,10)),React.createElement("td",{className:"data-name"},React.createElement("ul",{className:"nav"},React.createElement("li",{className:"dropdown"},React.createElement("a",{className:"dropdown-toggle","data-toggle":"dropdown",href:"#","aria-expanded":"true"},t),React.createElement("ul",{className:"dropdown-menu"},React.createElement("li",null,React.createElement("a",{onClick:this.inspect},"inspect")),React.createElement("li",null,React.createElement("a",{onClick:this.history},"history")),React.createElement("li",{className:"divider"}),React.createElement("li",null,React.createElement("a",{onClick:this.containers},"containers")),React.createElement("li",{className:"divider"}),React.createElement("li",null,React.createElement("a",{onClick:this.pull},"pull again")),React.createElement("li",null,React.createElement("a",{onClick:this.tag},"tag")),React.createElement("li",null,React.createElement("a",{onClick:this.rmi},"rmi")))))),React.createElement("td",{className:"data-name"},app.func.byteFormat(e.virtualSize)),React.createElement("td",{className:"data-name"},app.func.relativeTime(new Date(1e3*e.created))))}}),b=React.createClass({displayName:"Table",propTypes:{content:React.PropTypes.object},getInitialState:function(){return{data:{client:"",images:[]}}},load:function(e){u=[],m=[],app.func.ajax({type:"GET",url:"/api/images",success:function(t){p=t;var a={clients:{},labels:{}},l=$("#filter-label-ids").val();$.map(p,function(e){a.clients[""+e.client.id]=e.client.endpoint.replace(/^.*:\/\//,"").replace(/:.*$/,""),$.map(e.images,function(e){e.labels&&$.map(e.labels,function(e,t){"all"!=l&&l.indexOf(t)==-1||(a.labels[t]||(a.labels[t]={}),a.labels[t][e]=!0)})})}),$.map(a.clients,function(e,t){u.push({key:t,value:e})}),$.map(a.labels,function(e,t){$.map(e,function(e,a){m.push({key:t,value:a})})}),u.sort(function(e,t){return e.value<t.value?-1:e.value>t.value?1:0}),m.sort(function(e,t){return e.key<t.key?-1:e.key>t.key?1:e.value<t.value?-1:e.value>t.value?1:0}),n(),i(),e.setState({data:e.filter()})}})},filter:function(){var e={client:"",images:[]};return $.map(p,function(t){t.client.id==f.client&&(e.client=t.client,$.map(t.images,function(t){if(0==f.label||f.label==-1&&!t.labels)e.images.push(t);else{if(!t.labels)return;var a=!1;$.map(t.labels,function(e,t){a|=f.label==app.func.hash(t+"->"+e)}),a&&e.images.push(t)}}))}),e},componentDidMount:function(){this.load(this)},componentWillReceiveProps:function(e){return e.reload?void this.load(this):void this.setState({data:this.filter()})},render:function(){var e=0;if(this.state.data.client)var t=this.state.data.client.id,a=this.state.data.images.map(function(a,n){if(""!=f.text){var i=!0;if($.map(f.text.split(" "),function(e){var t=a.id.substring(0,10).toUpperCase().indexOf(e)>-1;$.map(a.repoTags,function(a){t|=a.toUpperCase().indexOf(e)>-1}),i&=t}),!i)return}return void 0==a.repoTags&&(a.repoTags=[]),a.repoTags.sort(function(e,t){return e.tag<t.tag?-1:e.tag>t.tag?1:0}),a.repoTags.map(function(i,l){return e++,React.createElement(R,{key:1e3*n+l,content:{client:t,image:a,tag:i}})})});return $("#count").text(e+" image"+(e>1?"s":"")),React.createElement("table",{className:"table table-striped table-hover"},React.createElement("thead",null,React.createElement("tr",null,React.createElement("th",null,"ID"),React.createElement("th",null,"Repository & Tags"),React.createElement("th",null,"VirtualSize"),React.createElement("th",null,"Created"))),React.createElement("tbody",null,a))}});ReactDOM.render(React.createElement(b,{reload:!1}),document.getElementById("data"))},{}]},{},[1]);