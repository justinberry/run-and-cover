extends Label

func _process(_delta):
  var player_position = get_node("/root/Main/World/WallFg/Player").global_position  
  var x = String(stepify(player_position.x, 0.01))
  var y = String(stepify(player_position.y, 0.01))
  set_text('Player position: (' + x + ',' + y + ')')
  
