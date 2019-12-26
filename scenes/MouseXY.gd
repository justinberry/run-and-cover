extends Label

func _process(_delta):
  var position = get_global_mouse_position()
  var x = String(stepify(position.x, 0.01))
  var y = String(stepify(position.y, 0.01))
  set_text('Mouse position (viewport): (' + x + ',' + y + ')')
  
  