extends Node

var previous_animation = ''

func update_animation(animation_player, next_animation):
  if previous_animation != next_animation:
    previous_animation = next_animation
    animation_player.play(next_animation)