/datum/event/blob
	announceWhen	= 12
	endWhen			= 120

	var/obj/effect/blob/core/Blob


/datum/event/blob/announce()
	command_alert("������������ ��������� ������������� ������ 7-��� ������ �� ����� ������� [station_name()]. ���� �������� ������� ������ ����������� � ���������� ���������.", "������������&#255; �������")
	world << sound('sound/AI/outbreak7.ogg')


/datum/event/blob/start()
	var/turf/T = pick(blobstart)
	if(!T)
		kill()
		return
	Blob = new /obj/effect/blob/core(T, 200)
	for(var/i = 1; i < rand(3, 6), i++)
		Blob.process()


/datum/event/blob/tick()
	if(!Blob)
		kill()
		return
	if(IsMultiple(activeFor, 3))
		Blob.process()