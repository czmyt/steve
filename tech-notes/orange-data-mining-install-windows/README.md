
# How to install and setup the [Orange Data Mining](https://orangedatamining.com/) software for Windows. -- [Tech Notes](..) -- [Steve Schmidt](/)

1. I recommend using the Portable Orange distribution that requires no explicit installation:
    - Download the Portable Orange zip file.
    - Extract the files from that downloaded zip.
1. Setup the Microsoft SQL Server and PostgreSQL drivers for portable version of Orange Data Miner:
    <br />From a Command Prompt:
    - `cd` into the Orange folder that contains python.exe
    - Run `python -m pip install pymssql psycopg2`
1. Setup Orange Data Miner to read SQLlite databases:
    - Manually add the `Orange3-SQLite3` add-in from within the Orange program.
1. Create copy of the `Orange.lnk` shortcut and place on the Windows Desktop:
    - Change the Startup Directory in the shortcut to the Orange folder.

© 2025 Stephen Schmidt.  All rights reserved.
<br />These [Terms and Conditions](/terms-and-conditions) are incorporated herein.
