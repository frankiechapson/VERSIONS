
/*============================================================================================*/

create or replace function F_GET_VERSION ( I_STRING in varchar2 ) return varchar2 is
    V_S     integer := instr( upper( I_STRING ), '#VER:', 1  , 1 ) + 5;
    V_E     integer := instr( I_STRING         , '#'    , V_S, 1 );
begin
    return substr( I_STRING, V_S, V_E - V_S );
end;
/

/*============================================================================================*/

create or replace view OBJECT_VERSIONS_VW as
select name      , type      , F_GET_VERSION( text     ) as version from user_source       where upper( text     ) like '%#VER:%#%'
union all
select table_name, table_type, F_GET_VERSION( comments )            from user_tab_comments where upper( comments ) like '%#VER:%#%'
union all
select view_name , 'VIEW'    , F_GET_VERSION( DBMS_METADATA.GET_DDL( 'VIEW', view_name) ) from user_views 
;

/*============================================================================================*/

create or replace view OBJECT_VERSION_SHORT_VW as
select NAME, TYPE, VERSION           
  from ( select NAME, TYPE, VERSION, count(*) from ( select * from OBJECT_VERSIONS_VW ) 
          group by NAME, TYPE, VERSION
         having VERSION is not null and NAME != 'OBJECT_VERSIONS_VW'
       );

/*============================================================================================*/

