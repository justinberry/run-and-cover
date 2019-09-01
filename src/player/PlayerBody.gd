extends KinematicBody2D

const MOTION_SPEED = 260 # Pixels/second
const MOUSE_DEBUG_LABEL = '/root/Main/UI/MarginContainer/VBoxContainer/MouseXY'

var MOVEMENTS = [
  preload('movement/LeftUpMovement.gd').new(),
  preload('movement/LeftDownMovement.gd').new(),
  preload('movement/RightDownMovement.gd').new(),
  preload('movement/RightUpMovement.gd').new(),
  preload('movement/UpMovement.gd').new(),
  preload('movement/LeftMovement.gd').new(),
  preload('movement/DownMovement.gd').new(),
  preload('movement/RightMovement.gd').new()
]

var IDLE_MOVEMEMENT = preload('movement/IdleMovement.gd').new()

func _movement_factory():  
  for m in MOVEMENTS:
    if m.is_moving():
      return m
  
  return IDLE_MOVEMEMENT
      
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

const RED_RETICULE = [
  Color(255, 0, 0), Color(255, 0, 0), Color(255, 0, 0)
]

const GREEN_RETICULE = [
  Color(0, 255, 0)
]

const NUM_POINTS = 32

func _draw_aim():
  var mouse_position = self.get_local_mouse_position()
  
  var point = PoolVector2Array(_triangle_vectors_around(mouse_position))
  var color = PoolColorArray(RED_RETICULE)
  draw_primitive(point, color, PoolVector2Array())
  
  # draw point at player
  # get angle of player -> mouse
  # Draw arc from angle (player -> mouse) - (fov / 2)
  # and (player -> mouse) + (fov / 2)
  
  var points = PoolVector2Array()
  
  var nb_points = NUM_POINTS
  var points_arc = PoolVector2Array()
  var center = position
  var radius = 200
  points_arc.push_back(center)
  
  var direction = (get_local_mouse_position() - position).normalized()
  var angle = Vector2(
    get_node('Sprite').position.x + cos(direction.angle()) * 100,
    get_node('Sprite').position.y + sin(direction.angle()) * 100
  )
  print('angle is: ', angle)
  
  var angle_from = angle.angle_to(
  var angle_to = 45
  
  var colors = PoolColorArray(GREEN_RETICULE)

  for i in range(nb_points + 1):
    var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
    points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
  draw_polygon(points_arc, colors)
  update()
  
  #var direction = (get_local_mouse_position() - position).normalized()
  #var mouse_direction  = Vector2(
  #  get_node('Sprite').position.x + cos(direction.angle()) * 100,
  #  get_node('Sprite').position.y + sin(direction.angle()) * 100
  #)
  #draw_line(get_node('Sprite').position, mouse_direction, Color(255, 0, 0), 2)
  get_node(MOUSE_DEBUG_LABEL).set_text(mouse_position)

func _draw():
  _draw_aim()

func _input(_event):
  self.update()

func _physics_process(delta):
  _update_movement(delta)
    
  
  

