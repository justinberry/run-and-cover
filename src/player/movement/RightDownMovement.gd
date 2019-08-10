extends 'Movement.gd'

const RightMovement = preload('RightMovement.gd')
const DownMovement = preload('DownMovement.gd')

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