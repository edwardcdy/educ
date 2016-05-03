var GES = {};

var DivPosts = React.createClass({
  clicked: [],
  twocols: false,
  loadCommentsFromServer: function(url) {
    $.ajax({
      url: url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  onClick: function(num){
    if (this.clicked.indexOf(num)==-1){
      $(GES).trigger('click');
      if (this.twocols==false){
          this.twocols = true;
          this.forceUpdate();
      }
      this.clicked.push(num);
    }
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
     this.loadCommentsFromServer(this.props.posts);
  },
  render: function() {
    if (this.twocols){
      return (
        <div className="DivPosts col-md-8">
          <DivList data={this.state.data} onClick={this.onClick}/>
        </div>
      );
    } else {
      return (
        <div className="DivPosts col-md-10 col-md-offset-1">
          <DivList data={this.state.data} onClick={this.onClick}/>
        </div>
      );
    }
  }
});

var DivList = React.createClass({
  cl: function(num){
    this.props.onClick(num);
  },
  render: function() {
    var con = this;
    var onClick = this.props.onClick;
    var commentNodes = this.props.data.map(function(comment) {
      return (
        <div className="Entry panel panel-success" onClick={con.cl.bind(this,comment.id)}>
          <div className="panel-heading">
            Concept #{comment.id}
          </div>
          <Comment> 
            {comment.text}
          </Comment>
        </div>
      );
    });
    return (
      <div className="DivList" >
        {commentNodes}
      </div>
    );
  }

});

var Comment = React.createClass({
  rawMarkup: function() {
    var rawMarkup = marked(this.props.children.toString(), {sanitize: true});
    return { __html: rawMarkup };
  },
  render: function() {
    return (
      <div className="message panel-body">
        <span dangerouslySetInnerHTML={this.rawMarkup()} />
      </div>
    );
  }
});

var Popup = React.createClass({
  arrContains: function(arr, value){
    for (var i=0;i<arr.length;i++){
      if (arr[i].id == value.id && arr[i].text == value.text)
        return true;
    }
    return false;
  },
  loadCommentsFromServer: function(url) {
    $.ajax({
      url: url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        var flag = true;
        for (var i=0;i<data.length && flag ;i++){
          var addPop = data[i];
          this.setState(function(previousState){
            if (!this.arrContains(previousState.data,addPop)){
              previousState.data.push(addPop);
              flag = false;
            }
          });
        }
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
     $(GES).on('click',function(e){
       this.loadCommentsFromServer(this.props.popups)
     }.bind(this));
  },
  componentWillUnmount: function () {
    $(GES).off('click');
  },
  render: function() {
    return (
      <div className="Popups">
        <PopList data={this.state.data} />
      </div>
    );
  }
});

var PopList = React.createClass({
  render: function() {
    var onClick = this.props.onClick;
    var commentNodes = this.props.data.map(function(comment) {
      return (
        <div className="Entry panel panel-warning col-md-4" >
          <Comment> 
            {comment.text}
          </Comment>
        </div>
      );
    });
    return (
      <div className="PopList" >
        {commentNodes}
      </div>
    );
  }

});

var MenuBar = React.createClass({
  render: function() {
    return (
      <nav className="navbar navbar-default">
        <div className="container-fluid">
          <div className="navbar-header">
            <a className="navbar-brand" href="#">Edward's Project</a>
          </div>
          <ul className="nav navbar-nav">
            <li className="active"><a href="#">Dashboard</a></li>
            <li><a href="#">Analytics</a></li>
          </ul>
          <ul className="nav navbar-nav navbar-right">
            <li><a href="#">Edward</a></li>
            <li><a href="#">Sign Out</a></li>
          </ul>
        </div>
      </nav>
    );
  }
});

ReactDOM.render(
  <MenuBar />,
  document.getElementById('menubar')
);

ReactDOM.render(
  <DivPosts posts="/div/random"  />,
  document.getElementById('content')
);

ReactDOM.render(
  <Popup popups="/popup/random" />,
  document.getElementById('popups')
);