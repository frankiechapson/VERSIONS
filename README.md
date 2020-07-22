# A method to check and to follow the version of Objects in the Schema

## Why?

Because it is very important to know which version is installed from a table, function, type, etc, so from an object in the Schema.

This solution does not substitute other comments or history of changes, but gives a quick overview of object versions.


## How?

Very simple.
Insert a short string into a comment in each source of objects.
The syntax of this comment is the following:

**#Ver:....#**

where "...." can be anyting, practically a version number for example: 3.12
and max a short info about the author, the time and date.
The "ver" is case insensitive.
For tables put this version info into the table comment:

```sql
comment on table  LOGIN_LOG   is 'Log of logins #Ver:1.0#';
```

For stored procedures, functions, packages, triggers, types, views etc put this version info into the source code:

```sql
create or replace procedure P_LOGIN ( I_LOGIN_SCRIPT_CODE in varchar2 ) is
    pragma autonomous_transaction;
/* #Ver:1.0# */
begin               
...
```

## When you modify an object DO NOT FORGET to modify its version info too!


## List of object versions

To check the object versions there is a view: **OBJECT_VERSIONS_VW**<br>
This view returns with the object names, types and its versions.
Unfortunatelly the source of views differ than other objects so it returns with every view name and version despite it is null.
To avoid the listing of views with empty VERSION, use **OBJECT_VERSION_SHORT_VW** view. 

| NAME               | TYPE             | VERSION                 |
| :----------------- | :--------------- | :---------------------- |
| P_LOGIN            | PROCEDURE        | 1.0 by TF 2020.07.22    |
| LOGIN_SCRIPT_LINES | TABLE            | 1.0                     |
| LOGIN_SCRIPTS      | TABLE            | 1.0                     |
| LOGIN_LOG          | TABLE            | 1.0                     |



