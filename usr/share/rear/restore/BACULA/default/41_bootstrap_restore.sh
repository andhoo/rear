### Restore from bacula by using an existing bootstrap file
###


if [[ "$BEXTRACT_DEVICE" && "$BEXTRACT_BOOTSTRAP" ]]; then


    ### Bacula support using bextract and vchanger device
    LogPrint "
The system is now ready to restore from Bacula. bextract will be started for
you to restore the required files. It's assumed that you know what is
necessary to restore - typically it will be a full backup.

Do not exit 'bextract' until all files are restored.

WARNING: The new root is mounted under '/mnt/local'.
"
    read -p "Press ENTER to start bextract" 2>&1

    bextract -b$BEXTRACT_BOOTSTRAP $BEXTRACT_DEVICE /mnt/local

    LogPrint "
Please verify that the backup has been restored correctly to '/mnt/local'
in the provided shell. When finished, type exit in the shell to continue
recovery.
"
    rear_shell "Did the backup successfully restore to '/mnt/local' ? Ready to continue ?" \

fi

# continue with next script
