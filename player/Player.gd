extends CharacterBody2D

func _init():
	pass

func _process(_delta):
	pass

var speed = 10
var max_speed = 1000
var rotate_speed = 0.1
var nose = Vector2(0,-60)
var Bullet = load("res://player/bullet.tscn")

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	$Exhaust2.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
		$Exhaust2.show()
	if Input.is_action_pressed("Left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("Right"):
		rotation += rotate_speed
	return to_return.rotated(rotation)

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)

	position.x = wrapf(position.x, 0, 1152)
	position.y = wrapf(position.y, 0, 648)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		var bullet = Bullet.instantiate() 
		bullet.position = position + nose.rotated(rotation)
		bullet.rotation = rotation
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			Effects.add_child(bullet)
