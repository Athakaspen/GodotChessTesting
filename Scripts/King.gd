extends Node2D

# If the king has just moved
signal move

# Vars for movement grid calculations
onready var Board = $'../../Board'
const TILEOFFSET = Vector2(64,64)

# movement
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_pressed(): # if Left Mouse is clicked
				var mousePos = get_global_mouse_position() # Get World Position of mouse
				var BoardPos = Board.world_to_map(mousePos) # convert to Board Coordinates
				# Check if it's a legal move
				var StartPos = Board.world_to_map(self.position) # Get King Position
				var difference = BoardPos-StartPos # Get difference in position
				if abs(difference.x)<=1 && abs(difference.y)<=1 && !(difference.x==0 && difference.y==0): # If legal:
					var newPos = Board.map_to_world(BoardPos)+TILEOFFSET # Convert back to World point and add offset
					self.position = newPos # update position
					emit_signal("move") # Broadcast movement signal