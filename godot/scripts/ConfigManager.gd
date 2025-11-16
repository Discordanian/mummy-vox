extends Node

const CONFIGFILE: String = "user://config.ini"
var config: ConfigFile = ConfigFile.new()

func _ready():
    if!FileAccess.file_exists(CONFIGFILE):
        config.set_value("audio","SFX_VOLUME", 0.8)
        config.set_value("audio","MAIN_VOLUME", 1.0)
        config.set_value("audio","VOICE_VOLUME", 0.8)
        
        config.set_value("selection", "CHOICE_SELECT", "SIDEA")
        
        config.save(CONFIGFILE)
    else:
        config.load(CONFIGFILE)
        

func set_volume(bus: String, value: float) -> void:
    config.set_value("audio", bus, value)
    config.save(CONFIGFILE)
    
func set_selection(selection: String, value: String) -> void:
    config.set_value("selection", selection, value)
    config.save(CONFIGFILE)
    
func get_volume(bus: String) -> float:
    return config.get_value("audio", bus) as float
    
func get_selection(selection: String) -> String:
    return config.get_value("selection", selection) as String
    
