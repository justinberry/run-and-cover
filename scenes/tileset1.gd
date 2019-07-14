extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	print('hello world')
	var s_size = get_node('wall1').get_texture().get_size()
	
	var width = 128
	var height = 64
	
	var scale = Vector2(
		(s_size.x / (s_size.x/tw)) / 50,
		(s_size.y / (s_size.y/th)) / 50
	)
	
	wall1_sprite.set_scale(scale)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
