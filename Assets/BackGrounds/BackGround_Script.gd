extends Node2D

export (NodePath) var Player
export var FallowPlayer = false

func _ready():
	Player = get_node(Player)


func _process(delta):
	
	
	if FallowPlayer:
		self.position = Player.get_node("PlayerCamera").global_position
	
	




