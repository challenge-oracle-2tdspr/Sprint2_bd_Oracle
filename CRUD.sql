--Nome: Rodrigo Paes Morales RM:560209 Turma: 2TDSPA
--Nome: Ruan Nunes Gaspar RM:559567 Turma: 2TDSPA
--Nome: Fernando Nachtigall Tessmann RM:559617 Turma: 2TDSPR

-- PROCEDURES para TB_USERS
-- insert
CREATE OR REPLACE PROCEDURE sp_insert_user (
    p_id            VARCHAR2,
    p_email         VARCHAR2,
    p_password      VARCHAR2,
    p_cpf           VARCHAR2,
    p_role          VARCHAR2,
    p_first_name    VARCHAR2,
    p_last_name     VARCHAR2,
    p_phone_number  VARCHAR2
)
IS
BEGIN
    -- Validação usando funções criadas
    IF NOT fn_validate_cpf(p_cpf) THEN
        RAISE_APPLICATION_ERROR(-20001, 'CPF inválido.');
    END IF;

    IF NOT fn_validate_role(p_role) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Cargo inválido.');
    END IF;

    INSERT INTO TB_USERS (id, email, password, cpf, role, first_name, last_name, phone_number)
    VALUES (p_id, p_email, p_password, p_cpf, p_role, p_first_name, p_last_name, p_phone_number);

    DBMS_OUTPUT.PUT_LINE('Usuário inserido com sucesso!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Já existe usuário com esse CPF ou e-mail.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usuário: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_user (
    p_id            VARCHAR2,
    p_email         VARCHAR2,
    p_password      VARCHAR2,
    p_cpf           VARCHAR2,
    p_role          VARCHAR2,
    p_first_name    VARCHAR2,
    p_last_name     VARCHAR2,
    p_phone_number  VARCHAR2
)
IS
BEGIN
    -- Validações
    IF NOT fn_validate_cpf(p_cpf) THEN
        RAISE_APPLICATION_ERROR(-20003, 'CPF inválido para atualização.');
    END IF;

    IF NOT fn_validate_role(p_role) THEN
        RAISE_APPLICATION_ERROR(-20004, 'Cargo inválido para atualização.');
    END IF;

    UPDATE TB_USERS
    SET email = p_email,
        password = p_password,
        cpf = p_cpf,
        role = p_role,
        first_name = p_first_name,
        last_name = p_last_name,
        phone_number = p_phone_number,
        updated_at = SYSTIMESTAMP
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Usuário atualizado com sucesso!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar usuário: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_user (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_USERS WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Usuário removido com sucesso!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar usuário: ' || SQLERRM);
END;
/

-- TB_PROPERTIES
--insert
CREATE OR REPLACE PROCEDURE sp_insert_property (
    p_id VARCHAR2,
    p_title VARCHAR2,
    p_description CLOB,
    p_total_area NUMBER,
    p_area_unit VARCHAR2,
    p_address VARCHAR2,
    p_city VARCHAR2,
    p_state VARCHAR2,
    p_country VARCHAR2,
    p_zip_code VARCHAR2,
    p_owner_id VARCHAR2
)
IS
BEGIN
    INSERT INTO TB_PROPERTIES (
        id, title, description, total_area, area_unit, address, city, state,
        country, zip_code, owner_id
    ) 
    VALUES (
        p_id, p_title, p_description, p_total_area, p_area_unit, p_address, 
        p_city, p_state, p_country, p_zip_code, p_owner_id
    );

    DBMS_OUTPUT.PUT_LINE('Propriedade inserida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir propriedade: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_property (
    p_id VARCHAR2,
    p_title VARCHAR2,
    p_description CLOB,
    p_total_area NUMBER,
    p_area_unit VARCHAR2,
    p_address VARCHAR2,
    p_city VARCHAR2,
    p_state VARCHAR2,
    p_country VARCHAR2,
    p_zip_code VARCHAR2,
    p_owner_id VARCHAR2
)
IS
BEGIN
    UPDATE TB_PROPERTIES
    SET title = p_title,
        description = p_description,
        total_area = p_total_area,
        area_unit = p_area_unit,
        address = p_address,
        city = p_city,
        state = p_state,
        country = p_country,
        zip_code = p_zip_code,
        owner_id = p_owner_id,
        updated_at = SYSTIMESTAMP
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Propriedade atualizada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar propriedade: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_property (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_PROPERTIES WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Propriedade removida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao remover propriedade: ' || SQLERRM);
END;
/

-- TB_FIELDS
--insert
CREATE OR REPLACE PROCEDURE sp_insert_field (
    p_id VARCHAR2,
    p_title VARCHAR2,
    p_description CLOB,
    p_crop VARCHAR2,
    p_field_area NUMBER,
    p_area_unit VARCHAR2,
    p_soil_type VARCHAR2,
    p_irrigation_type VARCHAR2,
    p_property_id VARCHAR2
)
IS
BEGIN
    INSERT INTO TB_FIELDS (
        id, title, description, crop, field_area, area_unit, soil_type, irrigation_type, property_id
    )
    VALUES (
        p_id, p_title, p_description, p_crop, p_field_area, p_area_unit,
        p_soil_type, p_irrigation_type, p_property_id
    );

    DBMS_OUTPUT.PUT_LINE('Campo inserido com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir campo: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_field (
    p_id VARCHAR2,
    p_title VARCHAR2,
    p_description CLOB,
    p_crop VARCHAR2,
    p_field_area NUMBER,
    p_area_unit VARCHAR2,
    p_soil_type VARCHAR2,
    p_irrigation_type VARCHAR2,
    p_property_id VARCHAR2
)
IS
BEGIN
    UPDATE TB_FIELDS
    SET title = p_title,
        description = p_description,
        crop = p_crop,
        field_area = p_field_area,
        area_unit = p_area_unit,
        soil_type = p_soil_type,
        irrigation_type = p_irrigation_type,
        property_id = p_property_id,
        updated_at = SYSTIMESTAMP
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Campo atualizado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar campo: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_field (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_FIELDS WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Campo removido com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao remover campo: ' || SQLERRM);
END;
/

-- TB_SENSORS
--insert 
CREATE OR REPLACE PROCEDURE sp_insert_sensor (
    p_id VARCHAR2,
    p_sensor_code VARCHAR2,
    p_model VARCHAR2,
    p_manufacturer VARCHAR2,
    p_installation_date TIMESTAMP,
    p_status VARCHAR2,
    p_battery_level NUMBER,
    p_last_maintenance TIMESTAMP,
    p_field_id VARCHAR2
)
IS
BEGIN
    INSERT INTO TB_SENSORS (
        id, sensor_code, model, manufacturer, installation_date, status,
        battery_level, last_maintenance, field_id
    )
    VALUES (
        p_id, p_sensor_code, p_model, p_manufacturer, p_installation_date,
        p_status, p_battery_level, p_last_maintenance, p_field_id
    );

    DBMS_OUTPUT.PUT_LINE('Sensor inserido com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir sensor: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_sensor (
    p_id VARCHAR2,
    p_sensor_code VARCHAR2,
    p_model VARCHAR2,
    p_manufacturer VARCHAR2,
    p_installation_date TIMESTAMP,
    p_status VARCHAR2,
    p_battery_level NUMBER,
    p_last_maintenance TIMESTAMP,
    p_field_id VARCHAR2
)
IS
BEGIN
    UPDATE TB_SENSORS
    SET sensor_code = p_sensor_code,
        model = p_model,
        manufacturer = p_manufacturer,
        installation_date = p_installation_date,
        status = p_status,
        battery_level = p_battery_level,
        last_maintenance = p_last_maintenance,
        field_id = p_field_id,
        updated_at = SYSTIMESTAMP
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Sensor atualizado com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar sensor: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_sensor (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_SENSORS WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Sensor removido com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao remover sensor: ' || SQLERRM);
END;
/

--TB_HARVESTS
--insert
CREATE OR REPLACE PROCEDURE sp_insert_harvest (
    p_id VARCHAR2,
    p_season VARCHAR2,
    p_crop VARCHAR2,
    p_planting_date DATE,
    p_expected_harvest_date DATE,
    p_field_id VARCHAR2
)
IS
BEGIN
    INSERT INTO TB_HARVESTS (
        id, harverst_season, crop, planting_date, expected_harvest_date, field_id
    )
    VALUES (
        p_id, p_season, p_crop, p_planting_date, p_expected_harvest_date, p_field_id
    );

    DBMS_OUTPUT.PUT_LINE('Safra inserida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir safra: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_harvest (
    p_id VARCHAR2,
    p_season VARCHAR2,
    p_crop VARCHAR2,
    p_planting_date DATE,
    p_expected_harvest_date DATE,
    p_field_id VARCHAR2
)
IS
BEGIN
    UPDATE TB_HARVESTS
    SET harverst_season = p_season,
        crop = p_crop,
        planting_date = p_planting_date,
        expected_harvest_date = p_expected_harvest_date,
        field_id = p_field_id,
        updated_at = SYSTIMESTAMP
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Safra atualizada com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar safra: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_harvest (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_HARVESTS WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Safra removida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao remover safra: ' || SQLERRM);
END;
/

--TB_SENSOR_READINGS
--insert
CREATE OR REPLACE PROCEDURE sp_insert_sensor_reading (
    p_id VARCHAR2,
    p_reading_time TIMESTAMP,
    p_temperature NUMBER,
    p_humidity NUMBER,
    p_soil_moisture NUMBER,
    p_wind_speed NUMBER,
    p_wind_direction VARCHAR2,
    p_rainfall NUMBER,
    p_soil_ph NUMBER,
    p_light_intensity NUMBER,
    p_sensor_id VARCHAR2
)
IS
BEGIN
    INSERT INTO TB_SENSOR_READINGS (
        id, reading_time, temperature, humidity, soil_moisture,
        wind_speed, wind_direction, rainfall, soil_ph, light_intensity, sensor_id
    ) VALUES (
        p_id, p_reading_time, p_temperature, p_humidity, p_soil_moisture,
        p_wind_speed, p_wind_direction, p_rainfall, p_soil_ph,
        p_light_intensity, p_sensor_id
    );

    DBMS_OUTPUT.PUT_LINE('Leitura inserida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir leitura: ' || SQLERRM);
END;
/
--update
CREATE OR REPLACE PROCEDURE sp_update_sensor_reading (
    p_id VARCHAR2,
    p_temperature NUMBER,
    p_humidity NUMBER,
    p_soil_moisture NUMBER,
    p_wind_speed NUMBER,
    p_wind_direction VARCHAR2,
    p_rainfall NUMBER,
    p_soil_ph NUMBER,
    p_light_intensity NUMBER
)
IS
BEGIN
    UPDATE TB_SENSOR_READINGS
    SET 
        temperature = p_temperature,
        humidity = p_humidity,
        soil_moisture = p_soil_moisture,
        wind_speed = p_wind_speed,
        wind_direction = p_wind_direction,
        rainfall = p_rainfall,
        soil_ph = p_soil_ph,
        light_intensity = p_light_intensity,
        reading_time = SYSTIMESTAMP, -- atualiza o horário da leitura
        updated_at = SYSTIMESTAMP   -- se quiser manter padrão das tabelas
    WHERE id = p_id;

    DBMS_OUTPUT.PUT_LINE('Leitura atualizada com sucesso!');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar leitura: ' || SQLERRM);
END;
/
--delete
CREATE OR REPLACE PROCEDURE sp_delete_sensor_reading (p_id VARCHAR2)
IS
BEGIN
    DELETE FROM TB_SENSOR_READINGS WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Leitura removida com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao remover leitura: ' || SQLERRM);
END;
/
-- drop users
DROP PROCEDURE sp_insert_user;
/
DROP PROCEDURE sp_update_user;
/
DROP PROCEDURE sp_delete_user;
/
-- drop properties
DROP PROCEDURE sp_insert_property;
/
DROP PROCEDURE sp_update_property;
/
DROP PROCEDURE sp_delete_property;
/
-- drop fields
DROP PROCEDURE sp_insert_field;
/
DROP PROCEDURE sp_update_field;
/
DROP PROCEDURE sp_delete_field;
/
-- drop sensors
DROP PROCEDURE sp_insert_sensor;
/
DROP PROCEDURE sp_update_sensor;
/
DROP PROCEDURE sp_delete_sensor;
/
--drop harvest
DROP PROCEDURE sp_insert_harvest;
/
DROP PROCEDURE sp_update_harvest;
/
DROP PROCEDURE sp_delete_harvest;
/

-- drop read sensors
DROP PROCEDURE sp_insert_sensor_reading;
/
DROP PROCEDURE sp_update_sensor_reading;
/
DROP PROCEDURE sp_delete_sensor_reading;
/
