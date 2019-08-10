extends 'Movement.gd'

const UpMovement = preload('UpMovement.gd')
const RightMovement = preload('RightMovement.gd')

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