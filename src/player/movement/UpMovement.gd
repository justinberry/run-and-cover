extends 'Movement.gd'

const _MOTION = Vector2(0, -1)

func is_moving():
 return Input.is_action_pressed('move_up')

func get_motion():
  return _MOTION

func get_animation():
  return 'WalkUp'