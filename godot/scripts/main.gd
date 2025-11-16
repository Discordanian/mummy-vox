extends Control

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var VOICE_BUS_ID = AudioServer.get_bus_index("Voice")
@onready var MAIN_BUS_ID = AudioServer.get_bus_index("Master")

@export var select_a: CheckBox
@export var select_b: CheckBox
@export var select_ab: CheckBox

@export var sfx_player: AudioStreamPlayer
@export var vox_player: AudioStreamPlayer

@export var mummy: TextureRect
@export var mummy_player: AnimationPlayer

var sidea_tracks: Array[AudioStreamWAV]
var sideb_tracks: Array[AudioStreamWAV]

func config_selected() -> void:
    var selected: String = ConfigManager.get_selection("CHOICE_SELECT")
    if selected == "SIDEA":
        select_a.set_pressed_no_signal(true)
        return
    if selected == "SIDEB":
        select_b.set_pressed_no_signal(true)
        return
    if selected == "SIDEAB":
        select_ab.set_pressed_no_signal(true)
        return
    push_warning("Unknown selected ", selected)

func setup_audio_bus() -> void:
    var value: float = float(ConfigManager.get_volume("SFX_VOLUME"))
    AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05) 
    
    value = float(ConfigManager.get_volume("VOICE_VOLUME"))
    AudioServer.set_bus_volume_db(VOICE_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(VOICE_BUS_ID, value < 0.05) 
    
    value = float(ConfigManager.get_volume("MAIN_VOLUME"))
    AudioServer.set_bus_volume_db(MAIN_BUS_ID, linear_to_db(value))
    AudioServer.set_bus_mute(MAIN_BUS_ID, value < 0.05) 
       

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    setup_tracks()
    config_selected()
    setup_audio_bus()

func get_stream_array(directory: String) -> Array[AudioStreamWAV]:
    var retval: Array[AudioStreamWAV] = []
    var dir: DirAccess = DirAccess.open(directory)
    if dir:
        dir.list_dir_begin()
        var file_name: String = dir.get_next()
        while file_name != "":
            var full_path: String = directory + file_name
            var audio_stream: AudioStreamWAV = load(full_path)
            if audio_stream:
                retval.append(audio_stream)
            file_name = dir.get_next()
        dir.list_dir_end()
    else:
        push_error("Unabled to open Music Directory: ", directory)
    return retval

func setup_tracks() -> void:
    var voxA_dir = "res://assets/audio/SideA/"
    var voxB_dir = "res://assets/audio/SideB/"
    sidea_tracks = get_stream_array(voxA_dir)
    sideb_tracks = get_stream_array(voxB_dir)
    print("SIDE A ", sidea_tracks.size())
    print("SIDE B ", sideb_tracks.size())    
    

func _on_side_toggled(toggled_on: bool, selection: String) -> void:
    if toggled_on:
        ConfigManager.set_selection("CHOICE_SELECT", selection)
        print("Saving CHOICE_SELECT ", selection)
        sfx_player.play()


func _on_vox_player_finished() -> void:
    mummy_player.play("Fadeout")
    # ummy.self_modulate.a = 0


func _on_speak_button_button_down() -> void:
    var side: String = ConfigManager.get_selection("CHOICE_SELECT")
    if side == "SIDEAB":
        side = ["SIDEA", "SIDEB"].pick_random()
    if side == "SIDEA":
        vox_player.stream = sidea_tracks.pick_random()
    if side == "SIDEB":
        vox_player.stream = sideb_tracks.pick_random()
    print("Playing random track from ", side)
    mummy_player.play("Fadein")
    vox_player.play()


func _on_settings_button_button_down() -> void:
    get_tree().change_scene_to_file("res://scenes/settings.tscn")
