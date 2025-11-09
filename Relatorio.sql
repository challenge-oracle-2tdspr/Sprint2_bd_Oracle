--Nome: Rodrigo Paes Morales RM:560209 Turma: 2TDSPA
--Nome: Ruan Nunes Gaspar RM:559567 Turma: 2TDSPA
--Nome: Fernando Nachtigall Tessmann RM:559617 Turma: 2TDSPR

-- Função para Relatório com Regra de Negócio

-- Objeto para representar uma linha do relatório
CREATE OR REPLACE TYPE property_field_count_row AS OBJECT (
    property_id VARCHAR2(40),
    property_title VARCHAR2(255),
    total_fields NUMBER
);
/

-- Tabela para retornar várias linhas
CREATE OR REPLACE TYPE property_field_count_table AS TABLE OF property_field_count_row;
/
CREATE OR REPLACE FUNCTION fn_relatorio_qtd_campos_por_propriedade
RETURN property_field_count_table
AS
    v_result property_field_count_table := property_field_count_table(); -- tabela retorno
BEGIN
    -- Cursor com JOIN, GROUP BY, COUNT e ORDER BY
    FOR reg IN (
        SELECT 
            p.id AS property_id,
            p.title AS property_title,
            COUNT(f.id) AS total_fields  -- quantidade de campos
        FROM tb_properties p
        JOIN tb_fields f ON p.id = f.property_id
        GROUP BY p.id, p.title          -- necessário para COUNT
        ORDER BY COUNT(f.id) DESC       -- propriedades com mais campos primeiro
    ) LOOP
        -- Adiciona cada linha ao retorno
        v_result.EXTEND;
        v_result(v_result.COUNT) := property_field_count_row(
            reg.property_id,
            reg.property_title,
            reg.total_fields
        );
    END LOOP;

    RETURN v_result;
END;
/
--teste
SELECT * FROM TABLE(fn_relatorio_qtd_campos_por_propriedade);

--drop 
DROP FUNCTION IF EXISTS fn_relatorio_qtd_campos_por_propriedade;
DROP TYPE IF EXISTS property_field_count_table;
DROP TYPE IF EXISTS property_field_count_row;
