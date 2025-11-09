--Nome: Rodrigo Paes Morales RM:560209 Turma: 2TDSPA
--Nome: Ruan Nunes Gaspar RM:559567 Turma: 2TDSPA
--Nome: Fernando Nachtigall Tessmann RM:559617 Turma: 2TDSPR

-- Tabela para retorno
-- Tipo para representar uma linha do relatório
CREATE OR REPLACE TYPE property_field_row AS OBJECT (
    property_id VARCHAR2(40),
    property_title VARCHAR2(255),
    field_id VARCHAR2(40),
    field_title VARCHAR2(255),
    crop VARCHAR2(255)
);
/
-- Tipo tabela para ser retornado pela função
CREATE OR REPLACE TYPE property_field_table AS TABLE OF property_field_row;
/
CREATE OR REPLACE FUNCTION fn_relatorio_propriedades_campos
RETURN property_field_table
AS
    v_result property_field_table := property_field_table(); -- tabela retorno
BEGIN
    -- Cursor com JOIN entre propriedades e campos
    FOR reg IN (
        SELECT p.id AS property_id,
               p.title AS property_title,
               f.id AS field_id,
               f.title AS field_title,
               f.crop
        FROM tb_properties p
        JOIN tb_fields f ON p.id = f.property_id
        ORDER BY p.title
    ) LOOP
        -- adiciona cada linha no resultado
        v_result.EXTEND;
        v_result(v_result.COUNT) := property_field_row(
            reg.property_id,
            reg.property_title,
            reg.field_id,
            reg.field_title,
            reg.crop
        );
    END LOOP;

    RETURN v_result;
END;
/
-- Teste
SELECT * FROM TABLE(fn_relatorio_propriedades_campos);

--drop functions
DROP FUNCTION fn_relatorio_propriedades_campos;
/
DROP TYPE property_field_table;
/
DROP TYPE property_field_row;
/
