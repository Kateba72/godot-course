extends TextureRect
class_name WinPanelStar

export var index: int = 0

func play_anim():
	var progress = GameManager.progress[GameManager.current_level_name]['star'+str(index)]
	if progress % 2:
		$HalfStar.visible = true
	$AnimationPlayer.play(str(progress > 1))