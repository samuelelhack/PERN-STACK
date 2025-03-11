--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-03-10 14:07:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'LATIN9';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 231 (class 1255 OID 24577)
-- Name: actualizar_estado_solicitud(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_estado_solicitud() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    aprobaciones_count INT;
    rechazos_count INT;
BEGIN
    -- Contar cuántas veces la solicitud ha sido aprobada
    SELECT COUNT(*) INTO aprobaciones_count
    FROM decisiones
    WHERE id_solicitud = NEW.id_solicitud AND decision = 'aprobado';

    -- Contar cuántas veces la solicitud ha sido rechazada
    SELECT COUNT(*) INTO rechazos_count
    FROM decisiones
    WHERE id_solicitud = NEW.id_solicitud AND decision = 'rechazado';

    -- Si hay al menos 2 aprobaciones, cambiar el estado de la solicitud a 'aprobado'
    IF aprobaciones_count >= 2 THEN
        UPDATE solicitudes SET estado = 'aprobada' WHERE id_solicitud = NEW.id_solicitud;
    
    -- Si hay al menos 2 rechazos, cambiar el estado de la solicitud a 'rechazado'
    ELSIF rechazos_count >= 2 THEN
        UPDATE solicitudes SET estado = 'rechazada' WHERE id_solicitud = NEW.id_solicitud;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_estado_solicitud() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24578)
-- Name: decisiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.decisiones (
    id_decision integer NOT NULL,
    id_solicitud integer,
    id_usuario integer,
    decision character varying(10) NOT NULL,
    fecha_aprobacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT aprobaciones_decision_check CHECK (((decision)::text = ANY (ARRAY[('aprobado'::character varying)::text, ('rechazado'::character varying)::text])))
);


ALTER TABLE public.decisiones OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24583)
-- Name: aprobaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aprobaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aprobaciones_id_seq OWNER TO postgres;

--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 218
-- Name: aprobaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aprobaciones_id_seq OWNED BY public.decisiones.id_decision;


--
-- TOC entry 219 (class 1259 OID 24584)
-- Name: cod_herramientas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cod_herramientas (
    cod_herramienta integer NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.cod_herramientas OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24587)
-- Name: equipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipos (
    id_equipo integer NOT NULL,
    tipo character varying(50) NOT NULL,
    marca character varying(50),
    modelo character varying(50),
    serie character varying(50) NOT NULL
);


ALTER TABLE public.equipos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24590)
-- Name: electrodomesticos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.electrodomesticos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.electrodomesticos_id_seq OWNER TO postgres;

--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 221
-- Name: electrodomesticos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.electrodomesticos_id_seq OWNED BY public.equipos.id_equipo;


--
-- TOC entry 222 (class 1259 OID 24591)
-- Name: herramientas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.herramientas (
    id_herramienta integer NOT NULL,
    cod_herramientas integer,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.herramientas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24594)
-- Name: herramientas_cod_herramienta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.herramientas_cod_herramienta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.herramientas_cod_herramienta_seq OWNER TO postgres;

--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 223
-- Name: herramientas_cod_herramienta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.herramientas_cod_herramienta_seq OWNED BY public.cod_herramientas.cod_herramienta;


--
-- TOC entry 224 (class 1259 OID 24595)
-- Name: herramientas_id_herramienta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.herramientas_id_herramienta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.herramientas_id_herramienta_seq OWNER TO postgres;

--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 224
-- Name: herramientas_id_herramienta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.herramientas_id_herramienta_seq OWNED BY public.herramientas.id_herramienta;


--
-- TOC entry 225 (class 1259 OID 24596)
-- Name: justificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.justificacion (
    id_justificacion integer NOT NULL,
    id_decision integer,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.justificacion OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24599)
-- Name: justificacion_id_justificacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.justificacion_id_justificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.justificacion_id_justificacion_seq OWNER TO postgres;

--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 226
-- Name: justificacion_id_justificacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.justificacion_id_justificacion_seq OWNED BY public.justificacion.id_justificacion;


--
-- TOC entry 227 (class 1259 OID 24600)
-- Name: solicitudes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes (
    id_solicitud integer NOT NULL,
    id_usuario integer,
    id_equipo integer,
    descripcion text NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    afecta boolean,
    fecha_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_fin timestamp without time zone,
    actividad character varying(100),
    motivo character varying(100),
    cod_herramienta integer,
    uso_vehiculo boolean,
    CONSTRAINT solicitudes_estado_check CHECK (((estado)::text = ANY (ARRAY[('pendiente'::character varying)::text, ('aprobada'::character varying)::text, ('rechazada'::character varying)::text])))
);


