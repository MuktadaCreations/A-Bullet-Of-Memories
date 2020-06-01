extends Node

export (PackedScene) var GoTo
export var Fading_Speed = 0.02
export var CameraEcSpeed = 1
#export var CameraSpeedLimit = 10.0

var Speed = Vector2.ZERO
var ExitStartFading = false
var PlaystartFading = false
var GoToOptions = false
var GoToMenu = false

var MuFix = true


func _ready():
	$Camera2D/FadingEffect.visible = true
	$Camera2D/FadingEffect.modulate.a = 0
	$Camera2D.position = $Menu_Position.position
	$Music.set_toggle_mode(1)

func _physics_process(delta):
	
	Play()
	Exit()
	Options()
	Back()
	Music()
	

func _on_Play_button_down():
	PlaystartFading = true
	pass 

func Play():
	if PlaystartFading == true:
		$Camera2D/FadingEffect.modulate.a += Fading_Speed
	
	if $Camera2D/FadingEffect.modulate.a >= 1:
		get_tree().change_scene_to(GoTo)


func _on_Options_button_down():
	if !GoToMenu:
		GoToOptions = true

func _on_Back_button_down():
	if !GoToOptions:
		GoToMenu = true


func Options():
	
	if  GoToOptions and $Camera2D.position.x >= $Options_Position.position.x:
		Speed.x = -CameraEcSpeed
	elif GoToOptions and $Camera2D.position.x <= $Options_Position.position.x and !GoToMenu:
		Speed.x = 0
		GoToOptions = false
	
	
	$Camera2D.position += Speed 


func _on_Exit_button_down():
	ExitStartFading = true

func Exit():
	if ExitStartFading:
		$Camera2D/FadingEffect.modulate.a += Fading_Speed
	
	if $Camera2D/FadingEffect.modulate.a >= 1 and ExitStartFading:
		get_tree().quit()


func Back():
	var MenuPosition = $Menu_Position.position.normalized()
	
	if  GoToMenu and $Camera2D.position.x <= $Menu_Position.position.x:
		Speed.x = CameraEcSpeed
	elif GoToMenu and $Camera2D.position.x >= $Menu_Position.position.x and !GoToOptions:
		Speed.x = 0
		GoToMenu = false
	
	
	$Camera2D.position.x += Speed.x

func Music():
	
	if $Music.pressed:
		Global.Music = true
	else:
		Global.Music = false
	
	if Global.Music:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 1)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80)
	
	if $FX.pressed:
		Global.FX = true
	else:
		Global.FX = false
	
	if Global.FX:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), 1)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"), -80)
	
	









