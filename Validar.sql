--Nome: Rodrigo Paes Morales RM:560209 Turma: 2TDSPA
--Nome: Ruan Nunes Gaspar RM:559567 Turma: 2TDSPA
--Nome: Fernando Nachtigall Tessmann RM:559617 Turma: 2TDSPR

--Função 1 - Validar CPF
CREATE OR REPLACE FUNCTION fn_validate_cpf(p_cpf VARCHAR2)
RETURN BOOLEAN
IS
BEGIN
    -- Verifica se está vazio
    IF p_cpf IS NULL OR TRIM(p_cpf) = '' THEN
        RETURN FALSE;
    END IF;

    -- Verifica tamanho (ex: 000.000.000-00 = 14 caracteres)
    IF LENGTH(p_cpf) != 14 THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END;
/
-- Teste
DECLARE
    v_ok BOOLEAN;
BEGIN
    v_ok := fn_validate_cpf('123.456.789-10');

    IF v_ok THEN
        DBMS_OUTPUT.PUT_LINE('CPF válido!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('CPF inválido!');
    END IF;
END;
/

--Função 2 - Validar Cargo
CREATE OR REPLACE FUNCTION fn_validate_role(p_role VARCHAR2)
RETURN BOOLEAN
IS
BEGIN
    IF p_role IN ('ADMIN', 'USER', 'MANAGER') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/
-- Teste
DECLARE
    v_ok BOOLEAN;
BEGIN
    v_ok := fn_validate_role('ADMIN');

    IF v_ok THEN
        DBMS_OUTPUT.PUT_LINE('Cargo válido!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cargo inválido!');
    END IF;
END;
/
DROP FUNCTION fn_validate_cpf;
/
DROP FUNCTION fn_validate_role;
/
