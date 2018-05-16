extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var p1_score = $P1/score
onready var p2_score = $P2/score
onready var p3_score = $P3/score

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func update_score(stats):
	p1_score.text =  str(stats['p1_']['kills']) + ' / ' + str(stats['p1_']['deaths'])
	if GameManager.num_players > 1:
		p2_score.text =  str(stats['p2_']['kills']) + ' / ' + str(stats['p2_']['deaths'])
	if GameManager.num_players > 2:
		p3_score.text =  str(stats['p3_']['kills']) + ' / ' + str(stats['p3_']['deaths'])