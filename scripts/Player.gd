class_name Player extends CharacterBody3D

@export var props : PlayerProperties

@onready var camera : Camera3D = $Cam

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate(transform.basis.y, -event.relative.x * props.mouse_sensitivity.x)
		camera.rotate(camera.transform.basis.x, -event.relative.y * props.mouse_sensitivity.y)
		camera.rotation = Vector3(clamp(camera.rotation.x, -PI/2, PI/2), 0, 0)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_add_WASD_movement()
		_add_jump_handle()
	else:
		_add_gravity(delta)
	move_and_slide()

## !!! _add functions adding vector to velocity

func _add_WASD_movement() -> void:
	var _v : Vector2 = Input.get_vector("move_left","move_right","move_forward","move_backward")
	velocity = (Vector3(_v.x, 0, _v.y) * props.movement_speed).rotated(transform.basis.y, rotation.y)

func _add_gravity(delta : float) -> void:
	velocity += get_gravity() * delta

func _add_jump_handle() -> void:
	if Input.is_action_just_pressed("do_jump"):
		velocity += up_direction * props.jump_force
