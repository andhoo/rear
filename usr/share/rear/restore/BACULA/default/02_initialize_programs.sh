modprobe autofs4
StopIfError "Could not load the autofs4 kernel module!"
automount
StopIfError "Could not start the automounter!"