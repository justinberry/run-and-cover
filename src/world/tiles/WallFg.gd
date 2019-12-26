extends TileMap

var tileset

var place_dragging = false
var erase_dragging = false

func _ready():
  tileset = get_tileset()
  set_process_input(true)

func _input(event):
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_LEFT and event.is_pressed():
      place_dragging = true
    if event.button_index == BUTTON_LEFT and !event.is_pressed():
      place_dragging = false
      
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_RIGHT and event.is_pressed():
      erase_dragging = true
    if event.button_index == BUTTON_RIGHT and !event.is_pressed():
      erase_dragging = false
  
  if !place_dragging && !erase_dragging:
    var tile_pos = world_to_map(get_local_mouse_position())
    
func _process(_delta):
    if place_dragging:
      var tile_pos = world_to_map(get_local_mouse_position())
      set_cellv(tile_pos, tileset.find_tile_by_name("floor1"))
      
    if erase_dragging:
      var tile_pos = world_to_map(get_local_mouse_position())
      set_cellv(tile_pos, -1)