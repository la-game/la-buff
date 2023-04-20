extends CharacterBody2D


var speed = 400


func _physics_process(_delta):
	move()


func move():
	var x_axis = Input.get_axis("ui_left", "ui_right")
	var y_axis = Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(x_axis, y_axis)
	var speed_buffed = $Buffs.calculate(speed, "speed")
	
	velocity = direction * speed_buffed
	
	move_and_slide()
