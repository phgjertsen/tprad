--------------------------------------------------------------------------------

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE tprad_resultat_liste CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--------------------------------------------------------------------------------

CREATE TABLE tprad_resultat_liste
(
  resultat  VARCHAR2(1 BYTE)
)
TABLESPACE apps_ts_tx_data
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;

--------------------------------------------------------------------------------
