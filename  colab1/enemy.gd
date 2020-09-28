extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3.ZERO
var grv = 0;
const UP = Vector3(0,1,0)
var mouse_sensitivity = 0.003;
onready var camera = $Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()

func move():
	velocity.y += grv
	var target_dir = Vector3.ZERO
	if(Input.is_key_pressed(ord("A")) != Input.is_key_pressed(ord("D"))):
		if(Input.is_key_pressed(ord("A"))):
			target_dir.x = -10
		elif(Input.is_key_pressed(ord("D"))):
			target_dir.x = 10
	if(Input.is_key_pressed(ord("W")) != Input.is_key_pressed(ord("S"))):
		if(Input.is_key_pressed(ord("W"))):
			target_dir.z = -10
		elif(Input.is_key_pressed(ord("S"))):
			target_dir.z = 10
	if(is_on_floor()):
		if(Input.is_key_pressed(KEY_SPACE)):
			velocity.y = 50
		grv = 0
	else:
		grv -= 0.098
	#print(target_dir)
	target_dir = target_dir.rotated(UP,get_rotation().y)
	#print(target_dir.rotated(UP,deg2rad(get_rotation().y)))
	
	velocity.x = target_dir.x
	velocity.z = target_dir.z
	
	velocity = move_and_slide(velocity,UP);

func _unhandled_input(event):
	if event is InputEventMouse:
		rotate(UP,-event.relative.x*mouse_sensitivity)
		camera.rotate(Vector3(1,0,0),-event.relative.y*mouse_sensitivity)
		camera.rotation.x = clamp(camera.get_rotation().x,-1,1)

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().quit()
















