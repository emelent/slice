extends KinematicBody2D


const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

export var gravity_on = true
export var respawnable = false
export var gravity = 900
export var movement_speed = 200
export (float, 0, 20) var respawn_delay = 0.8
export var spawn_location = Vector2(0, 0)
export var character_name = ''
export var knockback_duration = 0.1

var allow_moving
var motion = Vector2(0,0)
var respawn_time = -1
var moving_left  = false
var moving_right = false
var hurting = false
var gravity_multiplier = 1
var dead = false

onready var Animator = $Animator
onready var Pivot = $Pivot
onready var Sprite = $Pivot/Sprite

func _ready():
	set_physics_process(true)
	set_process(true)

func _process(delta):
	__check_for_respawn(delta)
	__face_correct_dir()


func _physics_process(dt):
	__apply_gravity(dt)
	__move()


# face the right direction
func __face_correct_dir():
	if moving_left and Pivot.scale.x == 1:
		Pivot.scale.x = -1
	elif moving_right and Pivot.scale.x  == -1:
		Pivot.scale.x = 1

# apply gravity
func __apply_gravity(dt):
	if gravity_on:
		motion.y += gravity * dt * gravity_multiplier


# move the character
func __move():
	if moving_right:
		motion.x = movement_speed
	elif moving_left:
		motion.x = -movement_speed
	else:
		motion.x = 0

	motion = move_and_slide(motion, UP)

# check for character respawn
func __check_for_respawn(dt):
	if respawn_time == -1:
		return
	respawn_time += dt
	if respawn_time > respawn_delay:
		respawn()
		respawn_time = -1

func __on_kill():
	pass

# set the spawn location
func set_spawn_location(location):
	spawn_location = location

# kill the character
func kill():
	dead = true
	visible = false
	__on_kill()
	if not respawnable:
		queue_free()
	else:
		delayed_respawn()

# respawn the play after a delay
func delayed_respawn():
	respawn_time = 0

# respawn the player immediately
func respawn():
	dead = false
	gravity_on = true
	visible = true
	global_position = spawn_location
	reset()

# change current animation
func anim_play(name):
	if not Animator.current_animation == name:
		Animator.play('reset')
		Animator.play(name)

# reset character data
func reset():
	pass

func hurt():
	pass

func __on_hurt(area):
	if area.get_parent() == self: return
	if area.is_in_group('hitbox'):
		anim_play('Hurt')
		hurting = true
		hurt()
