extends TextureRect
class_name WinPanelStar

export var index: int = 0

func play_anim():
	var anim = str(GameManager.progress[GameManager.current_level_name]['star'+str(index)])
	$AnimationPlayer.play(anim)
	print(anim)