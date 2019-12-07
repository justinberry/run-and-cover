extends Camera2D

const ZOOM_SCALE = 0.2
const ZOOM_SPEED = 10

var target_zoom = 2
var smooth_zoom = 2

func _ready():
  set_process_input(true)
  set_physics_process(true)

func is_within_lower_bound():
  return target_zoom > 0.5
  
func is_within_upper_bound():
  return target_zoom < 4

func _physics_process(delta):
	smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
	if smooth_zoom != target_zoom:
		set_zoom(Vector2(smooth_zoom, smooth_zoom))

func _input(event):
 if event is InputEventMouseButton:
   if (event.button_index == BUTTON_WHEEL_UP && is_within_lower_bound()):
    target_zoom -= ZOOM_SCALE
   elif (event.button_index == BUTTON_WHEEL_DOWN && is_within_upper_bound()):
     target_zoom += ZOOM_SCALE