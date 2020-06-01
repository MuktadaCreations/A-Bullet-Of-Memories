extends StaticBody2D

export var Enabled = false

func _process(delta):
	$Light2D.enabled = Enabled
