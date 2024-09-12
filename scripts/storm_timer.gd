extends Timer

func delay_storm(time):
	print('dalay_storm')
	#Retrasa el temporizador
	#time_until_storm += time
	stop()
	start()
func advance_storm(time):
	var time_left = get_time_left()
	stop()
	start(time_left-time)
