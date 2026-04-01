-- Book of Negroes Database Schema
-- Based on the actual schema from schema_sofafeadb.sql

-- Main table for Black Loyalist Directory
CREATE TABLE IF NOT EXISTS black_loyalist_directory (
    "ID" VARCHAR(255),
    "Ref_Page" VARCHAR(255),
    "Book" VARCHAR(255),
    "Ship_Name" VARCHAR(255),
    "Commander" VARCHAR(255),
    "First_Name" VARCHAR(255),
    "Surname" VARCHAR(255),
    "Father_FirstName" VARCHAR(255),
    "Father_Surname" VARCHAR(255),
    "Mother_FirstName" VARCHAR(255),
    "Mother_Surname" VARCHAR(255),
    "Gender" VARCHAR(255),
    "Age" VARCHAR(255),
    "Race" VARCHAR(255),
    "Ethnicity" VARCHAR(255),
    "Description" VARCHAR(255),
    "Origination_Port" VARCHAR(255),
    "Origination_State" VARCHAR(255),
    "Departure_Port" VARCHAR(255),
    "Departure_Date" VARCHAR(255),
    "Arrival_Port_City" VARCHAR(255),
    "Primary_Source_1" VARCHAR(255),
    "Primary_Source_2" VARCHAR(255),
    "Notes" TEXT
);

-- Normalized tables (optional - for future use)
CREATE TABLE IF NOT EXISTS persons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    middle_initial VARCHAR(255),
    gender VARCHAR(255),
    age VARCHAR(255),
    race VARCHAR(255),
    ethnicity VARCHAR(255),
    occupation VARCHAR(255),
    complexion VARCHAR(255),
    marital_status VARCHAR(255),
    description VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sources (
    id SERIAL PRIMARY KEY,
    source_type VARCHAR(255),
    book_or_volume VARCHAR(255),
    ship_name VARCHAR(255),
    commander VARCHAR(255),
    box VARCHAR(255),
    folder VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS loyalist_records (
    id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES persons(id),
    ref_page VARCHAR(255),
    origination_port VARCHAR(255),
    origination_state VARCHAR(255),
    departure_port VARCHAR(255),
    departure_date VARCHAR(255),
    arrival_port_city VARCHAR(255),
    primary_source_1 VARCHAR(255),
    primary_source_2 VARCHAR(255),
    source_id INTEGER REFERENCES sources(id)
);

CREATE TABLE IF NOT EXISTS family_relations (
    id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES persons(id),
    father_first_name VARCHAR(255),
    father_last_name VARCHAR(255),
    mother_first_name VARCHAR(255),
    mother_last_name VARCHAR(255)
);

-- Create indexes for better search performance on main table
CREATE INDEX IF NOT EXISTS idx_first_name ON black_loyalist_directory("First_Name");
CREATE INDEX IF NOT EXISTS idx_surname ON black_loyalist_directory("Surname");
CREATE INDEX IF NOT EXISTS idx_ship_name ON black_loyalist_directory("Ship_Name");
CREATE INDEX IF NOT EXISTS idx_gender ON black_loyalist_directory("Gender");
CREATE INDEX IF NOT EXISTS idx_race ON black_loyalist_directory("Race");
CREATE INDEX IF NOT EXISTS idx_origination_state ON black_loyalist_directory("Origination_State");
CREATE INDEX IF NOT EXISTS idx_book ON black_loyalist_directory("Book");

-- Comments for documentation
COMMENT ON TABLE black_loyalist_directory IS 'Main table containing Black Loyalist Directory records from the Book of Negroes';
COMMENT ON COLUMN black_loyalist_directory."ID" IS 'Unique identifier for each record';
COMMENT ON COLUMN black_loyalist_directory."Ref_Page" IS 'Reference page from original source';
COMMENT ON COLUMN black_loyalist_directory."Book" IS 'Book section (Book One Part One, etc.)';
COMMENT ON COLUMN black_loyalist_directory."Ship_Name" IS 'Name of the ship';
COMMENT ON COLUMN black_loyalist_directory."Commander" IS 'Ship commander/master';
COMMENT ON COLUMN black_loyalist_directory."First_Name" IS 'Person first name';
COMMENT ON COLUMN black_loyalist_directory."Surname" IS 'Person surname/last name';
COMMENT ON COLUMN black_loyalist_directory."Father_FirstName" IS 'Father first name';
COMMENT ON COLUMN black_loyalist_directory."Father_Surname" IS 'Father surname';
COMMENT ON COLUMN black_loyalist_directory."Mother_FirstName" IS 'Mother first name';
COMMENT ON COLUMN black_loyalist_directory."Mother_Surname" IS 'Mother surname';
COMMENT ON COLUMN black_loyalist_directory."Gender" IS 'Gender category (Male, Female, Child Male, Child Female)';
COMMENT ON COLUMN black_loyalist_directory."Age" IS 'Age at time of record';
COMMENT ON COLUMN black_loyalist_directory."Race" IS 'Race classification';
COMMENT ON COLUMN black_loyalist_directory."Ethnicity" IS 'Ethnicity classification';
COMMENT ON COLUMN black_loyalist_directory."Description" IS 'Detailed description';
COMMENT ON COLUMN black_loyalist_directory."Origination_Port" IS 'Port of origin';
COMMENT ON COLUMN black_loyalist_directory."Origination_State" IS 'State/colony of origin';
COMMENT ON COLUMN black_loyalist_directory."Departure_Port" IS 'Departure port';
COMMENT ON COLUMN black_loyalist_directory."Departure_Date" IS 'Departure date';
COMMENT ON COLUMN black_loyalist_directory."Arrival_Port_City" IS 'Arrival port/city';
COMMENT ON COLUMN black_loyalist_directory."Primary_Source_1" IS 'Primary source reference 1';
COMMENT ON COLUMN black_loyalist_directory."Primary_Source_2" IS 'Primary source reference 2';
COMMENT ON COLUMN black_loyalist_directory."Notes" IS 'Additional notes and raw text';