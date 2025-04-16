
# How to update much of the software on a Windows computer.

By [Steve Schmidt (steve@czmyt.com)](mailto:steve@czmyt.com).

- Check for `Windows Updates` in Settings.
- Update other software through Windows Terminal: Run
    ```Batchfile
    winget update --all
    ``` 
- Check for updates within PortableApps.
    - Occasionally, check for new apps using `Get new apps by title`.
- Run `Get Updates` in Microsoft Store app.
- Run update commands in Linux shell:
    ```Shell
    time (time sudo apt -y update && time sudo apt -y upgrade)
    ```

Go back to the [Tech Notes, Tips, and Tips](README.md) main page.

Copyright 2025 Stephen Schmidt.  All rights reserved.
