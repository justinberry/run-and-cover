extends Label

func set_text(position):
  var x = String(stepify(position.x, 0.01))
  var y = String(stepify(position.y, 0.01))
  .set_text('Mouse position: (' + x + ',' + y + ')')