extends 'Movement.gd'

const LeftMovement = preload('LeftMovement.gd')
const DownMovement = preload('DownMovement.gd')

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