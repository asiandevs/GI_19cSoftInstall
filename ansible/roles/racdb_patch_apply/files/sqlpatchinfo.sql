SET LINESIZE 500
SET PAGESIZE 1000
SET SERVEROUT ON
SET LONG 2000000

COLUMN action_time FORMAT A12
COLUMN action FORMAT A10
COLUMN bundle_series FORMAT A4 
COLUMN comments FORMAT A30
COLUMN description FORMAT A40
COLUMN namespace FORMAT A20
COLUMN status FORMAT A10
COLUMN version FORMAT A10

SELECT TO_CHAR(action_time, 'YYYY-MM-DD') AS action_time,
 action,
 status,
 description,
 version,
 patch_id,
 bundle_series
 FROM   sys.dba_registry_sqlpatch
 ORDER by action_time;
