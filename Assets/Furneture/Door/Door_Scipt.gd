extends Area2D

export (NodePath) var Player
var WaitForTheSoundEffect = false

export var GoToScene = ""
var GoTo

func _ready():
	GoTo = load(GoToScene)
	Player = get_node(Player)


func _on_Door_body_entered(body):
	if body.name == "Player":
		$Door_UI.visible = true


func _on_Door_body_exited(body):
	if body.name == "Player":
		$Door_UI.visible = false

func _process(delta):
	if Input.is_action_just_pressed("Enteract") and $Door_UI.visible == true and !$AudioPlayer.playing:
		$AudioPlayer.play()
		Player.Enabled = true
		Player.get_node("PlayerRig/AnimationPlayer").current_animation = "Idle"
		Player.Speed = 0
		
		WaitForTheSoundEffect = true
	
	if WaitForTheSoundEffect == true and !$AudioPlayer.playing:
		get_tree().change_scene_to(GoTo)




