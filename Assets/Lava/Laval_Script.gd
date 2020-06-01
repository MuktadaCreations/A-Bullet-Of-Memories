extends Area2D





func _on_Laval_body_entered(body):
	if body.name == "Player":
		Global.Health = 10
		get_tree().reload_current_scene()
