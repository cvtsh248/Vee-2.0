extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
var oof = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_safe_margin(1)


func _physics_process(delta):
	if is_on_floor() == false:
		motion.y += 20
	if is_on_floor() == true:
		if Input.is_action_pressed("ui_up"):
			motion.y = -400
		else:
			motion.y = 0
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		$Sprite.play("Walk")
		motion.x = 50
	if Input.is_action_just_pressed("ui_left"):
		$Sprite.flip_h =false
		$Sprite.play("Walk")
		motion.x = -50
	if Input.is_action_pressed("ui_right") == false and Input.is_action_pressed("ui_left") == false:
		$Sprite.play("Idle")
		motion.x = 0
	print(motion.y)
	move_and_slide(motion, UP)

