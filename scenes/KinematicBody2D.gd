extends KinematicBody2D

const MOTION_SPEED = 260 # Pixels/second
const MOUSE_DEBUG_LABEL = '/root/Main/UI/MarginContainer/VBoxContainer/MouseXY'

func _update_movement(delta):
  var motion = Vector2()

  if Input.is_action_pressed("move_up"):
    motion += Vector2(0, -1)
  if Input.is_action_pressed("move_down"):
    motion += Vector2(0, 1)
  if Input.is_action_pressed("move_left"):
    motion += Vector2(-1, 0)
  if Input.is_action_pressed("move_right"):
    motion += Vector2(1, 0)

  motion = motion.normalized() * MOTION_SPEED

  move_and_slide(motion)

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

func _input(event):
  self.update()

func _physics_process(delta):
  _update_movement(delta)
    
  
  

