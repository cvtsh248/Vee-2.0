extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
var jump = false
var count = 0

func _ready():
	set_safe_margin(2)
	set_process_input(true)

# warning-ignore:unused_argument
func _physics_process(delta):
	if is_on_floor() == false:
		motion.y += 20

		if is_on_wall() == false:
			jump = true
			#$Sprite.play("Jump")
			
		if is_on_wall() == true:
			jump = false
			motion.x = 0

		if Input.is_action_pressed("ui_right"):
			$Sprite.flip_h = true
			motion.x = 100
			
		if Input.is_action_pressed("ui_left"):
			$Sprite.flip_h =false
			motion.x = -100
			
	if is_on_floor() == true:
		motion.y = 0
		if Input.is_action_pressed("ui_up"):
			motion.y = -500
			
		if jump == true:
			count += 1
			if is_on_wall() == false:
				pass
				#$Sprite.play("Land")
			#motion.x = 0
			
		if count > 20:
			count = 0
			jump = false

			
		if jump == false:
			if Input.is_action_pressed("ui_right"):
				$Sprite.flip_h = true
				if $RayCast2D.is_colliding() == true:
					$Sprite.play("Idle")
				else:
					$Sprite.play("Walk")
				motion.x = 100

			if Input.is_action_pressed("ui_left"):
				$Sprite.flip_h =false
				if $RayCast2D2.is_colliding() == true:
					$Sprite.play("Idle")
				else:
					$Sprite.play("Walk")
				motion.x = -100
		
	if Input.is_action_pressed("ui_right") == false and Input.is_action_pressed("ui_left") == false:

		motion.x = 0
		if jump == false:
			$Sprite.play("Idle")
		if is_on_wall() == true:
			$Sprite.play("Idle")

	move_and_slide(motion, UP)
