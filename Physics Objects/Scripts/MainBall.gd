extends PhysicsBody2D

func _ready():
    GameManager.ball_count += 1

func _process(delta):
    if position.y > get_viewport().size.y * 1.25:
        GameManager.ball_dropped()
        queue_free()
