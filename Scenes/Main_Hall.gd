extends Node


export var WallsMoveEc = 2
export var WallsMoveLimit = 20
export var WallsFadingSpeed = 0.02

var WallOneSpeed = Vector2.ZERO
var WallTwoSpeed = Vector2.ZERO
var WallThreeSpeed = Vector2.ZERO


func _process(delta):
	
	GlobalWalls()
	GobalPicture()
	pass

func GobalPicture():
	
	if !Global.PicPart1:
		$TextFrames/WallTextTwo.Manual = false
	
	if Global.PicPart1:
		$Picture/Part1.visible = true
		if has_node("TextFrames/PicTextOne"):
			$TextFrames/PicTextOne.Manual = true
		if has_node("TextFrames/WallTextTwo"):
			$TextFrames/WallTextTwo.Manual = true
			$TextFrames/WallTextOne.Manual = false
	
	
	if !Global.PicPart2:
		$TextFrames/WallTextThree.Manual = false
	
	if Global.PicPart2:
		$Picture/Part2.visible = true
		if has_node("TextFrames/PicTextTwo"):
			$TextFrames/PicTextTwo.Manual = true
		if has_node("TextFrames/WallTextThree"):
			$TextFrames/WallTextThree.Manual = true
			$TextFrames/WallTextTwo.Manual = false
			$TextFrames/WallTextOne.Manual = false
	
	if Global.PicPart3:
		$Picture/Part3.visible = true
		if has_node("TextFrames/PicTextThree"):
			$TextFrames/PicTextThree.Manual = true
		if has_node("TextFrames/WallTextEnd"):
			$TextFrames/WallTextEnd.Manual = true
			$TextFrames/WallTextThree.Manual = false
			$TextFrames/WallTextTwo.Manual = false
			$TextFrames/WallTextOne.Manual = false
	
	
	pass


func GlobalWalls():
	#----------WallOne
	if !Global.WallOneGoing:
		if !has_node("TextFrames/WallTextOne"):
			Global.WallOne = true
	
	if Global.WallOne:
		WallOneSpeed.x += WallsMoveEc
		$TileMaps/WallOne.modulate.a -= WallsFadingSpeed
	
	if WallOneSpeed.x >= WallsMoveLimit:
		WallOneSpeed.x = WallsMoveLimit
	
	if $TileMaps/WallOne.modulate.a <= 0:
		Global.WallOneGoing = true
		$Lamps/Lamp4.Enabled = true
		$Lamps/Lamp5.Enabled = true
	
	$TileMaps/WallOne.position += WallOneSpeed
	#----------WallOne
	
	#----------WallTwo
	if !Global.WallTwoGoing:
		if !has_node("TextFrames/WallTextTwo") and !Global.WallTwoGoing:
			Global.WallTwo = true
	
	if Global.WallTwo:
		WallTwoSpeed.x += WallsMoveEc
		$TileMaps/WallTwo.modulate.a -= WallsFadingSpeed
	
	if WallTwoSpeed.x >= WallsMoveLimit:
		WallTwoSpeed.x = WallsMoveLimit
	
	if $TileMaps/WallTwo.modulate.a <= 0:
		Global.WallTwoGoing = true
		$Lamps/Lamp6.Enabled = true
		$Lamps/Lamp7.Enabled = true
	
	$TileMaps/WallTwo.position += WallTwoSpeed
	#----------WallTwo
	
	#----------WallThree
	if !Global.WallThreeGoing:
		if !has_node("TextFrames/WallTextThree") and !Global.WallThreeGoing:
			Global.WallThree = true
	
	if Global.WallThree:
		WallThreeSpeed.x += WallsMoveEc
		$TileMaps/WallThree.modulate.a -= WallsFadingSpeed
	
	if WallThreeSpeed.x >= WallsMoveLimit:
		WallThreeSpeed.x = WallsMoveLimit
	
	if $TileMaps/WallThree.modulate.a <= 0:
		Global.WallThreeGoing = true
		$Lamps/Lamp8.Enabled = true
		$Lamps/Lamp9.Enabled = true
	
	$TileMaps/WallThree.position += WallThreeSpeed
	#----------WallThree
	pass
	




