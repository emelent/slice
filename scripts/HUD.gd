extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var p1_score = $P1/score
onready var p2_score = $P2/score
onready var p3_score = $P3/score

onready var p1_bullet_icon = $P1/BulletIcon
onready var p2_bullet_icon = $P2/BulletIcon
onready var p3_bullet_icon = $P3/BulletIcon

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass



func update_score(stats):
	if stats.has('p1_'):
		p1_score.text =  str(stats['p1_']['kills']) + ' / ' + str(stats['p1_']['deaths'])
		p1_bullet_icon.visible = stats['p1_']['bullets'] > 0
		print('p1_bullets: ', stats['p1_']['bullets'])
	if stats.has('p2_'):
		p2_score.text =  str(stats['p2_']['kills']) + ' / ' + str(stats['p2_']['deaths'])
		p2_bullet_icon.visible = stats['p2_']['bullets'] > 0
		print('p2_bullets: ', stats['p2_']['bullets'])
	if stats.has('p3_'):
		p3_score.text =  str(stats['p3_']['kills']) + ' / ' + str(stats['p3_']['deaths'])
		p3_bullet_icon.visible = stats['p3_']['bullets'] > 0