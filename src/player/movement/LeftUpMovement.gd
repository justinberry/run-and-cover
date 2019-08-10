extends 'Movement.gd'

const UpMovement = preload('UpMovement.gd')
const LeftMovement = preload('LeftMovement.gd')

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