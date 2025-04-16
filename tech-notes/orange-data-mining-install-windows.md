
# Procedure to install / configure the [Orange Data Mining](https://orangedatamining.com/) software for Windows.

By [Steve Schmidt (steve@czmyt.com)](mailto:steve@czmyt.com).

1. I recommend using the Portable Orange distribution that requires no explicit installation:
    - Download the Portable Orange zip file.
    - Extract the files from that downloaded zip.
1. Setup the Microsoft SQL Server and PostgreSQL drivers for portable version of Orange Data Miner:
    - From a Command Prompt, `cd` into the Orange folder that contains python.exe and run:
        `python -m pip install pymssql psycopg2`
1. Setup Orange Data Miner to read SQLlite databases:
    - Manually add the Orange3-SQLite3 add-in from within the Orange program.
1. Create copy of the `Orange.lnk` shortcut and place on the Windows Desktop:
    - Change the Startup Directory in the shortcut to the Orange folder.

Copyright 2025 Stephen Schmidt.  All rights reserved.
