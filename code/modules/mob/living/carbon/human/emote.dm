/mob/living/carbon/human/emote(var/act,var/m_type=1,var/message = null)
	var/param = null

	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	if(findtext(act,"s",-1) && !findtext(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext(act,1,length(act))

	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)
	//var/m_type = 1

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	if(src.stat == 2.0 && (act != "deathgasp"))
		return
	switch(act)
		if ("airguitar")
			if (!src.restrained())
				message = "<B>[src]</B> is strumming the air and headbanging like a safari chimp."
				m_type = 1

		if ("blink")
			message = "<B>[src]</B> blinks."
			m_type = 1

		if ("blink_r")
			message = "<B>[src]</B> blinks rapidly."
			m_type = 1

		if ("bow")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null

				if (param)
					message = "<B>[src]</B> bows to [param]."
				else
					message = "<B>[src]</B> bows."
			m_type = 1

		if ("custom")
			var/input = copytext(sanitize(input("Choose an emote to display.") as text|null),1,MAX_MESSAGE_LEN)
			if (!input)
				return
			var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
			if (input2 == "Visible")
				m_type = 1
			else if (input2 == "Hearable")
				if (src.miming)
					return
				m_type = 2
			else
				alert("Unable to use this emote, must be either hearable or visible.")
				return
			return custom_emote(m_type, message)

		if ("me")
			if(silent)
				return
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "\red You cannot send IC messages (muted)."
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			return custom_emote(m_type, message)

		if ("salute")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null

				if (param)
					message = "<B>[src]</B> salutes to [param]."
				else
					message = "<B>[src]</b> salutes."
			m_type = 1

		if ("choke")
			if(miming)
				message = "<B>[src]</B> clutches his throat desperately!"
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> chokes!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a strong noise."
					m_type = 2

		if ("clap")
			if (!src.restrained())
				message = "<B>[src]</B> claps."
				m_type = 2
				if(miming)
					m_type = 1
		if ("flap")
			if (!src.restrained())
				message = "<B>[src]</B> flaps his wings."
				m_type = 2
				if(miming)
					m_type = 1

		if ("aflap")
			if (!src.restrained())
				message = "<B>[src]</B> flaps his wings ANGRILY!"
				m_type = 2
				if(miming)
					m_type = 1

		if ("drool")
			message = "<B>[src]</B> drools."
			m_type = 1

		if ("eyebrow")
			message = "<B>[src]</B> raises an eyebrow."
			m_type = 1

		if ("chuckle")
			if(miming)
				message = "<B>[src]</B> appears to chuckle."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> chuckles."
					m_type = 2
				else
					message = "<B>[src]</B> makes a noise."
					m_type = 2

		if ("twitch")
			message = "<B>[src]</B> twitches violently."
			m_type = 1

		if ("twitch_s")
			message = "<B>[src]</B> twitches."
			m_type = 1

		if ("faint")
			message = "<B>[src]</B> faints."
			if(src.sleeping)
				return //Can't faint while asleep
			src.sleeping += 10 //Short-short nap
			m_type = 1

		if ("cough")
			if(miming)
				message = "<B>[src]</B> appears to cough!"
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> coughs!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a strong noise."
					m_type = 2

		if ("frown")
			message = "<B>[src]</B> frowns."
			m_type = 1

		if ("nod")
			message = "<B>[src]</B> nods."
			m_type = 1

		if ("blush")
			message = "<B>[src]</B> blushes."
			m_type = 1

		if ("wave")
			message = "<B>[src]</B> waves."
			m_type = 1

		if ("gasp")
			if(miming)
				message = "<B>[src]</B> appears to be gasping!"
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> gasps!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = 2

		if ("deathgasp")
			message = "<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless..."
			m_type = 1

		if ("giggle")
			if(miming)
				message = "<B>[src]</B> giggles silently!"
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> giggles."
					m_type = 2
				else
					message = "<B>[src]</B> makes a noise."
					m_type = 2

		if ("glare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> glares at [param]."
			else
				message = "<B>[src]</B> glares."

		if ("stare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> stares at [param]."
			else
				message = "<B>[src]</B> stares."

		if ("look")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break

			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> looks at [param]."
			else
				message = "<B>[src]</B> looks."
			m_type = 1

		if ("grin")
			message = "<B>[src]</B> grins."
			m_type = 1

		if ("cry")
			if(miming)
				message = "<B>[src]</B> cries."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> cries."
					m_type = 2
				else
					message = "<B>[src]</B> makes a weak noise. \He frowns."
					m_type = 2

		if ("sigh")
			if(miming)
				message = "<B>[src]</B> sighs."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> sighs."
					m_type = 2
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = 2

		if ("laugh")
			if(miming)
				message = "<B>[src]</B> acts out a laugh."
				m_type = 1
			else
				if (!muzzled)
					if (!ready_to_emote())
						if (world.time % 3)
							usr << "<span class='warning'>You not ready to laugh again!"
					else
						message = "<B>[src]</B> laughs."
						m_type = 2
						call_sound_emote("laugh")
				else
					message = "<B>[src]</B> makes a noise."
					m_type = 2

		if("elaugh")
			if(miming)
				message = "<B>[src]</B> acts out a laugh."
				m_type = 1
			else if (mind.special_role)
				if (!ready_to_elaugh())
					if (world.time % 3)
						usr << "<span class='warning'>You not ready to laugh again!"
				else
					message = "<B>[src]</B> laugh like a true evil! Mu-ha-ha!"
					m_type = 2
					call_sound_emote("elaugh")
			else
				if (!muzzled)
					if (!ready_to_emote())
						if (world.time % 3)
							usr << "<span class='warning'>You not ready to laugh again!"
					else
						message = "<B>[src]</B> laughs."
						m_type = 2
						call_sound_emote("laugh")
				else
					message = "<B>[src]</B> makes a noise."
					m_type = 2

		if ("mumble")
			message = "<B>[src]</B> mumbles!"
			m_type = 2
			if(miming)
				m_type = 1

		if ("grumble")
			if(miming)
				message = "<B>[src]</B> grumbles!"
				m_type = 1
			if (!muzzled)
				message = "<B>[src]</B> grumbles!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("groan")
			if(miming)
				message = "<B>[src]</B> appears to groan!"
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> groans!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a loud noise."
					m_type = 2

		if ("moan")
			if(miming)
				message = "<B>[src]</B> appears to moan!"
				m_type = 1
			else
				message = "<B>[src]</B> moans!"
				m_type = 2

		if ("johnny")
			var/M
			if (param)
				M = param
			if (!M)
				param = null
			else
				if(miming)
					message = "<B>[src]</B> takes a drag from a cigarette and blows \"[M]\" out in smoke."
					m_type = 1
				else
					message = "<B>[src]</B> says, \"[M], please. He had a family.\" [src.name] takes a drag from a cigarette and blows his name out in smoke."
					m_type = 2

		if ("point")
			if (!src.restrained())
				var/mob/M = null
				if (param)
					for (var/atom/A as mob|obj|turf|area in view(null, null))
						if (param == A.name)
							M = A
							break

				if (!M)
					message = "<B>[src]</B> points."
				else
					M.point()

				if (M)
					message = "<B>[src]</B> points to [M]."
				else
			m_type = 1

		if ("raise")
			if (!src.restrained())
				message = "<B>[src]</B> raises a hand."
			m_type = 1

		if("shake")
			message = "<B>[src]</B> shakes \his head."
			m_type = 1

		if ("shrug")
			message = "<B>[src]</B> shrugs."
			m_type = 1

		if ("signal")
			if (!src.restrained())
				var/t1 = round(text2num(param))
				if (isnum(t1))
					if (t1 <= 5 && (!src.r_hand || !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
					else if (t1 <= 10 && (!src.r_hand && !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
			m_type = 1

		if ("smile")
			message = "<B>[src]</B> smiles."
			m_type = 1

		if ("shiver")
			message = "<B>[src]</B> shivers."
			m_type = 2
			if(miming)
				m_type = 1

		if ("pale")
			message = "<B>[src]</B> goes pale for a second."
			m_type = 1

		if ("tremble")
			message = "<B>[src]</B> trembles in fear!"
			m_type = 1

		if ("sneeze")
			if (miming)
				message = "<B>[src]</B> sneezes."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> sneezes."
					m_type = 2
				else
					message = "<B>[src]</B> makes a strange noise."
					m_type = 2

		if ("sniff")
			message = "<B>[src]</B> sniffs."
			m_type = 2
			if(miming)
				m_type = 1

		if ("snore")
			if (miming)
				message = "<B>[src]</B> sleeps soundly."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> snores."
					m_type = 2
				else
					message = "<B>[src]</B> makes a noise."
					m_type = 2

		if ("whimper")
			if (miming)
				message = "<B>[src]</B> appears hurt."
				m_type = 1
			else
				if (!muzzled)
					message = "<B>[src]</B> whimpers."
					m_type = 2
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = 2

		if ("wink")
			message = "<B>[src]</B> winks."
			m_type = 1

		if ("yawn")
			if (!muzzled)
				message = "<B>[src]</B> yawns."
				m_type = 2
				if(miming)
					m_type = 1

		if ("collapse")
			Paralyse(2)
			message = "<B>[src]</B> collapses!"
			m_type = 2
			if(miming)
				m_type = 1

		if("hug")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null

				if (M)
					message = "<B>[src]</B> hugs [M]."
				else
					message = "<B>[src]</B> hugs \himself."

		if ("handshake")
			m_type = 1
			if (!src.restrained() && !src.r_hand)
				var/mob/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null

				if (M)
					if (M.canmove && !M.r_hand && !M.restrained())
						message = "<B>[src]</B> shakes hands with [M]."
					else
						message = "<B>[src]</B> holds out \his hand to [M]."

		if("dap")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M)
					message = "<B>[src]</B> gives daps to [M]."
				else
					message = "<B>[src]</B> sadly can't find anybody to give daps to, and daps \himself. Shameful."

		if ("scream")
			if (miming)
				message = "<B>[src]</B> acts out a scream!"
				m_type = 1
			else
				if (!muzzled)
					if (!ready_to_emote())
						if (world.time % 3)
							usr << "<span class='warning'>You not ready to scream again!"
					else
						message = "<B>[src]</B> screams!"
						m_type = 2
						call_sound_emote("scream")
				else
					message = "<B>[src]</B> makes a very loud noise."
					m_type = 2

		if("fart")
			if (lost_anus >= 1)
				usr << "<span class='warning'>My ass is exploded. Uh-oh..."
				message = ("<B>[src]</B> tried to fart, but he forgot that his butt was exploded!")
			else
				if (fail_farts >= 15 && src.called_superfart < 1)
					anus_bombanull()
					return
				else
//					adjustBrainLoss(1)
					switch(rand(1, 48))
						if(1)
							message = "<B>[src]</B> lets out a girly little 'toot' from \his butt."

						if(2)
							message = "<B>[src]</B> farts loudly!"

						if(3)
							message = "<B>[src]</B> lets one rip!"

						if(4)
							message = "<B>[src]</B> farts! It sounds wet and smells like rotten eggs."

						if(5)
							message = "<B>[src]</B> farts robustly!"

						if(6)
							message = "<B>[src]</B> farted! It reminds you of your grandmother's queefs."

						if(7)
							message = "<B>[src]</B> queefed out \his ass!"

						if(8)
							message = "<B>[src]</B> farted! It reminds you of your grandmother's queefs."

						if(9)
							message = "<B>[src]</B> farts a ten second long fart."

						if(10)
							message = "<B>[src]</B> groans and moans, farting like the world depended on it."

						if(11)
							message = "<B>[src]</B> breaks wind!"

						if(12)
							message = "<B>[src]</B> expels intestinal gas through the anus."

						if(13)
							message = "<B>[src]</B> release an audible discharge of intestinal gas."

						if(14)
							message = "\red <B>[src]</B> is a farting motherfucker!!!"

						if(15)
							message = "\red <B>[src]</B> suffers from flatulence!"

						if(16)
							message = "<B>[src]</B> releases flatus."

						if(17)
							message = "<B>[src]</B> releases gas generated in \his digestive tract, \his stomach and \his intestines. \red<B>It stinks way bad!</B>"

						if(18)
							message = "<B>[src]</B> farts like your mom used to!"

						if(19)
							message = "<B>[src]</B> farts. It smells like Soylent Surprise!"

						if(20)
							message = "<B>[src]</B> farts. It smells like pizza!"

						if(21)
							message = "<B>[src]</B> farts. It smells like George Melons' perfume!"

						if(22)
							message = "<B>[src]</B> farts. It smells like atmos in here now!"

						if(23)
							message = "<B>[src]</B> farts. It smells like medbay in here now!"

						if(24)
							message = "<B>[src]</B> farts. It smells like the bridge in here now!"

						if(25)
							message = "<B>[src]</B> farts like a pubby!"

						if(26)
							message = "<B>[src]</B> farts like a goone!"

						if(27)
							message = "<B>[src]</B> farts so hard he's certain poop came out with it, but dares not find out."

						if(28)
							message = "<B>[src]</B> farts delicately."

						if(29)
							message = "<B>[src]</B> farts timidly."

						if(30)
							message = "<B>[src]</B> farts very, very quietly. The stench is OVERPOWERING."

						if(31)
							message = "<B>[src]</B> farts and says, \"Mmm! Delightful aroma!\""

						if(32)
							message = "<B>[src]</B> farts and says, \"Mmm! Sexy!\""

						if(33)
							message = "<B>[src]</B> farts and fondles \his own buttocks."

						if(34)
							message = "<B>[src]</B> farts and fondles YOUR buttocks."

						if(35)
							message = "<B>[src]</B> fart in he own mouth. A shameful [src]."

						if(36)
							message = "<B>[src]</B> farts out pure plasma! \red<B>FUCK!</B>"

						if(37)
							message = "<B>[src]</B> farts out pure oxygen. What the fuck did he eat?"

						if(38)
							message = "<B>[src]</B> breaks wind noisily!"

						if(39)
							message = "<B>[src]</B> releases gas with the power of the gods! The very station trembles!!"

						if(40)
							message = "<B>[src] \red f \blue a \black r \red t \blue s \black !</B>"

						if(41)
							message = "<B>[src] shat \his pants!</B>"

						if(42)
							message = "<B>[src] shat \his pants!</B> Oh, no, that was just a really nasty fart."

						if(43)
							message = "<B>[src]</B> is a flatulent whore."

						if(44)
							message = "<B>[src]</B> likes the smell of \his own farts."

						if(45)
							message = "<B>[src]</B> doesnt wipe after he poops."

						if(46)
							message = "<B>[src]</B> farts! Now he smells like Tiny Turtle."

						if(47)
							message = "<B>[src]</B> burps! He farted out of \his mouth!! That's Showtime's style, baby."

						if(48)
							message = "<B>[src]</B> laughs! His breath smells like a fart."
					m_type = 1
					call_sound_emote("fart")
					if (!ready_to_emote())
						if (world.time % 3)
							usr << "<span class='warning'>You feeling like your ass cracking. Uh-oh..."
							fail_farts ++



				var/area/A = get_area(src.loc)
				if(A && A.name == "\improper Chapel")
					anus_bombanull()
				for(var/obj/item/weapon/storage/bible/B in src.loc)
					if(B)
						message = "\red <B>[src]</B> farts on the bible and then blows up!"
						src.gib()
						new /obj/item/clothing/head/butt(src.loc)




		if("superfart")
			if(src.lost_anus >= 1)
				src << "\blue You don't have a butt!"
				return
			if(src.called_superfart >= 1)
				return
			else
				called_superfart = 1
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				emote("fart")
				sleep(1)
				message = "<B>[src]</B>'s butt explodes!"
//				new /obj/decal/cleanable/poo(src.loc)
				anus_bombanull()

		if ("help")
			src << "blink, blink_r, blush, bow-(none)/mob, burp, choke, chuckle, clap, collapse, cough,\ncry, custom, deathgasp, drool, eyebrow, frown, gasp, giggle, groan, grumble, handshake, hug-(none)/mob, glare-(none)/mob,\ngrin, laugh, look-(none)/mob, moan, mumble, nod, pale, point-atom, raise, salute, shake, shiver, shrug,\nsigh, signal-#1-10, smile, sneeze, sniff, snore, stare-(none)/mob, tremble, twitch, twitch_s, whimper,\nwink, yawn"

		else
			src << "\blue Unusable emote '[act]'. Say *help for a list."





	if (message)
		log_emote("[name]/[key] : [message]")

 //Hearing gasp and such every five seconds is not good emotes were not global for a reason.
 // Maybe some people are okay with that.

		for(var/mob/M in dead_mob_list)
			if(!M.client || istype(M, /mob/new_player))
				continue //skip monkeys, leavers and new players
			if(M.stat == DEAD && (M.client.prefs.toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message)


		if (m_type & 1)
			for (var/mob/O in get_mobs_in_view(world.view,src))
				O.show_message(message, m_type)
		else if (m_type & 2)
			for (var/mob/O in (hearers(src.loc, null) | get_mobs_in_view(world.view,src)))
				O.show_message(message, m_type)
/mob/living/carbon/human/var/emote_delay = 30
/mob/living/carbon/human/var/elaugh_delay = 600
/mob/living/carbon/human/var/last_emoted = 0
/mob/living/carbon/human/var/fail_farts = 0
/mob/living/carbon/human/var/called_superfart = 0
/mob/living/carbon/human/var/lost_anus = 0

/mob/living/carbon/human/proc/ready_to_emote()
	if(world.time >= last_emoted + emote_delay)
		last_emoted = world.time
		return 1
	else
		return 0

/mob/living/carbon/human/proc/ready_to_elaugh()
	if(world.time >= last_emoted + elaugh_delay)
		last_emoted = world.time
		return 1
	else
		return 0

/mob/living/carbon/human/proc/anus_bombanull()
	lost_anus = 1
	src.Weaken(12)
	flick("e_flash", src.flash)
	new /obj/item/clothing/head/butt(src.loc)
	if (prob(10))
		playsound(world, 'superfart.ogg', 100, 0)
	else
		playsound(src.loc, 'superfart.ogg', 80, 0)
	src.Weaken(12)
	var/datum/organ/external/affecting = src.get_organ("groin")
	if(affecting)
		if(affecting.take_damage(25, 20))
			src.UpdateDamageIcon()
		src.updatehealth()


/mob/living/carbon/human/verb/pose()
	set name = "Set Pose"
	set desc = "Sets a description which will be shown when someone examines you."
	set category = "IC"
	pose =  copytext(sanitize_uni(input(usr, "This is [src]. \He is...", "Pose", null)  as text), 1, MAX_MESSAGE_LEN)

/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavour Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	flavor_text =  copytext(sanitize(input(usr, "Please enter your new flavour text.", "Flavour text", null)  as text), 1)

/mob/living/carbon/human/proc/call_sound_emote(var/E)
	switch(E)
		if("scream")
			if (src.gender == "male")
				playsound(src.loc, pick('sound/voice/Screams_Male_1.ogg', 'sound/voice/Screams_Male_2.ogg', 'sound/voice/Screams_Male_3.ogg'), 100, 1)
			else
				playsound(src.loc, pick('sound/voice/Screams_Woman_1.ogg', 'sound/voice/Screams_Woman_2.ogg', 'sound/voice/Screams_Woman_3.ogg'), 100, 1)

		if("laugh")
			playsound(src.loc, pick('sound/voice/laugh1.ogg', 'sound/voice/laugh2.ogg', 'sound/voice/laugh3.ogg'), 100, 1)

		if("elaugh")
			playsound(src.loc, 'sound/voice/elaugh.ogg', 100, 1)

		if("fart")
			playsound(src.loc, pick('sound/voice/fart.ogg','sound/voice/poo2.ogg','sound/voice/fart1.ogg'), 100, 1)