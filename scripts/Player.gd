extends 'Character.gd'


export var death_sound = 'pop'
export (int, 1, 3) var player_num = 1
export var max_jumps = 2
export var jump_speed = 400
export (float, 0.0, 1.0) var wall_slide_friction = 0.9

const OUTLINE_COLORS = {
	'p1_': '#ff629d',
	'p2_': '#62cbff',
	'p3_': '#84ff61'
}

export (PackedScene) var Bullet = preload('res://scenes/Bullet.tscn')
var SlashAttack = preload('res://scenes/SlashAttack.tscn')
var AnimatedEffect = preload('res://scenes/AnimatedEffect.tscn')
var Splat = preload("res://scenes/Splatter.tscn")

var wall_hang = false
var airborne = false
var jumping = false
var jump_count = 0
var attacking = false
var level

onready var SlashPoint = $Pivot/SlashPoint
onready var JumpPoint = $JumpPoint
onready var FirePoint = $Pivot/FirePoint
onready var HitBoxShape = $HitBox/CollisionShape2D
onready var ColShape = $CollisionShape2D

func _ready():
	level = get_tree().current_scene
	character_name = 'p' + str(player_num) + '_'
	self.modulate = Color(OUTLINE_COLORS[character_name])


func _input(event):
	if dead: return
	if Input.is_action_just_pressed(character_name + 'a') and canJump():
		anim_play('idle')
		jumping = true
		jump_count += 1

	if Input.is_action_just_pressed(character_name + 'b') and not attacking and not wall_hang:
		slash_attack()

	elif Input.is_action_just_pressed(character_name + 'c') and not attacking and not wall_hang:
		shoot_attack()

func _process(dt):
	if dead: return
	__movement_input()


func _physics_process(dt):
	if dead: return
	jump()
	if is_on_floor():
		jump_count = 0
		if airborne:
			airborne = false
			AudioManager.play('land')
	else:
		airborne = true

func __movement_input():
	if attacking:
		moving_left = false
		moving_right = false
		return
	moving_left = Input.is_action_pressed(character_name + 'left')
	moving_right = Input.is_action_pressed(character_name + 'right')
	var moving = moving_left or moving_right
	wall_hang = false
	gravity_on = true

	if moving:
		if is_on_floor():
			anim_play('run')

		elif is_on_wall():
			if motion.y == 0:
				anim_play('wall_slide')
				wall_hang = true

			if motion.y > 0.0 and gravity_on:
				motion.y = 0.0
				gravity_on = false
		else:
			anim_play('jump')

	elif not attacking:
		if is_on_floor():
			anim_play('idle')
		else:
			anim_play('jump')


func canJump():
	return (is_on_floor() or jump_count < max_jumps) and not attacking

func jump():
	if not jumping: return
	AudioManager.play('jump')
	anim_play('jump')
	motion.y = -jump_speed
	jumping = false
	if is_on_floor():
		var effect = AnimatedEffect.instance()
		effect.anim_effect = effect.JUMPING_DUST
		effect.scale = Vector2(1.5, 1.5)
		effect.global_position = JumpPoint.global_position
		level.add_child(effect)

func reset():
	motion = Vector2(0, 0)
	jump_count = 0
	attacking = false
	HitBoxShape.disabled = false
	ColShape.disabled = false
	anim_play('idle')

func slash_attack():
	anim_play('slash')
	attacking = true
	var slash = SlashAttack.instance()
	slash.attacker = self
	SlashPoint.add_child(slash)

func shoot_attack():
	anim_play('shoot')
	attacking = true
	var bullet = Bullet.instance()
	bullet.direction = RIGHT * Pivot.scale.x
	bullet.global_position = FirePoint.global_position
	bullet.attacker = self
	level.add_child(bullet)


func __on_kill():
	HitBoxShape.disabled = true
	ColShape.disabled = true
	AudioManager.play(death_sound)


func _on_animation_finished(anim_name):
	if anim_name == 'slash' or anim_name == 'shoot':
		attacking = false

func __on_hitbox_entered(area):
	if not area.is_in_group('attacks'): return
	if area.get_parent() == SlashPoint: return

	print(character_name + ' killed by ' + area.attacker.character_name)
	killer = area.attacker
#	var effect = AnimatedEffect.instance()
#	effect.anim_effect = effect.RED_CLOUD
	var effect = Splat.instance()
	effect.global_position = global_position
	level.add_child(effect)
	level.kill_player(self)