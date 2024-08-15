--
-- PostgreSQL database dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE haalcentraal;
ALTER ROLE haalcentraal WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;
-- CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'root';


-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: root; Type: DATABASE; Schema: -; Owner: root
--

-- CREATE DATABASE root WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE root OWNER TO root;

\connect root

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 14.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: rvig_haalcentraal_testdata; Type: DATABASE; Schema: -; Owner: haalcentraal
--

CREATE DATABASE rvig_haalcentraal_testdata WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE rvig_haalcentraal_testdata OWNER TO haalcentraal;

\connect rvig_haalcentraal_testdata

--
-- Name: tbl_partitions; Type: SCHEMA; Schema: -; Owner: haalcentraal
--

CREATE SCHEMA tbl_partitions;


ALTER SCHEMA tbl_partitions OWNER TO haalcentraal;

--
-- Name: vospg; Type: SCHEMA; Schema: -; Owner: haalcentraal
--

CREATE SCHEMA vospg;


ALTER SCHEMA vospg OWNER TO haalcentraal;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA public;


--
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- Name: contains_special_characters(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.contains_special_characters(character varying) RETURNS boolean
    LANGUAGE sql
    AS $_$
-- Implementation: replace special characters by an inverted exclamation mark and
--   return true if the translation result contains any of those marks.
select position(E'\xc2\xa1' in translate(
$1,-- search original string

E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xab' ||-- angle quotation mark left
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb1' ||-- plus minus sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbb' ||-- angle quotation mark right
E'\xc2\xbc' ||-- fraction one quarter
E'\xc2\xbd' ||-- fraction one half
E'\xc2\xbe' ||-- fraction three quarter
E'\xc2\xbf' ||-- inverted question mark
E'\xe2\x84\xa6' ||-- Ohm sign
E'\xc3\x86' ||-- capital AE diphtong
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc4\xbf' ||-- capital L with middle dot
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc5\x92' ||-- capital OE ligature
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc3\x9e' ||-- capital thorn, icelandic
E'\xc5\xa6' ||-- capital T with stroke
E'\xc5\x8a' ||-- capital eng, lapp
E'\xc5\x89' ||-- small n with apostrophe
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc3\xa6' ||-- small ae diphtong
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x80' ||-- small l with middle dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\x93' ||-- small oe ligature
E'\xc3\x9f' ||-- small sharp s, german
E'\xc3\xbe' ||-- small thorn, icelandic
E'\xc5\xa7' ||-- small t with stroke
E'\xc5\x8b',-- small eng, lapp
E'\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1')) > 0
$_$;


ALTER FUNCTION public.contains_special_characters(character varying) OWNER TO haalcentraal;

--
-- Name: convert_special_characters_to_slim(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.convert_special_characters_to_slim(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$
select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(translate(

-- convert the contents of the input string
$1,

-- from these special characters
E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbf' ||-- inverted question mark
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc5\xa6' ||-- capital T with stroke
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\xa7',-- small t with stroke

-- to a single ASCII-compatible character
'!' ||-- inverted exclamation mark
'c' ||-- cent sign
'L' ||-- pound sign
'Y' ||-- yen sign
'*' ||-- currency sign
'o' ||-- degree sign
'2' ||-- superscript 2
'3' ||-- superscript 3
'x' ||-- multiply sign
'.' ||-- middle dot
':' ||-- divide sign
'?' ||-- inverted question mark
'D' ||-- capital D with stroke
'a' ||-- ordinal indicator feminine
'H' ||-- capital H with stroke
'L' ||-- capital L with stroke
'O' ||-- capital O with slash
'o' ||-- ordinal indicator masculine
'T' ||-- capital T with stroke
'q' ||-- small k, greenlandic
'd' ||-- small d with stroke
'd' ||-- small eth, icelandic
'h' ||-- small h with stroke
'i' ||-- small i without dot
'l' ||-- small l with stroke
'o' ||-- small o with slash
't'),-- small t with stroke

-- and from the other special characters to more than one ASCII-compatible character
E'\xc2\xab', '<<'),-- angle quotation mark left
E'\xc2\xb1', '+/-'),-- plus minus sign
E'\xc2\xbb', '>>'),-- angle quotation mark right
E'\xc2\xbc', '1/4'),-- fraction one quarter
E'\xc2\xbd', '1/2'),-- fraction one half
E'\xc2\xbe', '3/4'),-- fraction three quarter
E'\xe2\x84\xa6', 'Ohm'),-- Ohm sign
E'\xc3\x86', 'AE'),-- capital AE diphtong
E'\xc4\xbf', 'L.'),-- capital L with middle dot
E'\xc5\x92', 'OE'),-- capital OE ligature
E'\xc3\x9e', 'TH'),-- capital thorn, icelandic
E'\xc5\x8a', 'NG'),-- capital eng, lapp
E'\xc5\x89', '''n'),-- small n with apostrophe
E'\xc3\xa6', 'ae'),-- small ae diphtong
E'\xc5\x80', 'l.'),-- small l with middle dot
E'\xc5\x93', 'oe'),-- small oe ligature
E'\xc3\x9f', 'ss'),-- small sharp s, german
E'\xc3\xbe', 'th'),-- small thorn, icelandic
E'\xc5\x8b', 'ng')-- small eng, lapp
$_$;


ALTER FUNCTION public.convert_special_characters_to_slim(character varying) OWNER TO haalcentraal;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO haalcentraal;

--
-- Name: plpgsql_validator(oid); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_validator(oid) RETURNS void
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_validator';


ALTER FUNCTION public.plpgsql_validator(oid) OWNER TO haalcentraal;

--
-- Name: activiteit_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.activiteit_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activiteit_id_sequence OWNER TO haalcentraal;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: haalcentraal_schema; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.haalcentraal_schema (
    version character varying(40) NOT NULL
);


ALTER TABLE public.haalcentraal_schema OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.haalcentraal_vraag (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
)
PARTITION BY RANGE (request_datum);


ALTER TABLE public.haalcentraal_vraag OWNER TO haalcentraal;

--
-- Name: lo3_adres; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_adres (
    adres_id bigint NOT NULL,
    gemeente_code smallint NOT NULL,
    gemeente_deel character varying(24),
    straat_naam character varying(24),
    diak_straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    huis_nr_aand character varying(2),
    postcode character varying(6),
    locatie_beschrijving character varying(35),
    diak_locatie_beschrijving character varying(35),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    open_ruimte_naam character varying(80),
    diak_open_ruimte_naam character varying(80),
    woon_plaats_naam character varying(80),
    diak_woon_plaats_naam character varying(80),
    verblijf_plaats_ident_code character varying(16),
    nummer_aand_ident_code character varying(16)
);


ALTER TABLE public.lo3_adres OWNER TO haalcentraal;

--
-- Name: lo3_autorisatie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_autorisatie (
    autorisatie_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    geheimhouding_ind smallint NOT NULL,
    verstrekkings_beperking smallint NOT NULL,
    afnemer_naam character varying(80),
    straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    postcode character varying(6),
    gemeente_code smallint,
    conditionele_verstrekking smallint,
    spontaan_medium character(1),
    selectie_soort smallint,
    bericht_aand smallint,
    eerste_selectie_datum integer,
    selectie_periode smallint,
    selectie_medium character(1),
    pl_plaatsings_bevoegdheid smallint,
    adres_vraag_bevoegdheid smallint,
    ad_hoc_medium character(1),
    adres_medium character(1),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    sleutel_rubrieken text,
    spontaan_rubrieken text,
    selectie_rubrieken text,
    ad_hoc_rubrieken text,
    adres_rubrieken text,
    afnemers_verstrekkingen text,
    bijzondere_betrekking_kind_verstrekken smallint DEFAULT 0,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    adres_typen character varying(20)
);


ALTER TABLE public.lo3_autorisatie OWNER TO haalcentraal;

--
-- Name: lo3_gemeente; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gemeente (
    gemeente_code smallint NOT NULL,
    gemeente_naam character varying(40) NOT NULL,
    nieuwe_gemeente_code smallint,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gemeente OWNER TO haalcentraal;

--
-- Name: lo3_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gezagsverhouding (
    gezagsverhouding_code character varying(2) NOT NULL,
    gezagsverhouding_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gezagsverhouding OWNER TO haalcentraal;

--
-- Name: lo3_land; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_land (
    land_code smallint NOT NULL,
    land_naam character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_land OWNER TO haalcentraal;

--
-- Name: lo3_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nationaliteit (
    nationaliteit_code smallint NOT NULL,
    nationaliteit_oms character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nationaliteit OWNER TO haalcentraal;

--
-- Name: lo3_nl_nat_verkrijg_verlies_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_nat_verkrijg_verlies_reden (
    nl_nat_verkrijg_verlies_reden smallint NOT NULL,
    nl_nat_reden_oms character varying(80) NOT NULL,
    nl_nat_reden_soort character varying(2) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_nat_verkrijg_verlies_reden OWNER TO haalcentraal;

--
-- Name: lo3_pl; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl (
    pl_id bigint NOT NULL,
    pl_blokkering_start_datum integer,
    bijhouding_opschort_datum integer,
    bijhouding_opschort_reden character(1),
    gba_eerste_inschrijving_datum integer,
    pk_gemeente_code smallint,
    geheim_ind smallint,
    volledig_geconverteerd_pk character(1),
    europees_kiesrecht_aand smallint,
    europees_kiesrecht_datum integer,
    europees_uitsluit_eind_datum integer,
    kiesrecht_uitgesl_aand character(1),
    kiesrecht_uitgesl_eind_datum integer,
    kiesrecht_doc_gemeente_code smallint,
    kiesrecht_doc_datum integer,
    kiesrecht_doc_beschrijving character varying(40),
    mutatie_activiteit_id bigint,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    mutatie_dt timestamp without time zone NOT NULL,
    versie_nr smallint,
    stempel_dt bigint,
    verificatie_datum integer,
    verificatie_oms character varying(50),
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    adres_eu_lidstaat_van_herkomst character varying(50),
    plaats_eu_lidstaat_van_herkomst character varying(50),
    land_eu_lidstaat_van_herkomst smallint
);


ALTER TABLE public.lo3_pl OWNER TO haalcentraal;

--
-- Name: lo3_pl_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_gezagsverhouding (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    minderjarig_gezag_ind character varying(2),
    curatele_register_ind smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_gezagsverhouding OWNER TO haalcentraal;

--
-- Name: lo3_pl_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_nationaliteit (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    nationaliteit_code smallint,
    nl_nat_verkrijg_reden smallint,
    nl_nat_verlies_reden smallint,
    bijzonder_nl_aand character(1),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    eu_persoon_nr character varying(40)
);


ALTER TABLE public.lo3_pl_nationaliteit OWNER TO haalcentraal;

--
-- Name: lo3_pl_overlijden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_overlijden (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    overlijden_datum integer,
    overlijden_plaats character varying(40),
    overlijden_land_code smallint,
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_overlijden OWNER TO haalcentraal;

--
-- Name: lo3_pl_persoon; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_persoon (
    pl_id bigint NOT NULL,
    persoon_type character(1) NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    a_nr bigint,
    burger_service_nr bigint,
    voor_naam character varying(200),
    diak_voor_naam character varying(200),
    titel_predicaat character varying(2),
    geslachts_naam_voorvoegsel character varying(10),
    geslachts_naam character varying(200),
    diak_geslachts_naam character varying(200),
    geboorte_datum integer,
    geboorte_plaats character varying(40),
    geboorte_land_code smallint,
    geslachts_aand character(1),
    naam_gebruik_aand character(1),
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    relatie_start_datum integer,
    relatie_start_plaats character varying(40),
    relatie_start_land_code smallint,
    relatie_eind_datum integer,
    relatie_eind_plaats character varying(40),
    relatie_eind_land_code smallint,
    relatie_eind_reden character(1),
    verbintenis_soort character(1),
    familie_betrek_start_datum integer,
    vorig_a_nr bigint,
    volgend_a_nr bigint,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    registratie_betrekking character(1)
);


ALTER TABLE public.lo3_pl_persoon OWNER TO haalcentraal;

--
-- Name: lo3_pl_reis_doc; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_reis_doc (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    nl_reis_doc_soort character varying(2),
    nl_reis_doc_nr character varying(9),
    nl_reis_doc_uitgifte_datum integer,
    nl_reis_doc_autoriteit_code character varying(6),
    nl_reis_doc_geldig_eind_datum integer,
    nl_reis_doc_weg_datum integer,
    nl_reis_doc_weg_ind character(1),
    nl_reis_doc_houder_lengte smallint,
    nl_reis_doc_signalering smallint,
    buitenland_reis_doc_aand smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_reis_doc OWNER TO haalcentraal;

--
-- Name: lo3_pl_verblijfplaats; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfplaats (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    inschrijving_gemeente_code smallint,
    adres_id bigint,
    inschrijving_datum integer,
    adres_functie character(1),
    gemeente_deel character varying(24),
    adreshouding_start_datum integer,
    vertrek_land_code smallint,
    vertrek_datum integer,
    vertrek_land_adres_1 character varying(35),
    vertrek_land_adres_2 character varying(35),
    vertrek_land_adres_3 character varying(35),
    vestiging_land_code smallint,
    vestiging_datum integer,
    aangifte_adreshouding_oms character(1),
    doc_ind smallint,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_verblijfplaats OWNER TO haalcentraal;

--
-- Name: lo3_pl_verblijfstitel; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfstitel (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    verblijfstitel_aand smallint,
    verblijfstitel_eind_datum integer,
    verblijfstitel_start_datum integer,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_verblijfstitel OWNER TO haalcentraal;

--
-- Name: lo3_relatie_eind_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_relatie_eind_reden (
    relatie_eind_reden character(1) NOT NULL,
    relatie_eind_reden_oms character varying(80),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_relatie_eind_reden OWNER TO haalcentraal;

--
-- Name: lo3_rni_deelnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_rni_deelnemer (
    deelnemer_code smallint NOT NULL,
    deelnemer_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_rni_deelnemer OWNER TO haalcentraal;

--
-- Name: lo3_titel_predicaat; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_titel_predicaat (
    titel_predicaat character varying(2) NOT NULL,
    titel_predicaat_oms character varying(10) NOT NULL,
    titel_predicaat_soort character varying(10) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_titel_predicaat OWNER TO haalcentraal;

--
-- Name: lo3_verblijfstitel_aand; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_verblijfstitel_aand (
    verblijfstitel_aand smallint NOT NULL,
    verblijfstitel_aand_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_verblijfstitel_aand OWNER TO haalcentraal;

--
-- Name: lo3_voorwaarde_regel_aut; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_voorwaarde_regel_aut (
    voorwaarde_type character(1) NOT NULL,
    voorwaarde_regel character varying(4096) NOT NULL,
    autorisatie_id bigint NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_voorwaarde_regel_aut OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240401; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240401 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240401 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240402; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240402 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240402 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240403; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240403 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240403 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240404; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240404 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240404 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240405; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240405 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240405 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240406; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240406 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240406 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240407; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240407 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240407 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240408; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240408 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240408 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240409; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240409 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240409 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240410; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240410 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240410 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240411; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240411 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240411 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240412; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240412 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240412 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240413; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240413 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240413 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240414; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240414 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240414 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240415; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240415 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240415 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240416; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240416 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240416 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240417; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240417 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240417 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240418; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240418 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240418 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240419; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240419 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240419 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240420; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240420 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240420 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240421; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240421 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240421 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240422; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240422 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240422 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240423; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240423 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240423 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240424; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240424 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240424 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240425; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240425 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240425 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240426; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240426 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240426 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240427; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240427 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240427 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240428; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240428 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240428 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240429; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240429 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240429 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240430; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240430 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240430 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240501; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240501 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240501 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240502; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240502 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240502 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240503; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240503 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240503 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240504; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240504 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240504 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240505; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240505 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240505 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240506; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240506 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240506 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240507; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240507 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240507 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240508; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240508 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240508 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240509; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240509 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240509 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240510; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240510 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240510 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240511; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240511 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240511 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240512; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240512 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240512 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240513; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240513 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240513 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240514; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240514 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240514 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240515; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240515 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240515 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240516; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240516 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240516 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240517; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240517 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240517 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240518; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240518 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240518 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240519; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240519 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240519 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240520; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240520 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240520 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240521; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240521 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240521 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240522; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240522 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240522 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240523; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240523 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240523 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240524; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240524 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240524 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240525; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240525 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240525 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240526; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240526 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240526 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240527; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240527 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240527 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240528; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240528 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240528 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240529; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240529 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240529 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240530; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240530 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240530 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240531; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240531 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240531 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240601; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240601 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240601 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240602; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240602 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240602 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240603; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240603 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240603 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240604; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240604 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240604 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240605; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240605 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240605 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240606; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240606 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240606 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240607; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240607 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240607 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240608; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240608 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240608 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240609; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240609 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240609 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240610; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240610 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240610 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240611; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240611 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240611 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240612; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240612 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240612 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240613; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240613 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240613 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240614; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240614 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240614 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240615; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240615 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240615 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240616; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240616 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240616 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240617; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240617 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240617 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240618; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240618 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240618 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240619; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240619 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240619 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240620; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240620 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240620 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240621; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240621 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240621 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240622; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240622 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240622 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240623; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240623 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240623 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240624; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240624 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240624 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240625; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240625 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240625 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240626; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240626 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240626 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240627; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240627 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240627 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240628; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240628 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240628 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240629; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240629 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240629 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240630; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240630 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240630 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240701; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240701 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240701 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240702; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240702 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240702 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240703; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240703 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240703 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240704; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240704 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240704 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240705; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240705 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240705 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240706; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240706 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240706 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240707; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240707 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240707 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240708; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240708 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240708 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240709; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240709 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240709 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240710; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240710 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240710 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240711; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240711 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240711 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240712; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240712 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240712 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240713; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240713 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240713 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240714; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240714 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240714 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240715; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240715 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240715 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240716; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240716 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240716 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240717; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240717 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240717 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240718; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240718 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240718 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240719; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240719 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240719 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240720; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240720 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240720 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240721; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240721 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240721 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240722; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240722 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240722 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240723; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240723 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240723 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240724; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240724 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240724 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240725; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240725 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240725 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240726; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240726 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240726 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240727; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240727 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240727 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240728; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240728 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240728 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240729; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240729 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240729 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240730; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240730 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240730 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240731; Type: TABLE; Schema: tbl_partitions; Owner: haalcentraal
--

CREATE TABLE tbl_partitions.haalcentraal_vraag_20240731 (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE tbl_partitions.haalcentraal_vraag_20240731 OWNER TO haalcentraal;

--
-- Name: haalcentraal_vraag_20240401; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240401 FOR VALUES FROM ('2024-04-01 00:00:00') TO ('2024-04-02 00:00:00');


--
-- Name: haalcentraal_vraag_20240402; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240402 FOR VALUES FROM ('2024-04-02 00:00:00') TO ('2024-04-03 00:00:00');


--
-- Name: haalcentraal_vraag_20240403; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240403 FOR VALUES FROM ('2024-04-03 00:00:00') TO ('2024-04-04 00:00:00');


--
-- Name: haalcentraal_vraag_20240404; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240404 FOR VALUES FROM ('2024-04-04 00:00:00') TO ('2024-04-05 00:00:00');


--
-- Name: haalcentraal_vraag_20240405; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240405 FOR VALUES FROM ('2024-04-05 00:00:00') TO ('2024-04-06 00:00:00');


--
-- Name: haalcentraal_vraag_20240406; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240406 FOR VALUES FROM ('2024-04-06 00:00:00') TO ('2024-04-07 00:00:00');


--
-- Name: haalcentraal_vraag_20240407; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240407 FOR VALUES FROM ('2024-04-07 00:00:00') TO ('2024-04-08 00:00:00');


--
-- Name: haalcentraal_vraag_20240408; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240408 FOR VALUES FROM ('2024-04-08 00:00:00') TO ('2024-04-09 00:00:00');


--
-- Name: haalcentraal_vraag_20240409; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240409 FOR VALUES FROM ('2024-04-09 00:00:00') TO ('2024-04-10 00:00:00');


--
-- Name: haalcentraal_vraag_20240410; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240410 FOR VALUES FROM ('2024-04-10 00:00:00') TO ('2024-04-11 00:00:00');


--
-- Name: haalcentraal_vraag_20240411; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240411 FOR VALUES FROM ('2024-04-11 00:00:00') TO ('2024-04-12 00:00:00');


--
-- Name: haalcentraal_vraag_20240412; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240412 FOR VALUES FROM ('2024-04-12 00:00:00') TO ('2024-04-13 00:00:00');


--
-- Name: haalcentraal_vraag_20240413; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240413 FOR VALUES FROM ('2024-04-13 00:00:00') TO ('2024-04-14 00:00:00');


--
-- Name: haalcentraal_vraag_20240414; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240414 FOR VALUES FROM ('2024-04-14 00:00:00') TO ('2024-04-15 00:00:00');


--
-- Name: haalcentraal_vraag_20240415; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240415 FOR VALUES FROM ('2024-04-15 00:00:00') TO ('2024-04-16 00:00:00');


--
-- Name: haalcentraal_vraag_20240416; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240416 FOR VALUES FROM ('2024-04-16 00:00:00') TO ('2024-04-17 00:00:00');


--
-- Name: haalcentraal_vraag_20240417; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240417 FOR VALUES FROM ('2024-04-17 00:00:00') TO ('2024-04-18 00:00:00');


--
-- Name: haalcentraal_vraag_20240418; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240418 FOR VALUES FROM ('2024-04-18 00:00:00') TO ('2024-04-19 00:00:00');


--
-- Name: haalcentraal_vraag_20240419; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240419 FOR VALUES FROM ('2024-04-19 00:00:00') TO ('2024-04-20 00:00:00');


--
-- Name: haalcentraal_vraag_20240420; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240420 FOR VALUES FROM ('2024-04-20 00:00:00') TO ('2024-04-21 00:00:00');


--
-- Name: haalcentraal_vraag_20240421; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240421 FOR VALUES FROM ('2024-04-21 00:00:00') TO ('2024-04-22 00:00:00');


--
-- Name: haalcentraal_vraag_20240422; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240422 FOR VALUES FROM ('2024-04-22 00:00:00') TO ('2024-04-23 00:00:00');


--
-- Name: haalcentraal_vraag_20240423; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240423 FOR VALUES FROM ('2024-04-23 00:00:00') TO ('2024-04-24 00:00:00');


--
-- Name: haalcentraal_vraag_20240424; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240424 FOR VALUES FROM ('2024-04-24 00:00:00') TO ('2024-04-25 00:00:00');


--
-- Name: haalcentraal_vraag_20240425; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240425 FOR VALUES FROM ('2024-04-25 00:00:00') TO ('2024-04-26 00:00:00');


--
-- Name: haalcentraal_vraag_20240426; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240426 FOR VALUES FROM ('2024-04-26 00:00:00') TO ('2024-04-27 00:00:00');


--
-- Name: haalcentraal_vraag_20240427; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240427 FOR VALUES FROM ('2024-04-27 00:00:00') TO ('2024-04-28 00:00:00');


--
-- Name: haalcentraal_vraag_20240428; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240428 FOR VALUES FROM ('2024-04-28 00:00:00') TO ('2024-04-29 00:00:00');


--
-- Name: haalcentraal_vraag_20240429; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240429 FOR VALUES FROM ('2024-04-29 00:00:00') TO ('2024-04-30 00:00:00');


--
-- Name: haalcentraal_vraag_20240430; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240430 FOR VALUES FROM ('2024-04-30 00:00:00') TO ('2024-05-01 00:00:00');


--
-- Name: haalcentraal_vraag_20240501; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240501 FOR VALUES FROM ('2024-05-01 00:00:00') TO ('2024-05-02 00:00:00');


--
-- Name: haalcentraal_vraag_20240502; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240502 FOR VALUES FROM ('2024-05-02 00:00:00') TO ('2024-05-03 00:00:00');


--
-- Name: haalcentraal_vraag_20240503; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240503 FOR VALUES FROM ('2024-05-03 00:00:00') TO ('2024-05-04 00:00:00');


--
-- Name: haalcentraal_vraag_20240504; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240504 FOR VALUES FROM ('2024-05-04 00:00:00') TO ('2024-05-05 00:00:00');


--
-- Name: haalcentraal_vraag_20240505; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240505 FOR VALUES FROM ('2024-05-05 00:00:00') TO ('2024-05-06 00:00:00');


--
-- Name: haalcentraal_vraag_20240506; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240506 FOR VALUES FROM ('2024-05-06 00:00:00') TO ('2024-05-07 00:00:00');


--
-- Name: haalcentraal_vraag_20240507; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240507 FOR VALUES FROM ('2024-05-07 00:00:00') TO ('2024-05-08 00:00:00');


--
-- Name: haalcentraal_vraag_20240508; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240508 FOR VALUES FROM ('2024-05-08 00:00:00') TO ('2024-05-09 00:00:00');


--
-- Name: haalcentraal_vraag_20240509; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240509 FOR VALUES FROM ('2024-05-09 00:00:00') TO ('2024-05-10 00:00:00');


--
-- Name: haalcentraal_vraag_20240510; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240510 FOR VALUES FROM ('2024-05-10 00:00:00') TO ('2024-05-11 00:00:00');


--
-- Name: haalcentraal_vraag_20240511; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240511 FOR VALUES FROM ('2024-05-11 00:00:00') TO ('2024-05-12 00:00:00');


--
-- Name: haalcentraal_vraag_20240512; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240512 FOR VALUES FROM ('2024-05-12 00:00:00') TO ('2024-05-13 00:00:00');


--
-- Name: haalcentraal_vraag_20240513; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240513 FOR VALUES FROM ('2024-05-13 00:00:00') TO ('2024-05-14 00:00:00');


--
-- Name: haalcentraal_vraag_20240514; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240514 FOR VALUES FROM ('2024-05-14 00:00:00') TO ('2024-05-15 00:00:00');


--
-- Name: haalcentraal_vraag_20240515; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240515 FOR VALUES FROM ('2024-05-15 00:00:00') TO ('2024-05-16 00:00:00');


--
-- Name: haalcentraal_vraag_20240516; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240516 FOR VALUES FROM ('2024-05-16 00:00:00') TO ('2024-05-17 00:00:00');


--
-- Name: haalcentraal_vraag_20240517; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240517 FOR VALUES FROM ('2024-05-17 00:00:00') TO ('2024-05-18 00:00:00');


--
-- Name: haalcentraal_vraag_20240518; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240518 FOR VALUES FROM ('2024-05-18 00:00:00') TO ('2024-05-19 00:00:00');


--
-- Name: haalcentraal_vraag_20240519; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240519 FOR VALUES FROM ('2024-05-19 00:00:00') TO ('2024-05-20 00:00:00');


--
-- Name: haalcentraal_vraag_20240520; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240520 FOR VALUES FROM ('2024-05-20 00:00:00') TO ('2024-05-21 00:00:00');


--
-- Name: haalcentraal_vraag_20240521; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240521 FOR VALUES FROM ('2024-05-21 00:00:00') TO ('2024-05-22 00:00:00');


--
-- Name: haalcentraal_vraag_20240522; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240522 FOR VALUES FROM ('2024-05-22 00:00:00') TO ('2024-05-23 00:00:00');


--
-- Name: haalcentraal_vraag_20240523; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240523 FOR VALUES FROM ('2024-05-23 00:00:00') TO ('2024-05-24 00:00:00');


--
-- Name: haalcentraal_vraag_20240524; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240524 FOR VALUES FROM ('2024-05-24 00:00:00') TO ('2024-05-25 00:00:00');


--
-- Name: haalcentraal_vraag_20240525; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240525 FOR VALUES FROM ('2024-05-25 00:00:00') TO ('2024-05-26 00:00:00');


--
-- Name: haalcentraal_vraag_20240526; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240526 FOR VALUES FROM ('2024-05-26 00:00:00') TO ('2024-05-27 00:00:00');


--
-- Name: haalcentraal_vraag_20240527; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240527 FOR VALUES FROM ('2024-05-27 00:00:00') TO ('2024-05-28 00:00:00');


--
-- Name: haalcentraal_vraag_20240528; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240528 FOR VALUES FROM ('2024-05-28 00:00:00') TO ('2024-05-29 00:00:00');


--
-- Name: haalcentraal_vraag_20240529; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240529 FOR VALUES FROM ('2024-05-29 00:00:00') TO ('2024-05-30 00:00:00');


--
-- Name: haalcentraal_vraag_20240530; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240530 FOR VALUES FROM ('2024-05-30 00:00:00') TO ('2024-05-31 00:00:00');


--
-- Name: haalcentraal_vraag_20240531; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240531 FOR VALUES FROM ('2024-05-31 00:00:00') TO ('2024-06-01 00:00:00');


--
-- Name: haalcentraal_vraag_20240601; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240601 FOR VALUES FROM ('2024-06-01 00:00:00') TO ('2024-06-02 00:00:00');


--
-- Name: haalcentraal_vraag_20240602; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240602 FOR VALUES FROM ('2024-06-02 00:00:00') TO ('2024-06-03 00:00:00');


--
-- Name: haalcentraal_vraag_20240603; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240603 FOR VALUES FROM ('2024-06-03 00:00:00') TO ('2024-06-04 00:00:00');


--
-- Name: haalcentraal_vraag_20240604; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240604 FOR VALUES FROM ('2024-06-04 00:00:00') TO ('2024-06-05 00:00:00');


--
-- Name: haalcentraal_vraag_20240605; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240605 FOR VALUES FROM ('2024-06-05 00:00:00') TO ('2024-06-06 00:00:00');


--
-- Name: haalcentraal_vraag_20240606; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240606 FOR VALUES FROM ('2024-06-06 00:00:00') TO ('2024-06-07 00:00:00');


--
-- Name: haalcentraal_vraag_20240607; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240607 FOR VALUES FROM ('2024-06-07 00:00:00') TO ('2024-06-08 00:00:00');


--
-- Name: haalcentraal_vraag_20240608; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240608 FOR VALUES FROM ('2024-06-08 00:00:00') TO ('2024-06-09 00:00:00');


--
-- Name: haalcentraal_vraag_20240609; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240609 FOR VALUES FROM ('2024-06-09 00:00:00') TO ('2024-06-10 00:00:00');


--
-- Name: haalcentraal_vraag_20240610; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240610 FOR VALUES FROM ('2024-06-10 00:00:00') TO ('2024-06-11 00:00:00');


--
-- Name: haalcentraal_vraag_20240611; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240611 FOR VALUES FROM ('2024-06-11 00:00:00') TO ('2024-06-12 00:00:00');


--
-- Name: haalcentraal_vraag_20240612; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240612 FOR VALUES FROM ('2024-06-12 00:00:00') TO ('2024-06-13 00:00:00');


--
-- Name: haalcentraal_vraag_20240613; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240613 FOR VALUES FROM ('2024-06-13 00:00:00') TO ('2024-06-14 00:00:00');


--
-- Name: haalcentraal_vraag_20240614; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240614 FOR VALUES FROM ('2024-06-14 00:00:00') TO ('2024-06-15 00:00:00');


--
-- Name: haalcentraal_vraag_20240615; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240615 FOR VALUES FROM ('2024-06-15 00:00:00') TO ('2024-06-16 00:00:00');


--
-- Name: haalcentraal_vraag_20240616; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240616 FOR VALUES FROM ('2024-06-16 00:00:00') TO ('2024-06-17 00:00:00');


--
-- Name: haalcentraal_vraag_20240617; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240617 FOR VALUES FROM ('2024-06-17 00:00:00') TO ('2024-06-18 00:00:00');


--
-- Name: haalcentraal_vraag_20240618; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240618 FOR VALUES FROM ('2024-06-18 00:00:00') TO ('2024-06-19 00:00:00');


--
-- Name: haalcentraal_vraag_20240619; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240619 FOR VALUES FROM ('2024-06-19 00:00:00') TO ('2024-06-20 00:00:00');


--
-- Name: haalcentraal_vraag_20240620; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240620 FOR VALUES FROM ('2024-06-20 00:00:00') TO ('2024-06-21 00:00:00');


--
-- Name: haalcentraal_vraag_20240621; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240621 FOR VALUES FROM ('2024-06-21 00:00:00') TO ('2024-06-22 00:00:00');


--
-- Name: haalcentraal_vraag_20240622; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240622 FOR VALUES FROM ('2024-06-22 00:00:00') TO ('2024-06-23 00:00:00');


--
-- Name: haalcentraal_vraag_20240623; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240623 FOR VALUES FROM ('2024-06-23 00:00:00') TO ('2024-06-24 00:00:00');


--
-- Name: haalcentraal_vraag_20240624; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240624 FOR VALUES FROM ('2024-06-24 00:00:00') TO ('2024-06-25 00:00:00');


--
-- Name: haalcentraal_vraag_20240625; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240625 FOR VALUES FROM ('2024-06-25 00:00:00') TO ('2024-06-26 00:00:00');


--
-- Name: haalcentraal_vraag_20240626; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240626 FOR VALUES FROM ('2024-06-26 00:00:00') TO ('2024-06-27 00:00:00');


--
-- Name: haalcentraal_vraag_20240627; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240627 FOR VALUES FROM ('2024-06-27 00:00:00') TO ('2024-06-28 00:00:00');


--
-- Name: haalcentraal_vraag_20240628; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240628 FOR VALUES FROM ('2024-06-28 00:00:00') TO ('2024-06-29 00:00:00');


--
-- Name: haalcentraal_vraag_20240629; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240629 FOR VALUES FROM ('2024-06-29 00:00:00') TO ('2024-06-30 00:00:00');


--
-- Name: haalcentraal_vraag_20240630; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240630 FOR VALUES FROM ('2024-06-30 00:00:00') TO ('2024-07-01 00:00:00');


--
-- Name: haalcentraal_vraag_20240701; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240701 FOR VALUES FROM ('2024-07-01 00:00:00') TO ('2024-07-02 00:00:00');


--
-- Name: haalcentraal_vraag_20240702; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240702 FOR VALUES FROM ('2024-07-02 00:00:00') TO ('2024-07-03 00:00:00');


--
-- Name: haalcentraal_vraag_20240703; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240703 FOR VALUES FROM ('2024-07-03 00:00:00') TO ('2024-07-04 00:00:00');


--
-- Name: haalcentraal_vraag_20240704; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240704 FOR VALUES FROM ('2024-07-04 00:00:00') TO ('2024-07-05 00:00:00');


--
-- Name: haalcentraal_vraag_20240705; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240705 FOR VALUES FROM ('2024-07-05 00:00:00') TO ('2024-07-06 00:00:00');


--
-- Name: haalcentraal_vraag_20240706; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240706 FOR VALUES FROM ('2024-07-06 00:00:00') TO ('2024-07-07 00:00:00');


--
-- Name: haalcentraal_vraag_20240707; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240707 FOR VALUES FROM ('2024-07-07 00:00:00') TO ('2024-07-08 00:00:00');


--
-- Name: haalcentraal_vraag_20240708; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240708 FOR VALUES FROM ('2024-07-08 00:00:00') TO ('2024-07-09 00:00:00');


--
-- Name: haalcentraal_vraag_20240709; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240709 FOR VALUES FROM ('2024-07-09 00:00:00') TO ('2024-07-10 00:00:00');


--
-- Name: haalcentraal_vraag_20240710; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240710 FOR VALUES FROM ('2024-07-10 00:00:00') TO ('2024-07-11 00:00:00');


--
-- Name: haalcentraal_vraag_20240711; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240711 FOR VALUES FROM ('2024-07-11 00:00:00') TO ('2024-07-12 00:00:00');


--
-- Name: haalcentraal_vraag_20240712; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240712 FOR VALUES FROM ('2024-07-12 00:00:00') TO ('2024-07-13 00:00:00');


--
-- Name: haalcentraal_vraag_20240713; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240713 FOR VALUES FROM ('2024-07-13 00:00:00') TO ('2024-07-14 00:00:00');


--
-- Name: haalcentraal_vraag_20240714; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240714 FOR VALUES FROM ('2024-07-14 00:00:00') TO ('2024-07-15 00:00:00');


--
-- Name: haalcentraal_vraag_20240715; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240715 FOR VALUES FROM ('2024-07-15 00:00:00') TO ('2024-07-16 00:00:00');


--
-- Name: haalcentraal_vraag_20240716; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240716 FOR VALUES FROM ('2024-07-16 00:00:00') TO ('2024-07-17 00:00:00');


--
-- Name: haalcentraal_vraag_20240717; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240717 FOR VALUES FROM ('2024-07-17 00:00:00') TO ('2024-07-18 00:00:00');


--
-- Name: haalcentraal_vraag_20240718; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240718 FOR VALUES FROM ('2024-07-18 00:00:00') TO ('2024-07-19 00:00:00');


--
-- Name: haalcentraal_vraag_20240719; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240719 FOR VALUES FROM ('2024-07-19 00:00:00') TO ('2024-07-20 00:00:00');


--
-- Name: haalcentraal_vraag_20240720; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240720 FOR VALUES FROM ('2024-07-20 00:00:00') TO ('2024-07-21 00:00:00');


--
-- Name: haalcentraal_vraag_20240721; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240721 FOR VALUES FROM ('2024-07-21 00:00:00') TO ('2024-07-22 00:00:00');


--
-- Name: haalcentraal_vraag_20240722; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240722 FOR VALUES FROM ('2024-07-22 00:00:00') TO ('2024-07-23 00:00:00');


--
-- Name: haalcentraal_vraag_20240723; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240723 FOR VALUES FROM ('2024-07-23 00:00:00') TO ('2024-07-24 00:00:00');


--
-- Name: haalcentraal_vraag_20240724; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240724 FOR VALUES FROM ('2024-07-24 00:00:00') TO ('2024-07-25 00:00:00');


--
-- Name: haalcentraal_vraag_20240725; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240725 FOR VALUES FROM ('2024-07-25 00:00:00') TO ('2024-07-26 00:00:00');


--
-- Name: haalcentraal_vraag_20240726; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240726 FOR VALUES FROM ('2024-07-26 00:00:00') TO ('2024-07-27 00:00:00');


--
-- Name: haalcentraal_vraag_20240727; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240727 FOR VALUES FROM ('2024-07-27 00:00:00') TO ('2024-07-28 00:00:00');


--
-- Name: haalcentraal_vraag_20240728; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240728 FOR VALUES FROM ('2024-07-28 00:00:00') TO ('2024-07-29 00:00:00');


--
-- Name: haalcentraal_vraag_20240729; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240729 FOR VALUES FROM ('2024-07-29 00:00:00') TO ('2024-07-30 00:00:00');


--
-- Name: haalcentraal_vraag_20240730; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240730 FOR VALUES FROM ('2024-07-30 00:00:00') TO ('2024-07-31 00:00:00');


--
-- Name: haalcentraal_vraag_20240731; Type: TABLE ATTACH; Schema: tbl_partitions; Owner: haalcentraal
--

ALTER TABLE ONLY public.haalcentraal_vraag ATTACH PARTITION tbl_partitions.haalcentraal_vraag_20240731 FOR VALUES FROM ('2024-07-31 00:00:00') TO ('2024-08-01 00:00:00');


--
-- Name: lo3_adres lo3_adres_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_adres
    ADD CONSTRAINT lo3_adres_pk PRIMARY KEY (adres_id);


--
-- Name: lo3_autorisatie lo3_autorisatie_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_autorisatie
    ADD CONSTRAINT lo3_autorisatie_pk PRIMARY KEY (autorisatie_id);


--
-- Name: lo3_gemeente lo3_gemeente_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gemeente
    ADD CONSTRAINT lo3_gemeente_pk PRIMARY KEY (gemeente_code);


--
-- Name: lo3_gezagsverhouding lo3_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gezagsverhouding
    ADD CONSTRAINT lo3_gezagsverhouding_pk PRIMARY KEY (gezagsverhouding_code);


--
-- Name: lo3_land lo3_land_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_land
    ADD CONSTRAINT lo3_land_pk PRIMARY KEY (land_code);


--
-- Name: lo3_nationaliteit lo3_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nationaliteit
    ADD CONSTRAINT lo3_nationaliteit_pk PRIMARY KEY (nationaliteit_code);


--
-- Name: lo3_nl_nat_verkrijg_verlies_reden lo3_nl_nat_verkrijg_verlies_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_nat_verkrijg_verlies_reden
    ADD CONSTRAINT lo3_nl_nat_verkrijg_verlies_reden_pk PRIMARY KEY (nl_nat_verkrijg_verlies_reden);


--
-- Name: lo3_pl_gezagsverhouding lo3_pl_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_gezagsverhouding
    ADD CONSTRAINT lo3_pl_gezagsverhouding_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_nationaliteit lo3_pl_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_nationaliteit
    ADD CONSTRAINT lo3_pl_nationaliteit_pk PRIMARY KEY (pl_id, stapel_nr, volg_nr);


--
-- Name: lo3_pl_overlijden lo3_pl_overlijden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_overlijden
    ADD CONSTRAINT lo3_pl_overlijden_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_persoon lo3_pl_persoon_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_persoon
    ADD CONSTRAINT lo3_pl_persoon_pk PRIMARY KEY (pl_id, persoon_type, stapel_nr, volg_nr);

ALTER TABLE public.lo3_pl_persoon CLUSTER ON lo3_pl_persoon_pk;


--
-- Name: lo3_pl lo3_pl_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl
    ADD CONSTRAINT lo3_pl_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_reis_doc lo3_pl_reis_doc_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_reis_doc
    ADD CONSTRAINT lo3_pl_reis_doc_pk PRIMARY KEY (pl_id, stapel_nr);

ALTER TABLE public.lo3_pl_reis_doc CLUSTER ON lo3_pl_reis_doc_pk;


--
-- Name: lo3_pl_verblijfplaats lo3_pl_verblijfplaats_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfplaats
    ADD CONSTRAINT lo3_pl_verblijfplaats_pk PRIMARY KEY (pl_id, volg_nr);

ALTER TABLE public.lo3_pl_verblijfplaats CLUSTER ON lo3_pl_verblijfplaats_pk;


--
-- Name: lo3_pl_verblijfstitel lo3_pl_verblijfstitel_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfstitel
    ADD CONSTRAINT lo3_pl_verblijfstitel_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_relatie_eind_reden lo3_relatie_eind_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_relatie_eind_reden
    ADD CONSTRAINT lo3_relatie_eind_reden_pk PRIMARY KEY (relatie_eind_reden);


--
-- Name: lo3_rni_deelnemer lo3_rni_deelnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_rni_deelnemer
    ADD CONSTRAINT lo3_rni_deelnemer_pk PRIMARY KEY (deelnemer_code);


--
-- Name: lo3_titel_predicaat lo3_titel_predicaat_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_titel_predicaat
    ADD CONSTRAINT lo3_titel_predicaat_pk PRIMARY KEY (titel_predicaat);


--
-- Name: lo3_voorwaarde_regel_aut lo3_voorwaarde_regel_aut_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_voorwaarde_regel_aut
    ADD CONSTRAINT lo3_voorwaarde_regel_aut_pk PRIMARY KEY (voorwaarde_type, autorisatie_id);


--
-- Name: lo3_verblijfstitel_aand verblijfstitel_aand_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_verblijfstitel_aand
    ADD CONSTRAINT verblijfstitel_aand_pk PRIMARY KEY (verblijfstitel_aand);


--
-- Name: lo3_adres_hc_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_hc_idx_1 ON public.lo3_adres USING btree (verblijf_plaats_ident_code) WHERE (verblijf_plaats_ident_code IS NOT NULL);


--
-- Name: lo3_adres_hc_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_hc_idx_2 ON public.lo3_adres USING btree (lower((straat_naam)::text) text_pattern_ops, huis_nr, lower((huis_letter)::text) text_pattern_ops, lower((huis_nr_toevoeging)::text) text_pattern_ops);


--
-- Name: lo3_adres_hc_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_hc_idx_3 ON public.lo3_adres USING btree (nummer_aand_ident_code) WHERE (nummer_aand_ident_code IS NOT NULL);


--
-- Name: lo3_adres_hc_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_hc_idx_4 ON public.lo3_adres USING btree (lower((open_ruimte_naam)::text) text_pattern_ops, huis_nr, lower((huis_letter)::text) text_pattern_ops, lower((huis_nr_toevoeging)::text) text_pattern_ops) WHERE (open_ruimte_naam IS NOT NULL);


--
-- Name: lo3_adres_idx_5; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_5 ON public.lo3_adres USING btree (verblijf_plaats_ident_code, adres_id);


--
-- Name: lo3_autorisatie_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_autorisatie_idx_0 ON public.lo3_autorisatie USING btree (afnemer_code, tabel_regel_start_datum);


--
-- Name: lo3_pl_persoon_hc_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_hc_idx_1 ON public.lo3_pl_persoon USING btree (lower((geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops, lower((diak_voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_hc_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_hc_idx_2 ON public.lo3_pl_persoon USING btree (geboorte_datum, lower((geslachts_naam)::text) text_pattern_ops, lower((diak_geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_hc_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_hc_idx_3 ON public.lo3_pl_persoon USING btree (lower((diak_geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops, lower((diak_voor_naam)::text) text_pattern_ops) WHERE (diak_geslachts_naam IS NOT NULL);


--
-- Name: lo3_pl_persoon_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_pl_persoon_idx_0 ON public.lo3_pl_persoon USING btree (a_nr) WHERE ((persoon_type = 'P'::bpchar) AND (stapel_nr = 0) AND (volg_nr = 0));


--
-- Name: lo3_pl_persoon_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_2 ON public.lo3_pl_persoon USING btree (burger_service_nr, persoon_type, stapel_nr, volg_nr);


--
-- Name: lo3_pl_reis_doc_hc_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_reis_doc_hc_idx_1 ON public.lo3_pl_reis_doc USING btree (nl_reis_doc_nr);


--
-- Name: lo3_pl_verblijfplaats_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_1 ON public.lo3_pl_verblijfplaats USING btree (inschrijving_gemeente_code, volg_nr, geldigheid_start_datum);


--
-- Name: lo3_pl_verblijfplaats_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_2 ON public.lo3_pl_verblijfplaats USING btree (adres_id, volg_nr, geldigheid_start_datum);


--
-- PostgreSQL database dump complete
--

