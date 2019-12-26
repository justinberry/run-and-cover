extends TileMap

var tileset

var dragging = false

func _ready():
  tileset = get_tileset()
  set_process_input(true)

func _input(event):
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_LEFT and event.is_pressed():
      dragging = true
    if event.button_index == BUTTON_LEFT and !event.is_pressed():
      dragging = false
  
  if !dragging:
    var tile_pos = world_to_map(get_local_mouse_position())
    var cell_index = get_cellv(tile_pos)
    var cell = get_used_cells_by_id(cell_index)
    
func _process(_delta):
    if dragging:
      var tile_pos = world_to_map(get_local_mouse_position())
      set_cellv(tile_pos, tileset.find_tile_by_name("floor1"))