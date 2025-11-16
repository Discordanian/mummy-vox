extends Control

@export var main_volume: HSlider   
@export var voice_volume: HSlider
@export var sfx_volume: HSlider

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var VOICE_BUS_ID = AudioServer.get_bus_index("Voice")
@onready var MAIN_BUS_ID = AudioServer.get_bus_index("Master")



func _ready() -> void:
    main_volume.value = AudioServer.get_bus_volume_linear(MAIN_BUS_ID)
    sfx_volume.value = AudioServer.get_bus_volume_linear(SFX_BUS_ID)
    voice_volume.value = AudioServer.get_bus_volume_linear(VOICE_BUS_ID)


func _on_sfx_volume_value_changed(value: float) -> void:
    print("New value of SFX Volume ", sfx_volume.value) 
    AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func _on_main_volume_value_changed(value: float) -> void:
    print("New value of MAIN Volume ", sfx_volume.value) 
    AudioServer.set_bus_volume_db(MAIN_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(MAIN_BUS_ID, value < 0.05)

func _on_voice_volume_value_changed(value: float) -> void:
    print("New value of VOX Volume ", sfx_volume.value) 
    AudioServer.set_bus_volume_db(VOICE_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(VOICE_BUS_ID, value < 0.05)


func _on_return_button_button_down() -> void:
    print("Return to Main")
