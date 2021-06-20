BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE tprad_brett CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

--------------------------------------------------------------------------------

CREATE TABLE tprad_brett
(
  rad  INTEGER                                  NOT NULL,
  a    VARCHAR2(1 BYTE),
  b    VARCHAR2(1 BYTE),
  c    VARCHAR2(1 BYTE)
)
TABLESPACE users
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
