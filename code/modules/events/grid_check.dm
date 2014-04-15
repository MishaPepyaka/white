/datum/event/grid_check	//NOTE: Times are measured in master controller ticks!
	announceWhen		= 5

/datum/event/grid_check/setup()
	endWhen = rand(30,120)

/datum/event/grid_check/start()
	power_failure(0)

/datum/event/grid_check/announce()
	command_alert("������������� ���������� ���������� � ������������� ���� ������� [station_name()]. � �������� ���� ����������������, ������� ������� ����� ��������� �� �������������� ����.", "�������������&#255; �������� �����������")
	for(var/mob/M in player_list)
		M << sound('sound/AI/poweroff.ogg')

/datum/event/grid_check/end()
	power_restore()
