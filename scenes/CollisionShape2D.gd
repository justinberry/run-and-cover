extends Node

const Interactable = preload('../../../interaction/Interactable.gd')

var dialog_interaction

func _init():
  self.dialog_interaction = Interactable.new('chair')

func (event):
  dialog_interaction.handle(event)