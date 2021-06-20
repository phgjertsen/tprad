BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TPRAD_BRETT CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

--------------------------------------------------------------------------------

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TPRAD_RESULTAT_LISTE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_NULLSTILL_BRETT';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_SKRIV_UT_BRETT';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_SJEKK_VINNER';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_SPILL';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_SPILL_BRETT_TREKK';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_NULLSTILL_RESULTAT_LISTE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP PROCEDURE TPRAD_SKRIV_UT_RESULTAT_LISTE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4043 THEN
      RAISE;
    END IF;
END;
/

--------------------------------------------------------------------------------

