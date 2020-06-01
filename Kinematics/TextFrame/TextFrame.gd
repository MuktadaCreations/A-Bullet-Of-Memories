extends Area2D

export var TextLists = ["Flaw"]

var Player

export var Automatic = false
export var Manual = false
export var Starting = false
export var LettersSpeed = 0.5
export var LettersSpeedBoosted = 1.0
export var OriginalLettersTIme = 1.0
export var LettersTime = 1.0
export var FadingSpeed = 0.02
export var FallowCamera = false


export (NodePath) var _Camera
export (NodePath) var _Player
export (PackedScene) var goto

var Ending = false
var ListSize = 0
var StartingLetters = false
var LettersTimer = false
var YouCanDestroyTheFrame = false

func _ready():
	$Frame.modulate.a = 0
	$GameText.visible_characters = 0
	if TextLists.size() > 0:
		$GameText.bbcode_text = TextLists[0]
	$"Space Bar".visible = false
	

# warning-ignore:unused_argument
func _physics_process(delta):
	
	Effects()
	LettersTyping()
	Input()
	

func Effects():
	if Starting:
		$Frame.visible = true
		$Frame.modulate.a += FadingSpeed
		if $Frame.modulate.a >= 1:
			Starting = false
			$LightOccluder2D.visible = true
			$GameText.visible = true
			$Frame.modulate.a = 1
			$"Space Bar".visible = true
			StartingLetters = true
	
	if Ending:
		$Frame.modulate.a -= FadingSpeed
		$GameText.visible = false
		$LightOccluder2D.visible = false
		$"Space Bar".visible = false
		if $Frame.modulate.a <= -0:
			if !_Player == "":
				get_node(_Player).Enabled = false
			
			if !goto == null:
				get_tree().change_scene_to(goto)
			queue_free()
	
	
	if FallowCamera:
		if !_Camera == "Player" and !_Camera == "":
			position = get_node(_Camera).global_position
		
		if _Camera == "" and !_Player == "":
			position = get_node(_Player).get_node("PlayerCamera").global_position
	
	
	if LettersTimer == true:
		if Input.is_action_pressed("LeftCLick") or Input.is_action_pressed("Accept"):
			LettersTime -= LettersSpeedBoosted 
		else:
			LettersTime -= LettersSpeed 
	
	if $GameText.visible_characters == $GameText.bbcode_text.length() and ListSize == TextLists.size():
		StartingLetters = false
		YouCanDestroyTheFrame = true
	
	if $GameText.visible_characters == $GameText.bbcode_text.length() and !ListSize == TextLists.size():
		StartingLetters = false
	

func LettersTyping():
	if StartingLetters == true:
		LettersTimer = true
		if LettersTime <= 0:
			$GameText.visible_characters += 1
			$AudioPlayer.play()
			LettersTime = OriginalLettersTIme
	

func Input():
	if Input.is_action_just_pressed("Accept") and ListSize == TextLists.size() - 1 and !StartingLetters and $Frame.visible and $Frame.modulate.a >= 1:
		Ending = true
	
	if Input.is_action_just_pressed("Accept") and !StartingLetters and !ListSize == TextLists.size() - 1 and $Frame.visible and $Frame.modulate.a >= 1:
		$GameText.visible_characters = 0
		ListSize += 1
		$GameText.bbcode_text = TextLists[ListSize]
		StartingLetters = true
	
	if Input.is_action_just_pressed("Enteract") and $Manual.visible:
		get_node(_Player).Enabled = true
		get_node(_Player).Speed = 0
		get_node(_Player).get_node("PlayerRig/AnimationPlayer").current_animation = "Idle"
		FallowCamera = true
		$Manual.visible = false
		Starting = true
	
	


func _on_TextFrame_body_entered(body):
	if body.name == "Player":
		if Automatic:
			get_node(_Player).Enabled = true
			get_node(_Player).Speed = 0
			get_node(_Player).get_node("PlayerRig/AnimationPlayer").current_animation = "Idle"
			FallowCamera = true
			Starting = true
		
		
		if Manual:
			$Manual.visible = true


func _on_TextFrame_body_exited(body):
	if body.name == "Player":
		if Manual:
			$Manual.visible = false
	
