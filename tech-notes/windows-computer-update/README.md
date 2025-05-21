
# How to update much of the software on a Windows computer. -- [Tech Notes](..) -- [Steve Schmidt](/)

1. Check for `Windows Updates` in Settings.
1. Update installed software using the [Windows Package Manaer](https://learn.microsoft.com/en-us/shows/open-at-microsoft/intro-to-windows-package-manager) `winget` command: Open a Windows Terminal then run:
    ```Batchfile
    winget update --all
    ```
1. Update remaining installed software using [Patch My PC - Home Updater](https://patchmypc.com/product/home-updater).
1. Check for updates within PortableApps.
    - Occasionally, check for new apps using `Get new apps by title`.
1. Run `Get Updates` in Microsoft Store app.
1. Run update commands in Linux shell:
    ```Shell
    time (time sudo apt -y update && time sudo apt -y upgrade)
    ```

© 2025 Stephen Schmidt.  All rights reserved.  [Terms and Conditions](/terms-and-conditions) incorporated herein.