ALTER TABLE public.solicitudes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24609)
-- Name: solicitudes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solicitudes_id_seq OWNER TO postgres;

--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 228
-- Name: solicitudes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_id_seq OWNED BY public.solicitudes.id_solicitud;


--
-- TOC entry 229 (class 1259 OID 24610)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    rol character varying(20) NOT NULL,
    clave text NOT NULL,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY (ARRAY[('presidente'::character varying)::text, ('vicepresidente'::character varying)::text, ('gerente'::character varying)::text, ('analista'::character varying)::text])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24616)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 230
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4674 (class 2604 OID 24617)
-- Name: cod_herramientas cod_herramienta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cod_herramientas ALTER COLUMN cod_herramienta SET DEFAULT nextval('public.herramientas_cod_herramienta_seq'::regclass);


--
-- TOC entry 4672 (class 2604 OID 24618)
-- Name: decisiones id_decision; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decisiones ALTER COLUMN id_decision SET DEFAULT nextval('public.aprobaciones_id_seq'::regclass);


--
-- TOC entry 4675 (class 2604 OID 24619)
-- Name: equipos id_equipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos ALTER COLUMN id_equipo SET DEFAULT nextval('public.electrodomesticos_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 24620)
-- Name: herramientas id_herramienta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.herramientas ALTER COLUMN id_herramienta SET DEFAULT nextval('public.herramientas_id_herramienta_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 24621)
-- Name: justificacion id_justificacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justificacion ALTER COLUMN id_justificacion SET DEFAULT nextval('public.justificacion_id_justificacion_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 24622)
-- Name: solicitudes id_solicitud; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes ALTER COLUMN id_solicitud SET DEFAULT nextval('public.solicitudes_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 24623)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4860 (class 0 OID 24584)
-- Dependencies: 219
-- Data for Name: cod_herramientas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cod_herramientas (cod_herramienta, descripcion) FROM stdin;
1	MARTILLO
\.


--
-- TOC entry 4858 (class 0 OID 24578)
-- Dependencies: 217
-- Data for Name: decisiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.decisiones (id_decision, id_solicitud, id_usuario, decision, fecha_aprobacion) FROM stdin;
15	1	2	aprobado	2025-02-19 16:29:21.310086
16	1	3	aprobado	2025-02-19 16:29:21.310086
17	2	2	aprobado	2025-02-19 16:45:10.350514
18	2	3	aprobado	2025-02-19 16:45:10.350514
32	10	2	aprobado	2025-02-24 14:41:35.164287
33	10	3	aprobado	2025-02-24 14:41:35.164287
\.


--
-- TOC entry 4861 (class 0 OID 24587)
-- Dependencies: 220
-- Data for Name: equipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipos (id_equipo, tipo, marca, modelo, serie) FROM stdin;
1	Refrigerador	Samsung	RT29	SN12345
2	Lavadora	LG	TwinWash	SN67890
\.


--
-- TOC entry 4863 (class 0 OID 24591)
-- Dependencies: 222
-- Data for Name: herramientas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.herramientas (id_herramienta, cod_herramientas, descripcion) FROM stdin;
\.


--
-- TOC entry 4866 (class 0 OID 24596)
-- Dependencies: 225
-- Data for Name: justificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.justificacion (id_justificacion, id_decision, descripcion) FROM stdin;
\.


--
-- TOC entry 4868 (class 0 OID 24600)
-- Dependencies: 227
-- Data for Name: solicitudes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes (id_solicitud, id_usuario, id_equipo, descripcion, fecha_creacion, estado, afecta, fecha_inicio, fecha_fin, actividad, motivo, cod_herramienta, uso_vehiculo) FROM stdin;
5	1	2	Revision de pc	2025-02-19 16:16:52.788439	pendiente	\N	2025-02-20 23:25:45.166059	\N	\N	\N	\N	\N
4	1	1	Revisión del refrigerador	2025-02-19 15:53:50.346294	aprobada	\N	2025-02-20 23:25:45.166059	\N	\N	\N	\N	\N
11	3	2	se realizara reparacion	2025-02-24 14:21:55.247015	pendiente	t	2025-02-24 14:21:55.247015	2025-02-26 00:00:00	REPARO	NOSE	1	f
10	3	1	se realizara reparacion	2025-02-24 14:21:55.247015	aprobada	t	2025-02-24 14:21:55.247015	2025-02-26 00:00:00	REPARO	NOSE	1	f
\.


--
-- TOC entry 4870 (class 0 OID 24610)
-- Dependencies: 229
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, correo, rol, clave) FROM stdin;
1	Juan Pérez	juan@empresa.com	analista	clave123
2	Ana Gómez	ana@empresa.com	presidente	clave123
3	Luis Rodríguez	luis@empresa.com	vicepresidente	clave123
4	Marta Silva	marta@empresa.com	gerente	clave123
\.


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 218
-- Name: aprobaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aprobaciones_id_seq', 33, true);


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 221
-- Name: electrodomesticos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.electrodomesticos_id_seq', 2, true);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 223
-- Name: herramientas_cod_herramienta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.herramientas_cod_herramienta_seq', 1, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 224
-- Name: herramientas_id_herramienta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.herramientas_id_herramienta_seq', 1, false);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 226
-- Name: justificacion_id_justificacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.justificacion_id_justificacion_seq', 1, false);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 228
-- Name: solicitudes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_id_seq', 11, true);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 230
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 4, true);


--
-- TOC entry 4687 (class 2606 OID 24625)
-- Name: decisiones aprobaciones_id_solicitud_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decisiones
    ADD CONSTRAINT aprobaciones_id_solicitud_id_usuario_key UNIQUE (id_solicitud, id_usuario);


--
-- TOC entry 4689 (class 2606 OID 24627)
-- Name: decisiones aprobaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decisiones
    ADD CONSTRAINT aprobaciones_pkey PRIMARY KEY (id_decision);


--
-- TOC entry 4693 (class 2606 OID 24629)
-- Name: equipos electrodomesticos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT electrodomesticos_pkey PRIMARY KEY (id_equipo);


--
-- TOC entry 4695 (class 2606 OID 24631)
-- Name: equipos electrodomesticos_serie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT electrodomesticos_serie_key UNIQUE (serie);


--
-- TOC entry 4691 (class 2606 OID 24633)
-- Name: cod_herramientas herramientas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cod_herramientas
    ADD CONSTRAINT herramientas_pkey PRIMARY KEY (cod_herramienta);


--
-- TOC entry 4697 (class 2606 OID 24635)
-- Name: herramientas herramientas_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.herramientas
    ADD CONSTRAINT herramientas_pkey1 PRIMARY KEY (id_herramienta);


--
-- TOC entry 4699 (class 2606 OID 24637)
-- Name: justificacion justificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justificacion
    ADD CONSTRAINT justificacion_pkey PRIMARY KEY (id_justificacion);


--
-- TOC entry 4701 (class 2606 OID 24639)
-- Name: solicitudes solicitudes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes
    ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id_solicitud);


--
-- TOC entry 4703 (class 2606 OID 24641)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 4705 (class 2606 OID 24643)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4712 (class 2620 OID 24644)
-- Name: decisiones trigger_actualizar_estado; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_actualizar_estado AFTER INSERT ON public.decisiones FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado_solicitud();


--
-- TOC entry 4706 (class 2606 OID 24645)
-- Name: decisiones aprobaciones_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decisiones
    ADD CONSTRAINT aprobaciones_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- TOC entry 4707 (class 2606 OID 24650)
-- Name: herramientas herramientas_cod_herramientas_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.herramientas
    ADD CONSTRAINT herramientas_cod_herramientas_fkey FOREIGN KEY (cod_herramientas) REFERENCES public.cod_herramientas(cod_herramienta) ON DELETE CASCADE;


--
-- TOC entry 4708 (class 2606 OID 24655)
-- Name: justificacion justificacion_id_decision_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justificacion
    ADD CONSTRAINT justificacion_id_decision_fkey FOREIGN KEY (id_decision) REFERENCES public.decisiones(id_decision) ON DELETE CASCADE;


--
-- TOC entry 4709 (class 2606 OID 24660)
-- Name: solicitudes solicitudes_cod_herramienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes
    ADD CONSTRAINT solicitudes_cod_herramienta_fkey FOREIGN KEY (cod_herramienta) REFERENCES public.cod_herramientas(cod_herramienta) ON DELETE CASCADE;


--
-- TOC entry 4710 (class 2606 OID 24665)
-- Name: solicitudes solicitudes_id_electrodomestico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes
    ADD CONSTRAINT solicitudes_id_electrodomestico_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipos(id_equipo) ON DELETE CASCADE;


--
-- TOC entry 4711 (class 2606 OID 24670)
-- Name: solicitudes solicitudes_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes
    ADD CONSTRAINT solicitudes_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id) ON DELETE SET NULL;


-- Completed on 2025-03-10 14:07:08

--
-- PostgreSQL database dump complete
--

