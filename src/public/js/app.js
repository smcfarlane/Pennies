var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/";
var ws       = new WebSocket(uri);
var player   = {
  name: '',
  room: '',
  position: 0,
  score: 0,
  hand: [],
  pennies: 10,
  id: ''
};


ws.onopen = function(){
  if (player.id === '') {
    if (window.localStorage.getItem('user_id')) {
      player.id = window.localStorage.getItem('user_id');
      ws.send(JSON.stringify({handler: 'get_player', id: player.id}));
      console.log(player);
    } else {
      ws.send(JSON.stringify({handler: 'get_uuid'}));
      console.log(player);
    }
  }
};

var validatePlayer = function() {
  if (player.name === '') {
    alert('Create username before creating a room.');
    return false;
  } else {
    return true;
  }
};

ws.onmessage = function(message) {
  var data = JSON.parse(message.data);
  console.log(data);
  if (data.handler === 'initial_data') {
    $.each(data.players, function(key, item){ $(".players-list").append('<li class="list-group-item">' + item.name + "</li>");});
    data.rooms.forEach(function(room){ $('.rooms').append(createRoomHTML(room)); });
  }
  else if (data.handler === 'get_uuid') {
    window.localStorage.setItem('user_id', data.uuid);
    player.id = data.uuid;
  }
  else if (data.handler === 'get_player'){
    player = data.player;
  }
  else if (data.handler === 'reset_rooms'){
    $('.rooms').empty();
    data.rooms.forEach(function(room){ $('.rooms').append(createRoomHTML(room)); });
  }
  else if (data.handler === 'create_room'){
    $('.rooms').append(createRoomHTML(data.room));
    player.room = data.room;
  }
  else if (data.handler === 'delete-players') {
    $(".players-list").empty();
  }
  else if (data.handler === 'add_player') {
    $(".players-list").append('<li class="list-group-item">' + data.player + "</li>");
  }
  else if (data.handler === 'delete_player') {
    if (player.id === data.player.id) {
      player = {name: '', room: '', position: 0, score: 0, hand: [], pennies: 10, id: ''};
      ws.send(JSON.stringify({handler: 'get_uuid'}));
    }
    $(".players-list").empty();
    $.each(data.players, function(key, player){ $(".players-list").append('<li class="list-group-item">' + player.name + "</li>");});
  }
};

var createRoomHTML = function(room){
  var roomHeading = '<div class="panel-heading"><h3> ID: ' + room.status + ' Name: ' + room.name + '</h3></div><h3>&emsp;Players In Room</h3><ul class="list-group">';
  var list_items = []
  room.players.forEach(function(player){
    var ready = '';
    var readyBtn = '<button id="'+ room.id +'" class="btn btn-default btn-xs pull-right ready-btn" type="button">Ready?</button>';
    if (room.players_ready.indexOf(player.id) !== -1) {
      ready = '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>';
      readyBtn = '';
    }
    list_items.push('<li class="list-group-item">'+ ready + player.name + readyBtn + '</li>');
  });
  var roomFooter = '</ul><div class="panel-footer"><div class="btn-group"><button id="'+ room.id +'" class="btn btn-info" type="button">Join</button><button id="'+ room.id +'" class="btn btn-danger" type="button">Leave</button><button id="'+ room.id +'" type="button" class="btn btn-success">Start Game</button></div></div>';
  return '<div class="col-md-6"><div class="panel panel-default">' + roomHeading + list_items.join(' ') + roomFooter + '</div></div>';
};

// add_player
$("#player-name").on("submit", function(event) {
  event.preventDefault();
  if (player.name === '') {
    var playerName = $("input.player-name")[0].value;
    player.name = playerName;
    var data = { handler: 'add_player', name: playerName, player: player };
    ws.send(JSON.stringify(data));
    $("input.player-name")[0].value = '';
  }
  $('.create-username').addClass('disabled');
});

// delete_players
$('.go-offline').click(function(e){
  $('.create-username').removeClass('disabled');
  ws.send(JSON.stringify({handler: 'delete_player', player: player}));
});

// create_room
$('.create-room').click(function(e){
  if (validatePlayer(player)) {
    var room_name = prompt("What should the name of the room be?", '');
    if (room_name === null) { alert("Room not created."); } else {
      ws.send(JSON.stringify({handler: 'create_room', room_name: room_name, player: player})); }
  }
});

// delete_players
$(".delete-players").click(function(e){
  ws.send(JSON.stringify({handler: 'delete_players', player: player}));
});

// start_game
$(".start-game").click(function(e){
  ws.send(JSON.stringify({handler: 'start_game', player: player}));
});

// join room
$(".rooms").click(function(e){
  if ($(e.target).attr('class') === "btn btn-info"){
    ws.send(JSON.stringify({handler: 'join_room', room_id: $(e.target).attr('id'), player: player}));
  } else if ($(e.target).attr('class') === "btn btn-danger") {
    ws.send(JSON.stringify({handler: 'leave_room', room_id: $(e.target).attr('id'), player: player}));
  } else if ($(e.target).hasClass('ready-btn')) {
    ws.send(JSON.stringify({handler: 'player_ready', room_id: $(e.target).attr('id'), player: player}));
  }
});
