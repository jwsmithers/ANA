-- Experiment prefix
--define EXPERIMENT=ATLAS;
define EXPERIMENT=TESTEXP;

-- Data tablespace
define DATA_TS=USERS;
--define DATA_TS=DATA01;

-- Temp tablespace
define TEMP_TS=TEMP;
--define TEMP_TS=TEMP01;

-- Generic reader user
define USER_R_SUFFIX=_COOL_READER
define USER_R=&EXPERIMENT&USER_R_SUFFIX;

-- Password
define PSWD_SUFFIX=_password
define PSWD_R=&USER_R&PSWD_SUFFIX

-- CROSS CHECK!
--select '&EXPERIMENT', '&DATA_TS', '&TEMP_TS', '&USER_R', '&PSWD_R' from DUAL;

/*
--DROP USER &USER_R CASCADE;
--*/

--/*
-- Create generic reader
CREATE USER &USER_R
PROFILE CERN_APP_PROFILE
IDENTIFIED BY &PSWD_R
DEFAULT TABLESPACE &DATA_TS
TEMPORARY TABLESPACE &TEMP_TS
QUOTA 10M ON &DATA_TS;

GRANT CERN_APP_ROLE TO &USER_R;
--*/
