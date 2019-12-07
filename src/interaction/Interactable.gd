extends Node

const Assert = preload('../program_state/Assert.gd')

var target
var text_resources
var description_label

func _init(target, dialog_resource):
  self.target = target
  
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

func _get_description_label():
  if !description_label:
    description_label = target.get_tree().get_root().get_node('Main/World/Labels/DescriptionLabel')
    
  return description_label

# Events

func handle_hover():
  print('description position: ', _get_description_label().get_position())
  _get_description_label().set_text(_get_hover())

func _get_hover():
  return _get_dialog_resource('interaction/chair')['hover']
  
func _get_click():
  return _get_dialog_resource('interaction/chair')['click']

func handle_click(event):
  if event is InputEventMouseButton:
    if (event.button_index == BUTTON_LEFT):
      print('target position: ', target.get_global_position())
      print('description position: ', _get_description_label().get_position())
      _get_description_label().set_global_position(target.get_global_position())
      _get_description_label().set_text(_get_click())
