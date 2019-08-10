extends 'Movement.gd'
  
func is_moving():
  return false
  
func get_motion():
  return Vector2(0, 0)

func get_animation():
  return 'Idle'