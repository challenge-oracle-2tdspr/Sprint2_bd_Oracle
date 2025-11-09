--USERS
CREATE TABLE TB_USERS (
    id VARCHAR2(40) PRIMARY KEY,
    email VARCHAR2(255) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL,
    cpf VARCHAR2(14) UNIQUE NOT NULL,
    role VARCHAR2(20) NOT NULL 
        CHECK (role IN ('ADMIN', 'USER', 'MANAGER')),
    first_name VARCHAR2(255),
    last_name VARCHAR2(255),
    phone_number VARCHAR2(50),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);


--PROPERTIES
CREATE TABLE TB_PROPERTIES (
    id VARCHAR2(40) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    description CLOB,
    total_area NUMBER(12,2),
    area_unit VARCHAR2(20) 
        CHECK (area_unit IN ('HECTARES', 'ACRES', 'SQUARE_METER')),
    address VARCHAR2(255),
    city VARCHAR2(100),
    state VARCHAR2(100),
    country VARCHAR2(100),
    zip_code VARCHAR2(20),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    owner_id VARCHAR2(36),
    CONSTRAINT fk_property_owner FOREIGN KEY (owner_id) REFERENCES TB_USERS (id)
);


--FIELDS
CREATE TABLE TB_FIELDS (
    id VARCHAR2(40) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    description CLOB,
    crop VARCHAR2(255) NOT NULL,
    field_area NUMBER(12,2),
    area_unit VARCHAR2(20) 
        CHECK (area_unit IN ('HECTARES', 'ACRES', 'SQUARE_METER')),
    soil_type VARCHAR2(20) 
        CHECK (soil_type IN ('CLAY', 'SAND', 'LOAM', 'SILT', 'PEAT', 'CHALK')),
    irrigation_type VARCHAR2(20) 
        CHECK (irrigation_type IN ('SPRINKLER', 'DRIP', 'FLOOD', 'PIVOT', 'NONE')),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    property_id VARCHAR2(36) NOT NULL,
    CONSTRAINT fk_field_property FOREIGN KEY (property_id) REFERENCES TB_PROPERTIES (id)
);


--SENSORS
CREATE TABLE TB_SENSORS (
    id VARCHAR2(40) PRIMARY KEY,
    sensor_code VARCHAR2(255) UNIQUE,
    model VARCHAR2(255),
    manufacturer VARCHAR2(255),
    installation_date TIMESTAMP,
    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL 
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'MAINTENANCE', 'OFFLINE')),
    battery_level NUMBER(10),
    last_maintenance TIMESTAMP,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    field_id VARCHAR2(36) NOT NULL UNIQUE,
    CONSTRAINT fk_sensor_field FOREIGN KEY (field_id) REFERENCES TB_FIELDS (id)
);


--HARVESTS
CREATE TABLE TB_HARVESTS (
    id VARCHAR2(40) PRIMARY KEY,
    harverst_season VARCHAR2(255),
    crop VARCHAR2(255) NOT NULL,
    planting_date DATE NOT NULL,
    expected_harvest_date DATE,
    actual_start_date DATE,
    actual_end_date DATE,
    planted_area NUMBER(10,2),
    harvested_area NUMBER(10,2),
    expected_yield NUMBER(10,2),
    actual_yield NUMBER(10,2),
    yield_per_hectare NUMBER(8,2),
    quality_grade VARCHAR2(20) 
        CHECK (quality_grade IN ('PREMIUM', 'GRADE_A', 'GRADE_B', 'GRADE_C', 'REJECTED')),
    market_price_per_ton NUMBER(10,2),
    total_revenue NUMBER(12,2),
    production_cost NUMBER(12,2),
    profit_margin NUMBER(12,2),
    harvest_notes VARCHAR2(1000),
    weather_conditions VARCHAR2(500),
    status VARCHAR2(20) DEFAULT 'PLANNED' NOT NULL 
        CHECK (status IN (
            'PLANNED','PLANTED','GROWING','READY_TO_HARVEST',
            'HARVESTING','COMPLETED','CANCELLED'
        )),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    field_id VARCHAR2(36) NOT NULL,
    CONSTRAINT fk_harvest_field FOREIGN KEY (field_id) REFERENCES TB_FIELDS (id)
);


--SENSOR_READINGS
CREATE TABLE TB_SENSOR_READINGS (
    id VARCHAR2(40) PRIMARY KEY,
    reading_time TIMESTAMP NOT NULL,
    temperature NUMBER(5,2),
    humidity NUMBER(5,2),
    soil_moisture NUMBER(5,2),
    wind_speed NUMBER(5,2),
    wind_direction VARCHAR2(50),
    rainfall NUMBER(6,2),
    soil_ph NUMBER(4,2),
    light_intensity NUMBER(8,2),
    sensor_id VARCHAR2(36) NOT NULL,
    CONSTRAINT fk_reading_sensor FOREIGN KEY (sensor_id) REFERENCES TB_SENSORS (id)
);

-------------------------------------------------------------------------
--Tabelas dependentes 
DROP TABLE  tb_sensor_readings ;
DROP TABLE  tb_harvests ;
DROP TABLE  tb_sensors ;
DROP TABLE  tb_fields ;

--Tabelas principais (pais)
DROP TABLE  tb_properties ;
DROP TABLE  tb_users ;