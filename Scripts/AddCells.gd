extends TileMap

var Tileset = get_tileset()
export(int) var ViewDistance = 4
export(int) var FadeDistance = 6
const FadeCheckDistance = 3

func _on_King_move():
	var King = $'../Pieces/King'
	var Center = world_to_map(King.position)

	# Make new cells around King
	for i in range(-ViewDistance, ViewDistance+1): 
		for j in range(-ViewDistance, ViewDistance+1): # Looping through X and Y
			if get_cellv(Vector2(Center.x+i, Center.y+j)) == -1: # If there's not tile in the position, add one
				# Decide whether to add dark or light square
				if int( ((Center.x+i) + (Center.y+j)) ) % 2 == 0: 
					set_cellv(Vector2(Center.x+i, Center.y+j), Tileset.find_tile_by_name("Tile1"))
				else:
					set_cellv(Vector2(Center.x+i, Center.y+j), Tileset.find_tile_by_name("Tile2"))

	#Remove old cells
	for i in range(-FadeDistance-FadeCheckDistance, FadeDistance+1+FadeCheckDistance): 
		for j in range(-FadeDistance-FadeCheckDistance, FadeDistance+1+FadeCheckDistance): # Looping through X and Y
			if abs(i)>FadeDistance || abs(j)>FadeDistance: # If outside max view distance, 
				set_cellv(Vector2(Center.x+i, Center.y+j), -1) # delete.

