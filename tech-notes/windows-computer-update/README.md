
# How to update much of the software on a Windows computer. -- [Tech Notes](..) -- [Steve Schmidt](/)

1. Check for `Windows Updates` in Settings.
1. Update other software through Windows Terminal: Run
    ```Batchfile
    winget update --all
    ``` 
1. Check for updates within PortableApps.
    - Occasionally, check for new apps using `Get new apps by title`.
1. Run `Get Updates` in Microsoft Store app.
1. Run update commands in Linux shell:
    ```Shell
    time (time sudo apt -y update && time sudo apt -y upgrade)
    ```

© 2025 Stephen Schmidt.  All rights reserved.
<br />[Terms and Conditions](/terms-and-conditions) incorporated herein.
