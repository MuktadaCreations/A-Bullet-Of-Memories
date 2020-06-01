extends Node2D


func _ready():
	$PlayerRig/AnimationPlayer.play("Idle")

func _process(delta):
	if $PlayerRig/AnimationPlayer.current_animation_position == $PlayerRig/AnimationPlayer.current_animation_length:
		$PlayerRig/AnimationPlayer.play($PlayerRig/AnimationPlayer.current_animation)
