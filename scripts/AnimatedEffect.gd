extends Node2D

enum AnimationEffect{
	DUST_CLOUD,
	RED_CLOUD,
	STAR_CLOUD,
	BUBBLES,
	UNDERWATER_EXPLOSION,
	STAR_COLLECT,
	BULLET_HIT,
	JUMPING_DUST,
	LANDING_DUST,
	TELEPORT
}
export (AnimationEffect) var anim_effect = DUST_CLOUD;


const ANIMATION_NAMES={
	DUST_CLOUD: 'dust_cloud',
	RED_CLOUD: 'red_cloud',
	STAR_CLOUD: 'star_cloud',
	BUBBLES: 'bubbles',
	UNDERWATER_EXPLOSION: 'underwater_explosion',
	STAR_COLLECT: 'star_collect',
	BULLET_HIT: 'bullet_hit',
	JUMPING_DUST: 'jumping_dust',
	LANDING_DUST: 'landing_dust',
	TELEPORT: 'teleport'
}

func _ready():
	$Animator.play(ANIMATION_NAMES[anim_effect])

func _on_animation_finished(anim_name):
	queue_free()
