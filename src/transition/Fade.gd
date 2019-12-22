class TweenDetacher:
  extends Node
  
  var target
  var tween

  func _init(target, tween):
    self.target = target
    self.tween = tween
    
  func _on_tween_complete(object, key):
    print(self.target.get_children())
    self.target.remove_child(self.tween)

static func _attach_signals(tween, detacher, on_complete, on_complete_func_name):
  tween.connect('tween_completed', on_complete, on_complete_func_name)
  tween.connect('tween_completed', detacher, '_on_tween_complete')

static func stop(target, tween):
  if !tween:
    return
    
  for i in range(0, target.get_child_count()):
    target.get_child(i).queue_free()

  tween.stop_all()

static func out(target, time, on_complete, on_complete_func_name):
  var tween = Tween.new()
  target.add_child(tween)
  tween.set_owner(target)
  tween.interpolate_property(
    target,
    'modulate',
    target.modulate,
    Color(1, 1, 1, 0),
    time,
    Tween.TRANS_LINEAR,
    Tween.EASE_OUT
  )
  #var detacher = TweenDetacher.new(target, tween)
  #_attach_signals(tween, detacher, on_complete, on_complete_func_name)
  #tween.start()
  return tween
  
static func in(target, time, on_complete, on_complete_func_name):
  var tween = Tween.new()
  target.add_child(tween)
  tween.set_owner(target)
  var detacher = TweenDetacher.new(target, tween)
  tween.interpolate_property(
    target,
    'modulate',
    target.modulate,
    Color(1, 1, 1, 1),
    time,
    Tween.TRANS_LINEAR,
    Tween.EASE_IN
  )
  _attach_signals(tween, detacher, on_complete, on_complete_func_name)
  tween.start()
  return tween