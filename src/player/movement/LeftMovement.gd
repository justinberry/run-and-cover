extends 'Movement.gd'

const _MOTION = Vector2(-1, 0)
  
func is_moving():
  return Input.is_action_pressed('move_left')

func get_motion():
  return _MOTION

func get_animation():
  return 'WalkLeft'