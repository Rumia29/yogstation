//Speech verbs.
/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	message = pretty_filter(message)
	log_say("[name] : [message]")
	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return
	usr.say(message)





/mob/verb/whisper(message as text)
	set name = "Whisper"
	set category = "IC"
	message = pretty_filter(message)
	log_whisper("[name] : [message]")
	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return
	say(message) //only carbons actually whisper, everything else just talks





/mob/verb/me_verb(message as text)
	set name = "Me"
	set category = "IC"

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return

	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	usr.emote("me",1,message)


/mob/proc/say_dead(var/message)
	var/name = real_name
	var/alt_name = ""
	message = pretty_filter(message)
	log_say("[name] : [message]")

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "<span class='danger'>Speech is currently admin-disabled.</span>"
		return

	var/mob/dead/observer/O = src
	if(isobserver(src) && O.deadchat_name)
		name = "[O.deadchat_name]"
	else
		if(mind && mind.name)
			name = "[mind.name]"
		else
			name = real_name
		if(name != real_name)
			alt_name = " (died as [real_name])"

	var/K

	if(key)
		K = src.key

	message = src.say_quote(message, get_spans())
	var/rendered = "<span class='game deadsay'><span class='prefix'>DEAD:</span> <span class='name'>[name]</span>[alt_name] <span class='message'>[message]</span></span>"

	deadchat_broadcast(rendered, follow_target = src, speaker_key = K)

/mob/proc/emote(var/act)
	return

/mob/proc/hivecheck()
	return 0

/mob/proc/lingcheck()
	return 0
