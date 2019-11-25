extends Node

var dialog_resource

func _init(dialog_resource):
  self.dialog_resource = dialog_resource

func _get_dialog_resource():
  var resource_file = File.new()

  if resource_file.open('res://dialog/' + self.dialog_resource + '.json', File.READ) != OK:
    error('Failed to load resource:', self.dialog_resource)
   
  return JSON.parse(resource_file)

func handle(event):
  if event is InputEventMouseMotion:
    print('got InputEventMouseMotion')
  elif event is InputEventMouseButton:
    print('input event', event)
    if (event.button_index == BUTTON_LEFT):
      print('clicked')

func get_hover():
  return _get_dialog_resource().hover
