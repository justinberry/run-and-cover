extends KinematicBody2D

const MOTION_SPEED = 260 # Pixels/second
const MOUSE_DEBUG_LABEL = '/root/Main/UI/MarginContainer/VBoxContainer/MouseXY'
const ISOMETRIC_X_OFFSET = 1.75

class Movement:
  func is_moving():
    return
    
  func get_motion():
    return

class UpMovement extends Movement:
  const _MOTION = Vector2(0, -1)
  
  func is_moving():
    return Input.is_action_pressed('move_up')
  
  func get_motion():
    return _MOTION
  
  func get_animation():
    return 'WalkUp'
    
class LeftMovement extends Movement:
  const _MOTION = Vector2(-1, 0)
  
  func is_moving():
    return Input.is_action_pressed('move_left')
  
  func get_motion():
    return _MOTION
  
  func get_animation():
    return 'WalkLeft'
    
class DownMovement extends Movement:
  const _MOTION = Vector2(0, 1)
  
  func is_moving():
    return Input.is_action_pressed('move_down')
  
  func get_motion():
    return _MOTION
  
  func get_animation():
    return 'WalkDown'

class RightMovement extends Movement:
  const _MOTION = Vector2(1, 0)
  
  func is_moving():
    return Input.is_action_pressed('move_right')
  
  func get_motion():
    return _MOTION
  
  func get_animation():
    return 'WalkRight'
    
class RightUpMovement extends Movement:
  func is_moving():
    return (
      Input.is_action_pressed('move_up')
      and
      Input.is_action_pressed('move_right')
    )
  
  func get_motion():
    return (RightMovement._MOTION * ISOMETRIC_X_OFFSET) + UpMovement._MOTION
  
  func get_animation():
    return 'WalkRightUp'
    
class LeftUpMovement extends Movement:
  func is_moving():
    return (
      Input.is_action_pressed('move_up')
      and
      Input.is_action_pressed('move_left')
    )
  
  func get_motion():
    return (LeftMovement._MOTION * ISOMETRIC_X_OFFSET) + UpMovement._MOTION
  
  func get_animation():
    return 'WalkLeftUp'
    
class LeftDownMovement extends Movement:
  func is_moving():
    return (
      Input.is_action_pressed('move_down')
      and
      Input.is_action_pressed('move_left')
    )
  
  func get_motion():
    return (LeftMovement._MOTION * ISOMETRIC_X_OFFSET) + DownMovement._MOTION
  
  func get_animation():
    return 'WalkLeftDown'

class RightDownMovement extends Movement:
  func is_moving():
    return (
      Input.is_action_pressed('move_down')
      and
      Input.is_action_pressed('move_right')
    )
  
  func get_motion():
    return (RightMovement._MOTION * ISOMETRIC_X_OFFSET) + DownMovement._MOTION
  
  func get_animation():
    return 'WalkRightDown'
    
class IdleMovement extends Movement:
  func is_moving():
    return false
    
  func get_motion():
    return Vector2(0, 0)
  
  func get_animation():
    return 'Idle'
  
var MOVEMENTS = [
  LeftUpMovement.new(),
  LeftDownMovement.new(),
  RightDownMovement.new(),
  RightUpMovement.new(),
  UpMovement.new(),
  LeftMovement.new(),
  DownMovement.new(),
  RightMovement.new()
]
  
func _movement_factory():
  for m in MOVEMENTS:
    if m.is_moving():
      return m
  
  return IdleMovement.new()
      
func _update_movement(_delta):
  var walk_anim = get_node('Sprite/AnimationPlayer')
  
  var movement = _movement_factory()
  var motion = movement.get_motion()
  walk_anim.play(movement.get_animation())
  motion = motion.normalized() * MOTION_SPEED
  if Input.is_key_pressed(KEY_SHIFT):
    motion *= 1.5
  return move_and_slide(motion)

func _triangle_vectors_around(point):
  return [
    Vector2(point.x - 10, point.y + 10),
    Vector2(point.x, point.y - 10),
    Vector2(point.x + 10, point.y + 10),
  ]

func _draw_aim():
  var mouse_position = self.get_local_mouse_position()
  
  var point = PoolVector2Array(_triangle_vectors_around(mouse_position))
  var color = PoolColorArray([Color(255, 0, 0), Color(255, 0, 0), Color(255, 0, 0)]) 
  draw_primitive(point, color, PoolVector2Array())
  
  var direction = mouse_position.normalized() * 100
  draw_line(get_node('Sprite').position, direction, Color(255, 0, 0), 2)
  get_node(MOUSE_DEBUG_LABEL).set_text(mouse_position)

func _draw():
  _draw_aim()

func _input(_event):
  self.update()

func _physics_process(delta):
  _update_movement(delta)
    
  
  

