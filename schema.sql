--
-- PostgreSQL database dump
--

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

ALTER SCHEMA public OWNER TO azure_pg_admin;

--
-- Name: azure; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS azure WITH SCHEMA pg_catalog;

--
-- Name: pgaadauth; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgaadauth WITH SCHEMA pg_catalog;

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
ALTER SEQUENCE public.sources_id_seq OWNED BY public.sources.id;

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
-- [Permissions/ACL sections follow as in original...]
--