
-- A SQL Server Transact-SQL script to infer the primary keys of and foreign key relationships among the tables in a database based upon the data in the tables.

-- Copyright 2026 Stephen Schmidt.  All rights reserved.
-- Contents of https://steve.czmyt.com/terms-and-conditions incorporated herein.

-- Columns being examined for key status.
create table [#columns]
    (
    [ID] smallint not null,
    [Schema] nvarchar(128) not null,
    [Table] nvarchar(128) not null,
    [Column] nvarchar(128) not null
    )

-- Hashed values of data in columns being examined.
create table [#values]
    (
    [Column ID] smallint not null,
    [Hash] binary(64) not null,
    [Count] int not null
    )

-- Cursor to retrieve set of columns to be examined.
declare
    [columns cursor]
cursor for select
    [c].[TABLE_SCHEMA],
    [c].[TABLE_NAME],
    [c].[COLUMN_NAME]
from
        [INFORMATION_SCHEMA].[COLUMNS] as [c]
    join
        [INFORMATION_SCHEMA].[TABLES] as [t] on
                [t].[TABLE_CATALOG] = [c].[TABLE_CATALOG]
            and
                [t].[TABLE_SCHEMA] = [c].[TABLE_SCHEMA]
            and
                [t].[TABLE_NAME] = [c].[TABLE_NAME]
where
        [t].[TABLE_TYPE] = 'BASE TABLE'
    and
        -- Ignore any tables whose name begins with a numeric digit as they are usually snapshots or temporary tables.
        [c].[TABLE_NAME] like '[A-Z]%'
    and
        -- Assume that primary and foreign key columns are of one of the following types:
        [c].[DATA_TYPE] in ('bigint', 'binary', 'char', 'int', 'nchar', 'ntext', 'nvarchar', 'text', 'uniqueidentifier', 'varbinary', 'varchar')
    and
        -- Salesforce-specific exclusions.
        [c].[COLUMN_NAME] not in ('CreatedById', 'Language', 'LastModifiedById', 'SortOrder')
    -- Legacy system-specific exclusions.
    and
        [c].[TABLE_NAME] not like '% Changes %'
    and
        [c].[TABLE_NAME] not like '% Out'
    and
        [c].[COLUMN_NAME] not like 'inserted %'
    and
        [c].[COLUMN_NAME] not like 'updated %'
order by
    [TABLE_SCHEMA],
    [TABLE_NAME],
    [ORDINAL_POSITION]



-- Hash and count the values in each of the columns selected for examination.
declare
    @schema nvarchar(128),
    @table nvarchar(128),
    @column nvarchar(128),
    @column_id smallint
select
    @column_id = 0

open [columns cursor]

while 1 = 1
    begin
    fetch next from
        [columns cursor]
    into
        @schema,
        @table,
        @column

    if @@fetch_status != 0
        break

    select @column_id = @column_id + 1

    insert into
        [#columns]
    values
        (
        @column_id,
        @schema,
        @table,
        @column
        )

    -- Note: Would ideally prefer a better method of producing a hash that takes into account the collation sequence
    -- in effect on the columns being examined than using "upper" to provide case insensitivity.
    declare @sql varchar(4000)
    select @sql = '
        insert into
            [#values]
        select
            ' + cast(@column_id as varchar(6)) + ',
            [Hash],
		    count(*)
	    from
		    (
		    select
			    hashbytes(''SHA2_512'', upper(cast([' + @column + '] as varchar(max)))) as [Hash]
 		    from
			    [' + @schema + '].[' + @table + ']
		    where
			    [' + @column + '] is not null
		    ) as [t]
	    group by
		    [Hash]
        '
    exec (@sql)
-- Uncomment for quick testing purposes:
--if @column_id >= 256 break
    end

close [columns cursor]
deallocate [columns cursor]



-- Generate statistics on number of non-null values and number of unique values in each column.
select
    [s].[Column ID],
    [s].[Uniq Count],
    [s].[Value Count],
    [c].[Schema],
    [c].[Table],
    [c].[Column]
into
    [#stats]
from
        (
        select
	        [Column ID],
            -- Count of unique non-null values:
	        count(*) as [Uniq Count],
            -- Count of non-null values:
	        sum([Count]) as [Value Count]
        from
	        [#values]
        group by
	        [Column ID]
        ) as [s]
    join
        [#columns] as [c] on
            [c].[ID] = [s].[Column ID]



-- Determine potential primary key / foreign key combinations.
select
    [p].[Schema] as [PK Schema],
    [p].[Table] as [PK Table],
    [p].[Column] as [PK Column],

    [f].[Schema] as [FK Schema],
    [f].[Table] as [FK Table],
    [f].[Column] as [FK Column],

    [p].[Uniq Count] as [PK Count],
    [t].[PK Count] as [PK Used],
    [t].[FK Count]
into
    [#merge]
from
        (
        -- Count the number of matches that each combination of columns has in common.
        select
	        [p].[Column ID] as [PK ID],
	        [f].[Column ID] as [FK ID],
	        sum([p].[Count]) as [PK Count],
	        sum([f].[Count]) as [FK Count]
        from
		        [#values] as [p]
	        join
		        [#values] as [f] on
				        [f].[Hash] = [p].[Hash]
			        and
				        [f].[Column ID] != [p].[Column ID]
        group by
	        [p].[Column ID],
	        [f].[Column ID]
        ) as [t]
    join
        [#stats] as [p] on
            [p].[Column ID] = [t].[PK ID]
    join
        [#stats] as [f] on
            [f].[Column ID] = [t].[FK ID]
where
        -- The primary keys are those columns whose non-null values are unique among all rows.
        [p].[Uniq Count] = [p].[Value Count]
    and
        -- The foreign keys are those columns whose non-null values are a subset of the values in the primary key column.
        -- i.e. there are no values in the foreign key column for which there is not a match in the primary key column.
        [f].[Uniq Count] = [t].[PK Count]



-- Retrieve and display results of analysis.
select
	*
from
	[#merge]
order by
	[PK Schema],
	[PK Table],
	[PK Column],
	[FK Schema],
	[FK Table],
	[FK Column]



drop table [#merge]
drop table [#stats]
drop table [#values]
drop table [#columns]
