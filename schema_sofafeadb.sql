--
-- PostgreSQL database dump
--

\restrict M90UTK9tgQcJWz43sIdTYVCse3zE7eM4A4gzRnUdnM0mBNf8wXPh5nWNzs1W1dZ

-- Dumped from database version 17.8
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: azure_pg_admin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO azure_pg_admin;

--
-- Name: azure; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS azure WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION azure; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION azure IS 'azure extension for PostgreSQL service';


--
-- Name: pgaadauth; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgaadauth WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION pgaadauth; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgaadauth IS 'Microsoft Entra ID Authentication';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: black_loyalist_directory; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.black_loyalist_directory (
    "ID" character varying(255),
    "Ref_Page" character varying(255),
    "Book" character varying(255),
    "Ship_Name" character varying(255),
    "Commander" character varying(255),
    "First_Name" character varying(255),
    "Surname" character varying(255),
    "Father_FirstName" character varying(255),
    "Father_Surname" character varying(255),
    "Mother_FirstName" character varying(255),
    "Mother_Surname" character varying(255),
    "Gender" character varying(255),
    "Age" character varying(255),
    "Race" character varying(255),
    "Ethnicity" character varying(255),
    "Description" character varying(255),
    "Origination_Port" character varying(255),
    "Origination_State" character varying(255),
    "Departure_Port" character varying(255),
    "Departure_Date" character varying(255),
    "Arrival_Port_City" character varying(255),
    "Primary_Source_1" character varying(255),
    "Primary_Source_2" character varying(255),
    "Notes" text
);


ALTER TABLE public.black_loyalist_directory OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: family_relations; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.family_relations (
    id integer NOT NULL,
    person_id integer NOT NULL,
    father_first_name character varying(255),
    father_last_name character varying(255),
    mother_first_name character varying(255),
    mother_last_name character varying(255)
);


ALTER TABLE public.family_relations OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: family_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE SEQUENCE public.family_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_relations_id_seq OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: family_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER SEQUENCE public.family_relations_id_seq OWNED BY public.family_relations.id;


--
-- Name: loyalist_records; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.loyalist_records (
    id integer NOT NULL,
    person_id integer NOT NULL,
    ref_page character varying(255),
    origination_port character varying(255),
    origination_state character varying(255),
    departure_port character varying(255),
    departure_date character varying(255),
    arrival_port_city character varying(255),
    primary_source_1 character varying(255),
    primary_source_2 character varying(255),
    source_id integer
);


ALTER TABLE public.loyalist_records OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: loyalist_records_id_seq; Type: SEQUENCE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE SEQUENCE public.loyalist_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loyalist_records_id_seq OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: loyalist_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER SEQUENCE public.loyalist_records_id_seq OWNED BY public.loyalist_records.id;


