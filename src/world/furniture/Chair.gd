extends StaticBody2D

const Interactable = preload('../../interaction/Interactable.gd')

var dialog_interaction

func _init():
  self.dialog_interaction = Interactable.new('chair')

func _ready():
  set_process_input(true)
  set_process(true)
  self.connect('mouse_enter', self, '_on_Pusher_mouse_entered')

func _on_Pusher_input_event(viewport, event, shape_idx):
  print('got input:::')
  dialog_interaction.handle(event)

func _on_Pusher_mouse_entered():
  print("entered")
