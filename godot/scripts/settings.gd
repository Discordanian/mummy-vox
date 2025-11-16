extends Control

@export var main_volume: HSlider   
@export var voice_volume: HSlider
@export var sfx_volume: HSlider

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var VOICE_BUS_ID = AudioServer.get_bus_index("Voice")
@onready var MAIN_BUS_ID = AudioServer.get_bus_index("Master")



func _ready() -> void:
    main_volume.value = ConfigManager.get_volume("MAIN_VOLUME")
    sfx_volume.value = ConfigManager.get_volume("SFX_VOLUME")
    voice_volume.value = ConfigManager.get_volume("VOICE_VOLUME")


func _on_sfx_volume_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
    ConfigManager.set_volume("SFX_VOLUME", value)


func _on_main_volume_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(MAIN_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(MAIN_BUS_ID, value < 0.05)
    ConfigManager.set_volume("MAIN_VOLUME", value)

func _on_voice_volume_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(VOICE_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(VOICE_BUS_ID, value < 0.05)
    ConfigManager.set_volume("VOICE_VOLUME", value)


func _on_return_button_button_down() -> void:
    print("Return to Main")
