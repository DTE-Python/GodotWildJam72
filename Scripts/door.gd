extends Node3D


@export var PlayerCanInteract = false
var open = false
@export var animation_player: AnimationPlayer
@export var AffectedByButton: int

func PlayerInteraction():
	if PlayerCanInteract:
		PlayerCanInteract = false
		open = !open
		if open:
			animation_player.play("open")
		else:
			animation_player.play("close")
		await get_tree().create_timer(1.0, false).timeout
		PlayerCanInteract = true

func OtherInteraction(setting):
	var resetPlayerInteract = false
	
	if PlayerCanInteract:
		resetPlayerInteract = true
		PlayerCanInteract = false
	
	open = !open
	
	if open:
			animation_player.play("close")
	else:
		animation_player.play("open")
		
	if get_tree():
		await get_tree().create_timer(1.0, false).timeout

	
	if resetPlayerInteract:
		PlayerCanInteract = true


func _on_button_body_entered(buttonID):
	if AffectedByButton == buttonID:
		OtherInteraction(true)

func _on_button_body_exited(buttonID):
	if AffectedByButton == buttonID:
		OtherInteraction(false)
