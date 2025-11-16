extends Control

@export var main_volume: HSlider
@export var sfx_volume: HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # If local values present use them.
    main_volume.value = 80
    sfx_volume.value = 40


func _on_main_volume_drag_ended(value_changed: bool) -> void:
    if value_changed:
        print("New value of Master Volume ", main_volume.value)


func _on_sfx_volume_drag_ended(value_changed: bool) -> void:
    if value_changed:
        print("New value of SFX Volume ", sfx_volume.value) # Replace with function body.
