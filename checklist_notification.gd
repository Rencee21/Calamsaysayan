extends Control

@onready var kalanbanga_check = $VBoxContainer/KalanbangaCheck
@onready var rizal_check = $VBoxContainer/RizalCheck
@onready var church_check = $VBoxContainer/ChurchCheck
@onready var ccc_check = $VBoxContainer/CccCheck

func _ready():
	update_checklist()

func update_checklist():
	kalanbanga_check.text = "☐ Kalanbanga Quest"
	rizal_check.text = "☐ Rizal Shrine Quest"
	church_check.text = "☐ St. John Church Quest"
	ccc_check.text = "☐ CCC Quest"

	if GameState.kalanbanga_done:
		kalanbanga_check.text = "✅ Kalanbanga Quest"
	if GameState.rizal_done:
		rizal_check.text = "✅ Rizal Shrine Quest"
	if GameState.church_done:
		church_check.text = "✅ St. John Church Quest"
	if GameState.ccc_done:
		ccc_check.text = "✅ CCC Quest"
