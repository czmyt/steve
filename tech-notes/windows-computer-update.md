
Return to the [Tech Notes, Tips, and Tips](README.md) main page.

# How to update much of the software on a Windows computer.

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

Copyright 2025 [Stephen Schmidt](https://steve.czmyt.com).  All rights reserved.