--
-- Name: persons; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.persons (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    middle_initial character varying(255),
    gender character varying(255),
    age character varying(255),
    race character varying(255),
    ethnicity character varying(255),
    occupation character varying(255),
    complexion character varying(255),
    marital_status character varying(255),
    description character varying(255),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.persons OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: persons_id_seq; Type: SEQUENCE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE SEQUENCE public.persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.persons_id_seq OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: persons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER SEQUENCE public.persons_id_seq OWNED BY public.persons.id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.sources (
    id integer NOT NULL,
    source_type character varying(255),
    book_or_volume character varying(255),
    ship_name character varying(255),
    commander character varying(255),
    box character varying(255),
    folder character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sources OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE SEQUENCE public.sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sources_id_seq OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER SEQUENCE public.sources_id_seq OWNED BY public.sources.id;


--
-- Name: usct_connecticut; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.usct_connecticut (
    "Last name" character varying(255),
    "First name" character varying(255),
    "MI/name" character varying(255),
    "Regiment" character varying(255),
    "Company" character varying(255),
    "Place of birth" character varying(255),
    "Enlistment date" character varying(255),
    "Enlistment location" character varying(255),
    "Residence" character varying(255),
    "Age" character varying(255),
    "Occupation" character varying(255),
    "Marital status" character varying(255),
    "Complexion" character varying(255),
    "Wounded" character varying(255),
    "Died in service" character varying(255),
    "Muster out date" character varying(255),
    "Sign name" character varying(255),
    "Substitue" character varying(255),
    "Substitute for" character varying(255),
    "Box" character varying(255),
    "Folder" character varying(255),
    "Notes" character varying(255)
);


ALTER TABLE public.usct_connecticut OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: usct_records; Type: TABLE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE TABLE public.usct_records (
    id integer NOT NULL,
    person_id integer NOT NULL,
    regiment character varying(255),
    company character varying(255),
    place_of_birth character varying(255),
    enlistment_date character varying(255),
    enlistment_location character varying(255),
    residence character varying(255),
    wounded character varying(255),
    died_in_service character varying(255),
    muster_out_date character varying(255),
    sign_name character varying(255),
    substitute character varying(255),
    substitute_for character varying(255),
    source_id integer
);


ALTER TABLE public.usct_records OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: usct_records_id_seq; Type: SEQUENCE; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

CREATE SEQUENCE public.usct_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usct_records_id_seq OWNER TO "Osama@sofafea.onmicrosoft.com";

--
-- Name: usct_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER SEQUENCE public.usct_records_id_seq OWNED BY public.usct_records.id;


--
-- Name: family_relations id; Type: DEFAULT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.family_relations ALTER COLUMN id SET DEFAULT nextval('public.family_relations_id_seq'::regclass);


--
-- Name: loyalist_records id; Type: DEFAULT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.loyalist_records ALTER COLUMN id SET DEFAULT nextval('public.loyalist_records_id_seq'::regclass);


--
-- Name: persons id; Type: DEFAULT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.persons ALTER COLUMN id SET DEFAULT nextval('public.persons_id_seq'::regclass);


--
-- Name: sources id; Type: DEFAULT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.sources ALTER COLUMN id SET DEFAULT nextval('public.sources_id_seq'::regclass);


--
-- Name: usct_records id; Type: DEFAULT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.usct_records ALTER COLUMN id SET DEFAULT nextval('public.usct_records_id_seq'::regclass);


--
-- Name: family_relations family_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.family_relations
    ADD CONSTRAINT family_relations_pkey PRIMARY KEY (id);


--
-- Name: loyalist_records loyalist_records_pkey; Type: CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.loyalist_records
    ADD CONSTRAINT loyalist_records_pkey PRIMARY KEY (id);


--
-- Name: persons persons_pkey; Type: CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: usct_records usct_records_pkey; Type: CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.usct_records
    ADD CONSTRAINT usct_records_pkey PRIMARY KEY (id);


--
-- Name: family_relations family_relations_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.family_relations
    ADD CONSTRAINT family_relations_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: loyalist_records loyalist_records_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.loyalist_records
    ADD CONSTRAINT loyalist_records_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: loyalist_records loyalist_records_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.loyalist_records
    ADD CONSTRAINT loyalist_records_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(id);


--
-- Name: usct_records usct_records_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.usct_records
    ADD CONSTRAINT usct_records_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: usct_records usct_records_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Osama@sofafea.onmicrosoft.com
--

ALTER TABLE ONLY public.usct_records
    ADD CONSTRAINT usct_records_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.sources(id);


--
-- Name: FUNCTION pg_replication_origin_advance(text, pg_lsn); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_advance(text, pg_lsn) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_create(text); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_create(text) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_drop(text); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_drop(text) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_oid(text); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_oid(text) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_progress(text, boolean); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_progress(text, boolean) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_session_is_setup(); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_is_setup() TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_session_progress(boolean); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_progress(boolean) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_session_reset(); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_reset() TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_session_setup(text); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_setup(text) TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_xact_reset(); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_reset() TO azure_pg_admin;


--
-- Name: FUNCTION pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone) TO azure_pg_admin;


--
-- Name: FUNCTION pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn) TO azure_pg_admin;


