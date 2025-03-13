extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000

const SPEED = 300

 
enum state { Idle, Run }

var current_state

func _ready():
	current_state = state.Idle


func _physics_process(delta):
	player_falling(delta)
	player_Idle(delta)
	player_run(delta)
	
	move_and_slide()
	
	player_animation()


func player_falling(delta):
	if !is_on_floor():
		velocity.y += 1000 * delta


func player_Idle(delta):
	if is_on_floor():
		current_state = state.Idle
		
func player_run(delta):
	var direction = Input.get_axis("move_left" , "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		current_state = state.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true  

func player_animation():
	if current_state == state.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state == state.Run:
		animated_sprite_2d.play("Run")
		
