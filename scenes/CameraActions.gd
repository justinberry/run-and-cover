extends Camera2D

const ZOOM_SCALE = 0.2
const ZOOM_SPEED = 10

var target_zoom = 2
var smooth_zoom = 2

var locked = false

var original_parent
var manual_camera_focus

func _ready():
  set_process_input(true)
  set_physics_process(true)
  original_parent = self.get_parent()
  manual_camera_focus = original_parent.get_parent().get_node('ManualCameraFocus')

func is_within_lower_bound():
  return target_zoom > 0.5
  
func is_within_upper_bound():
  return target_zoom < 4

func _physics_process(delta):
  smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
  if smooth_zoom != target_zoom:
    set_zoom(Vector2(smooth_zoom, smooth_zoom))

func _handle_zoom(_event):
  if (Input.is_action_just_pressed('zoom_in') && is_within_lower_bound()):
    target_zoom -= ZOOM_SCALE
  elif (Input.is_action_just_pressed('zoom_out') && is_within_upper_bound()):
     target_zoom += ZOOM_SCALE

func _handle_camera_toggle():
  if locked:
      self.get_parent().remove_child(self)
      original_parent.add_child(self)
      self.set_owner(original_parent)
  else:
    original_parent.remove_child(self)
    manual_camera_focus.set_global_position(original_parent.get_global_position())
    manual_camera_focus.add_child(self)
    self.set_owner(manual_camera_focus)
  locked = !locked

func _input(event):
  _handle_zoom(event)
    
  if Input.is_action_pressed('camera_lock_toggle'):
    _handle_camera_toggle()
    