--
-- Name: FUNCTION pg_stat_reset(); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset() TO azure_pg_admin;


--
-- Name: FUNCTION pg_stat_reset_shared(target text); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_shared(target text) TO azure_pg_admin;


--
-- Name: FUNCTION pg_stat_reset_single_function_counters(oid); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_single_function_counters(oid) TO azure_pg_admin;


--
-- Name: FUNCTION pg_stat_reset_single_table_counters(oid); Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT ALL ON FUNCTION pg_catalog.pg_stat_reset_single_table_counters(oid) TO azure_pg_admin;


--
-- Name: COLUMN pg_config.name; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(name) ON TABLE pg_catalog.pg_config TO azure_pg_admin;


--
-- Name: COLUMN pg_config.setting; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(setting) ON TABLE pg_catalog.pg_config TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.line_number; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(line_number) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.type; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(type) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.database; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(database) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.user_name; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(user_name) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.address; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(address) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.netmask; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(netmask) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.auth_method; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(auth_method) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.options; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(options) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_hba_file_rules.error; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(error) ON TABLE pg_catalog.pg_hba_file_rules TO azure_pg_admin;


--
-- Name: COLUMN pg_replication_origin_status.local_id; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(local_id) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;


--
-- Name: COLUMN pg_replication_origin_status.external_id; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(external_id) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;


--
-- Name: COLUMN pg_replication_origin_status.remote_lsn; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(remote_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;


--
-- Name: COLUMN pg_replication_origin_status.local_lsn; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(local_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO azure_pg_admin;


--
-- Name: COLUMN pg_shmem_allocations.name; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(name) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;


--
-- Name: COLUMN pg_shmem_allocations.off; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(off) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;


--
-- Name: COLUMN pg_shmem_allocations.size; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(size) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;


--
-- Name: COLUMN pg_shmem_allocations.allocated_size; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(allocated_size) ON TABLE pg_catalog.pg_shmem_allocations TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.starelid; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(starelid) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staattnum; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staattnum) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stainherit; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stainherit) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanullfrac; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanullfrac) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stawidth; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stawidth) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stadistinct; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stadistinct) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stakind1; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stakind1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stakind2; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stakind2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stakind3; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stakind3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stakind4; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stakind4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stakind5; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stakind5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staop1; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staop1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staop2; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staop2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staop3; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staop3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staop4; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staop4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.staop5; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(staop5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stacoll1; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stacoll1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stacoll2; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stacoll2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stacoll3; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stacoll3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stacoll4; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stacoll4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stacoll5; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stacoll5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanumbers1; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanumbers1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanumbers2; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanumbers2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanumbers3; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanumbers3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanumbers4; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanumbers4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stanumbers5; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stanumbers5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stavalues1; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stavalues1) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stavalues2; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stavalues2) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stavalues3; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stavalues3) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stavalues4; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stavalues4) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_statistic.stavalues5; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(stavalues5) ON TABLE pg_catalog.pg_statistic TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.oid; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(oid) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subdbid; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subdbid) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subname; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subname) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subowner; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subowner) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subenabled; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subenabled) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subconninfo; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subconninfo) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subslotname; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subslotname) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subsynccommit; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subsynccommit) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- Name: COLUMN pg_subscription.subpublications; Type: ACL; Schema: pg_catalog; Owner: azuresu
--

GRANT SELECT(subpublications) ON TABLE pg_catalog.pg_subscription TO azure_pg_admin;


--
-- PostgreSQL database dump complete
--

\unrestrict M90UTK9tgQcJWz43sIdTYVCse3zE7eM4A4gzRnUdnM0mBNf8wXPh5nWNzs1W1dZ

