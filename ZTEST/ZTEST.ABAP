REPORT ztest.

PARAMETERS p_name TYPE string.
PARAMETERS p_werks TYPE werks_d DEFAULT '1000' OBLIGATORY.

DATA: lt_materials TYPE TABLE OF mara,
      lt_descriptions TYPE TABLE OF makt,
      ls_material TYPE mara,
      ls_description TYPE makt.

START-OF-SELECTION.
  WRITE: / 'Name:', p_name.

  SELECT matnr
    INTO TABLE lt_materials
    FROM mara
    WHERE werks = p_werks.

  IF lt_materials IS NOT INITIAL.
    SELECT matnr maktx
      INTO TABLE lt_descriptions
      FROM makt
      FOR ALL ENTRIES IN lt_materials
      WHERE matnr = lt_materials-matnr
      AND spras = sy-langu.

    LOOP AT lt_descriptions INTO ls_description.
      WRITE: / 'Material Number:', ls_description-matnr,
             / 'Description:', ls_description-maktx.
    ENDLOOP.
  ELSE.
    WRITE: / 'No materials found for factory:', p_werks.
  ENDIF.