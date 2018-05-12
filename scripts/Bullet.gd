extends Area2D

export var speed = 300
export(int) var maxWraps = 1
var attacker
var direction = Vector2()
var offset = 50
var wrapCount = 0


func _physics_process(delta):
	position += direction.normalized() * speed * delta


func bullet_hit():
	direction = Vector2(0, 0)
	$Animator.play('bullet_hit')

func __on_bullet_area_entered(area):
	if area.is_in_group('bullets'): return
	if area.is_in_group('slashes'):
		direction *= -1
		return

	if area.is_in_group('wrappers'):
		wrapCount += 1
		if maxWraps < 0 or wrapCount < maxWraps  * 2:
			return
		else:
			queue_free()

	bullet_hit()

func __on_bullet_body_entered(body):
	if body.is_in_group('character_colliders'): return
	bullet_hit()


func _on_Animator_animation_finished(anim_name):
	queue_free()
