extends 'Character.gd'



export (int, 1, 3) var player_num = 1
export var max_jumps = 2
export var jump_speed = 400
export (float, 0.0, 1.0) var wall_slide_friction = 0.9

const OUTLINE_COLORS = {
	'p1_': '#ff629d',
	'p2_': '#62cbff',
	'p3_': '#84ff61'
}

var SlashAttack = preload('res://scenes/SlashAttack.tscn')
var JumpEffect = preload('res://scenes/JumpEffect.tscn')
var HurtEffect = preload('res://scenes/AnimatedEffect.tscn')

var jumping = false
var jump_count = 0
var attacking = false

onready var SlashPoint = $Pivot/SlashPoint
onready var JumpPoint = $JumpPoint

func _ready():
	character_name = 'p' + str(player_num) + '_'
#	self.modulate = Color(OUTLINE_COLORS[character_name])


func _input(event):
	if Input.is_action_just_pressed(character_name + 'a') and canJump():
		anim_play('idle')
		jumping = true
		jump_count += 1

	if Input.is_action_just_pressed(character_name + 'b') and not attacking:
		slash_attack()

func _process(dt):
	__movement_input()


func _physics_process(dt):
	jump()
	if is_on_floor():
		jump_count = 0

func __movement_input():
	if attacking: return
	moving_left = Input.is_action_pressed(character_name + 'left')
	moving_right = Input.is_action_pressed(character_name + 'right')
	var moving = moving_left or moving_right
	if moving and is_on_floor():
		anim_play('run')

	if moving and is_on_wall():
		anim_play('wall_slide')
		if motion.y > 0.0 and gravity_on:
			motion.y = 0.0
			gravity_on = false
	else:
		gravity_on = true

	if not moving and not attacking:
		if is_on_floor():
			anim_play('idle')
		else:
			anim_play('jump')


func canJump():
	return (is_on_floor() or jump_count < max_jumps) and not attacking

func jump():
	if not jumping: return
	anim_play('jump')
	motion.y = -jump_speed
	jumping = false
	if is_on_floor():
		var effect = JumpEffect.instance()
		get_parent().add_child(effect)
		effect.global_position = JumpPoint.global_position

func reset():
	motion = Vector2(0, 0)
	jump_count = 0

func slash_attack():
	anim_play('slash')
	attacking = true
	SlashPoint.add_child(SlashAttack.instance())


func _on_animation_finished(anim_name):
	if anim_name == 'slash':
		attacking = false

func __on_hitbox_entered(area):
	if not area.is_in_group('attacks'): return

	print(character_name + ' hurt by ' + area.name)
	var effect = HurtEffect.instance()
	effect.anim_effect = effect.RED_CLOUD
	effect.global_position = global_position
	get_parent().add_child(effect)