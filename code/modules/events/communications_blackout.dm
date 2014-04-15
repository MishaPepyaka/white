/datum/event/communications_blackout/announce()
	var/alert = pick(	"���������� ����������� ��������. ��������� ��������� ���� �������������������� ������. ����������, ��������� � �����...*%fj00)`5vc-����", \
						"���������� ����������� ��������. ��������� ��������� ���� ���������*3mga;b4;'1v�-����", \
						"���������� ����������� ��������. ��������� ����#MCi46:5.;@63-������", \
						"���������� ����������� ���'fZ\\kg5_0-���������", \
						"���������� �%� MCayj^j<.3-������������", \
						"#4nd%;f4y6,>�%-����������������")

	for(var/mob/living/silicon/ai/A in player_list)	//AIs are always aware of communication blackouts.
		A << "<br>"
		A << "<span class='warning'><b>[alert]</b></span>"
		A << "<br>"

	if(prob(30))	//most of the time, we don't want an announcement, so as to allow AIs to fake blackouts.
		command_alert(alert)


/datum/event/communications_blackout/start()
	for(var/obj/machinery/telecomms/T in telecomms_list)
		T.emp_act(1)