extends KinematicBody2D

const MOTION_SPEED = 260 # Pixels/second

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

var animator = preload('./StatefulAnimator.gd').new()

func _movement_factory():  
  for m in MOVEMENTS:
    if m.is_moving():
      return m
  
  return IDLE_MOVEMEMENT
      
func _update_movement(movement):
  var motion = movement.get_motion()  

  motion = motion.normalized() * MOTION_SPEED
  if Input.is_key_pressed(KEY_SHIFT):
    motion *= 1.5
  return move_and_slide(motion)

func _update_animation(movement):
  animator.update_animation(
    get_node('Sprite/AnimationPlayer'),
    movement.get_animation()
  )

func _input(_event):
  self.update()

func _physics_process(_delta):
  var movement = _movement_factory()
  _update_animation(movement)
  _update_movement(movement)
    
  
  

