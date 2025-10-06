extends CanvasLayer

var menu_shown = false
signal helvetica_theme
signal pixel_theme
signal lvl2
signal lvl1
signal diff_chng(new_difficulty)

var white_settings = load("res://art/white_settings_icon.png")
var black_settings = load("res://art/settings_icon.png")

func _ready():
	$Menus.hide()
	$SettingsIcon.show()

func menu_toggle():
	if menu_shown == false:
		$Menus.show()
		$Menus/Accessibility.hide()
		$Menus/Difficulty.hide()
		$Menus/Levels.hide()
		$Menus/BaseMenu.show()
		
		$SettingsIcon.hide()
		menu_shown = true
	else:
		$Menus.hide()
		$SettingsIcon.show()
		menu_shown = false

func go_back():
	if menu_shown:
		$Menus/Accessibility.hide()
		$Menus/Difficulty.hide()
		$Menus/Levels.hide()
		$Menus/BaseMenu.show()
		
func levels():
	if menu_shown:
		$Menus/BaseMenu.hide()
		$Menus/Levels.show()
 
func difficulty():
	if menu_shown:
		$Menus/BaseMenu.hide()
		$Menus/Difficulty.show()

func accessibility():
	if menu_shown:
		$Menus/BaseMenu.hide()
		$Menus/Accessibility.show()
		
func simple_theme(yes_theme):
	if yes_theme:
		helvetica_theme.emit()
		var new_theme = load("res://simple-font-theme.tres")
		
		$Menus/BaseMenu/Label.theme = new_theme
		$Menus/BaseMenu/Levels.theme = new_theme
		$Menus/BaseMenu/Difficulty.theme = new_theme
		$Menus/BaseMenu/Accessibility.theme = new_theme
		
		$Menus/Levels/Label.theme = new_theme
		$Menus/Levels/Lvl1.theme = new_theme
		$Menus/Levels/Lvl2.theme = new_theme
		
		$Menus/Difficulty/Label.theme = new_theme
		$Menus/Difficulty/Easy.theme = new_theme
		$Menus/Difficulty/Medium.theme = new_theme
		$Menus/Difficulty/Hard.theme = new_theme
		
		$Menus/Accessibility/Label.theme = new_theme
		$Menus/Accessibility/SimpleFont.theme = new_theme
		
		$Menus/LeaveOptions/Back.theme = new_theme
		$Menus/LeaveOptions/Exit.theme = new_theme
	else:
		pixel_theme.emit()
		var new_theme = load("res://creeps-theme.tres")
		
		$Menus/BaseMenu/Label.theme = new_theme
		$Menus/BaseMenu/Levels.theme = new_theme
		$Menus/BaseMenu/Difficulty.theme = new_theme
		$Menus/BaseMenu/Accessibility.theme = new_theme
		
		$Menus/Levels/Label.theme = new_theme
		$Menus/Levels/Lvl1.theme = new_theme
		$Menus/Levels/Lvl2.theme = new_theme
		
		$Menus/Difficulty/Label.theme = new_theme
		$Menus/Difficulty/Easy.theme = new_theme
		$Menus/Difficulty/Medium.theme = new_theme
		$Menus/Difficulty/Hard.theme = new_theme
		
		$Menus/Accessibility/Label.theme = new_theme
		$Menus/Accessibility/SimpleFont.theme = new_theme
		
		$Menus/LeaveOptions/Back.theme = new_theme
		$Menus/LeaveOptions/Exit.theme = new_theme

func show_icon():
	$SettingsIcon.show()

func hide_icon():
	$SettingsIcon.hide()

func lvl_2():
	lvl2.emit()
	$SettingsIcon.texture_normal = white_settings

func lvl_1():
	lvl1.emit()
	$SettingsIcon.texture_normal = black_settings
	
func change_difficulty(new_difficulty):
	diff_chng.emit(new_difficulty)
