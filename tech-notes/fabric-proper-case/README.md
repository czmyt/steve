
# Microsoft Fabric Transact-SQL function to proper case a string. -- [Tech Notes](..) -- [Steve Schmidt](/)

[View this page on GitHub](https://github.com/czmyt/steve/blob/main/tech-notes/fabric-proper-case/README.md)
to see the script with syntax highlighting and without formatting problems.

```tsql
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER function [dbo].[Proper Case]
	(
	@In varchar(max)
	)
returns
	varchar(max)
with
	returns null on null input
as
	begin
	/*
	A proper case function that will run in all contexts within Microsoft
	Fabric Lakehouses, Warehouses, and SQL Databases.

	Alphabetic characters that follow spaces and dashes are convered to
	capital letters and all other alphabetics are converted to small letters.

	The usual algorithm that employs a simple finite state machine and
	examines the input string character by character will not run in most
	meaningful Fabric contexts, such as wrapped around a column in a
	SELECT statement.  This version works around that limitation but with
	a performance penalty.

	This function is marked CC0 1.0, meaning it is in public domain.
	See https://creativecommons.org/publicdomain/zero/1.0/ for details.
	*/
	return
		substring(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		replace(replace(
		' ' + lower(@In collate Latin1_General_BIN),
		' a', ' A'), '-a', '-A'),
		' b', ' B'), '-b', '-B'),
		' c', ' C'), '-c', '-C'),
		' d', ' D'), '-d', '-D'),
		' e', ' E'), '-e', '-E'),
		' f', ' F'), '-f', '-F'),
		' g', ' G'), '-g', '-G'),
		' h', ' H'), '-h', '-H'),
		' i', ' I'), '-i', '-I'),
		' j', ' J'), '-j', '-J'),
		' k', ' K'), '-k', '-K'),
		' l', ' L'), '-l', '-L'),
		' m', ' M'), '-m', '-M'),
		' n', ' N'), '-n', '-N'),
		' o', ' O'), '-o', '-O'),
		' p', ' P'), '-p', '-P'),
		' q', ' Q'), '-q', '-Q'),
		' r', ' R'), '-r', '-R'),
		' s', ' S'), '-s', '-S'),
		' t', ' T'), '-t', '-T'),
		' u', ' U'), '-u', '-U'),
		' v', ' V'), '-v', '-V'),
		' w', ' W'), '-w', '-W'),
		' x', ' X'), '-x', '-X'),
		' y', ' Y'), '-y', '-Y'),
		' z', ' Z'), '-z', '-Z'),
		2)
	end
GO

ALTER AUTHORIZATION ON [dbo].[Proper Case] TO SCHEMA OWNER
GO
```
