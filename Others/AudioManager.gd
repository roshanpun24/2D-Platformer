extends Node
var dic : Dictionary ={}
func play_sfx(audio_clip:AudioStream,priority:int = 0):
	for child in $sfx.get_children():
		child.stream = audio_clip
		child.play()
		dic[child.name] =priority
		break
		if child.get_index()==$sfx.get_child_count()-1:
			var priority_player = check_priority(dic,priority)
			if priority_player != null:
				$sfx.get_node(priority_player).stream = audio_clip
				$sfx.get_node(priority_player).play()
				dic[priority_player] = priority
		
func check_priority(dic,priority):
	var prio_list : Array = []
	for key in dic:
		if priority>dic[key]:
			prio_list.append(key)
	
	var last_prio = null
	for key in prio_list:
		if last_prio==null:
			last_prio=key
			continue
		if dic[key] <dic[last_prio]:
			last_prio = key
		return last_prio
		
func play_music(music_clip:AudioStream):
	$Music/Music_Player.set_stream(music_clip)
	$Music/Music_Player.play()
