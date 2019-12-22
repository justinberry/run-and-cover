extends Node

const Assert = preload('../program_state/Assert.gd')
const Fade = preload('../transition/Fade.gd')

var target
var text_resources
var dialog_resource

var description_label
var summary_label

var hover_tween
var click_tween

func _init(target, dialog_resource):
  self.target = target
  self.dialog_resource = dialog_resource
  self.hover_tween = Tween.new()
  self.click_tween = Tween.new()

func _get_dialog_resource(resource):
  if !text_resources:
    var resource_file = File.new()
  
    var filename = 'res://dialog/' + resource + '.json'
    Assert.that(
      resource_file.open(filename, File.READ) == OK,
      'Failed to read resource ' + filename
    )
    
    text_resources = JSON.parse(resource_file.get_as_text()).result

  return text_resources

func _get_root_node():
  return target.get_tree().get_root()

func _get_description_label():
  if !description_label:
    description_label = Label.new()
    self.target.add_child(description_label)
    description_label.add_child(click_tween)
    description_label.rect_position = Vector2(-50, 60)
  return description_label
  
func _get_summary_label():
  if !summary_label:
    summary_label = Label.new()
    self.target.add_child(summary_label)
    summary_label.add_child(hover_tween)
    summary_label.rect_position = Vector2(-50, 40)
  return summary_label

# Events

func _get_hover():
  return _get_dialog_resource(self.dialog_resource)['hover']
  
func _get_click():
  return _get_dialog_resource(self.dialog_resource)['click']

func handle_hover():
  var label = _get_summary_label()
  label.set_text(_get_hover())
  label.modulate = Color(1, 1, 1, 1)
  hover_tween.interpolate_property(
    label,
    'modulate',
    label.modulate,
    Color(1, 1, 1, 1),
    0.1,
    Tween.TRANS_LINEAR,
    Tween.EASE_IN
  )
  hover_tween.start()

func handle_hover_exit():
  var label = _get_summary_label()
  hover_tween.interpolate_property(
    label,
    'modulate',
    label.modulate,
    Color(1, 1, 1, 0),
    0.2,
    Tween.TRANS_LINEAR,
    Tween.EASE_OUT
  )
  hover_tween.start()

func handle_click(event):
  if event is InputEventMouseButton && event.is_pressed():
    var label = _get_description_label()
    label.set_text(_get_click())
    if (event.button_index == BUTTON_LEFT):
      click_tween.interpolate_property(
        label,
        'modulate',
        label.modulate,
        Color(1, 1, 1, 1),
        0.1,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
      )
      click_tween.start()
      
    if (event.button_index == BUTTON_RIGHT):
      click_tween.interpolate_property(
        label,
        'modulate',
        label.modulate,
        Color(1, 1, 1, 0),
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_OUT
      )
      click_tween.start()
      
