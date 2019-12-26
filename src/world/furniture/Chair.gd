extends StaticBody2D

const Interactable = preload('../../interaction/Interactable.gd')

var dialog_interaction

func _init():
  self.dialog_interaction = Interactable.new(self, 'interaction/chair')

func _on_Pusher_input_event(_viewport, event, _shape_idx):
  dialog_interaction.handle_click(event)

func _on_Pusher_mouse_entered():
  dialog_interaction.handle_hover()

func _on_Pusher_mouse_exited():
  dialog_interaction.handle_hover_exit()
