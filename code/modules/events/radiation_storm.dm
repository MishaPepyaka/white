/datum/event/radiation_storm
	announceWhen	= 1
	oneShot			= 1


/datum/event/radiation_storm/announce()
	// Don't do anything, we want to pack the announcement with the actual event

/datum/event/radiation_storm/start()
	spawn()
		world << sound('sound/AI/radiation.ogg')
		command_alert("������������� ������� ������ ������������� ��������� ������ �������. ����������, ������������� � ���� �� �������������� ����������� ��������.", "���������&#255; �������")
		make_maint_all_access()


		sleep(600)


		command_alert("������� ����� � ������������ ����. ����������, �� ��������� �������������� ���� �� ��� ���, ���� ������� �� ������� ������������ ����.", "���������&#255; �������" )

		for(var/i = 0, i < 10, i++)
			for(var/mob/living/carbon/human/H in living_mob_list)
				var/turf/T = get_turf(H)
				if(!T)
					continue
				if(T.z != 1)
					continue
				if(istype(T.loc, /area/maintenance) || istype(T.loc, /area/crew_quarters))
					continue

				if(istype(H,/mob/living/carbon/human))
					H.apply_effect((rand(15,35)),IRRADIATE,0)
					if(prob(5))
						H.apply_effect((rand(40,70)),IRRADIATE,0)
						if (prob(75))
							randmutb(H) // Applies bad mutation
							domutcheck(H,null,1)
						else
							randmutg(H) // Applies good mutation
							domutcheck(H,null,1)


			for(var/mob/living/carbon/monkey/M in living_mob_list)
				var/turf/T = get_turf(M)
				if(!T)
					continue
				if(T.z != 1)
					continue
				M.apply_effect((rand(5,25)),IRRADIATE,0)
			sleep(100)


		command_alert("������� ������ ������������ ����. ����������, ���������� � ��������, ���� �� ���������� � ���� ��������� ��������. ������ � ���������� ����� ������� �� ��������� �������� � ���������� �����.", "���������&#255; �������")


		sleep(600) // Want to give them time to get out of maintenance.


		revoke_maint_all_access()
