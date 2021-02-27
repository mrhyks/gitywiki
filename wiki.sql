--
-- PostgreSQL database dump
--

-- Dumped from database version 11.10 (Debian 11.10-0+deb10u1)
-- Dumped by pg_dump version 11.10 (Debian 11.10-0+deb10u1)

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: analytics; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wikijs;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wikijs;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wikijs;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wikijs
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wikijs;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wikijs;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wikijs;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wikijs;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wikijs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wikijs;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wikijs;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wikijs;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wikijs;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wikijs;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wikijs;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wikijs;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wikijs;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wikijs;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wikijs;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wikijs;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wikijs;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":""}
statcounter	f	{"projectId":"","securityToken":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetData" (id, data) FROM stdin;
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
1	dasfads	2021-02-26T18:58:58.665Z	2021-02-26T18:58:58.665Z	2	3	<p>dasfads</p>\n	Operátor	operator@gity.eu	192.168.4.242	0
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2021-02-26T17:25:53.426Z	2021-02-26T17:25:53.426Z	/
2	Guests	["read:pages","read:assets","read:comments"]	[{"id":"guest","roles":["read:pages","read:assets","read:comments"],"match":"START","deny":false,"path":"","locales":[]}]	t	2021-02-26T17:25:53.456Z	2021-02-26T17:25:53.456Z	/
3	DC Gity	["read:pages","read:assets","read:comments","write:comments","manage:comments","manage:assets","write:assets","read:history","read:source","write:scripts","write:styles","delete:pages","manage:pages","write:pages"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"","locales":[]}]	f	2021-02-26T18:57:08.015Z	2021-02-26T18:58:18.751Z	/
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Table of Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options"},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2021-02-26T17:25:53.394Z	2021-02-26T17:46:20.751Z
cs	{"common":{"footer":{"poweredBy":"Běží na","copyright":"© {{year}} {{company}} . Všechna práva vyhrazena.","license":"Obsah je k dispozici na základě {{license}} od {{company}} ."},"actions":{"save":"Uložit","cancel":"Zrušit","download":"Stáhnout","upload":"Nahrát","discard":"Zrušit","clear":"Vymazat","create":"Vytvořit","edit":"Upravit","delete":"Odstranit","refresh":"Obnovit","saveChanges":"Uložit změny","proceed":"Pokračovat","ok":"OK","add":"Přidat","apply":"Použít","browse":"Procházet...","close":"Zavřít","page":"Stránka","discardChanges":"Zrušit změny","move":"Přesunout","rename":"Přejmenovat","optimize":"Optimalizovat","preview":"Náhled","properties":"Vlastnosti","insert":"Vložit","fetch":"Načtení","generate":"Generovat","confirm":"Potvrdit","copy":"Kopírovat","returnToTop":"Vrátit se nahoru","exit":"Ukončit","select":"Vybrat"},"newpage":{"title":"Tato stránka ještě neexistuje.","subtitle":"Chcete ji nyní vytvořit?","create":"Vytvořit stránku","goback":"Jít zpět"},"unauthorized":{"title":"Neoprávněno","action":{"view":"Nemůžete si zobrazit tuto stránku.","source":"Nemůžete si zobrazit zdroj této stránky.","history":"Nemůžete si zobrazit historii stránky.","edit":"Nemůžete upravit stránku.","create":"Nemůžete vytvořit stránku.","download":"Obsah stránky nelze stáhnout.","downloadVersion":"Tuto verzi stránky nemůžete stáhnout.","sourceVersion":"Nemůžete zobrazit zdrojový kód této verze stránky."},"goback":"Jít zpět","login":"Přihlásit se jako..."},"notfound":{"gohome":"Domů","title":"Nenalezeno","subtitle":"Tato stránka neexistuje."},"welcome":{"title":"Vítejte na Vaší wiki!","subtitle":"Začněme a vytvoříme domovskou stránku.","createhome":"Vytvořit domovskou stránku"},"header":{"home":"Domů","newPage":"Nová stránka","currentPage":"Aktuální stránka","view":"Zobrazit","edit":"Upravit","history":"Historie","viewSource":"Zobrazit zdroj","move":"Přesunout / přejmenovat","delete":"Odstranit","assets":"Objekty","imagesFiles":"Obrázky a soubory","search":"Hledat...","admin":"Správa","account":"Účet","myWiki":"Moje Wiki","profile":"Profil","logout":"Odhlásit se","login":"Přihlásit se","searchHint":"Chcete-li zahájit hledání, zadejte alespoň 2 znaky...","searchLoading":"Vyhledávání...","searchNoResult":"Vašemu dotazu neodpovídají žádné stránky.","searchResultsCount":"Nalezeno {{total}} výsledků","searchDidYouMean":"Mysleli jste...","searchClose":"Zavřít","searchCopyLink":"Kopírovat Odkaz hledání","language":"Jazyk","browseTags":"Procházet podle tagů","siteMap":"Mapa stránky","pageActions":"Akce stránky","duplicate":"Duplikát"},"page":{"lastEditedBy":"Naposledy upravil","unpublished":"Nepublikované","editPage":"Upravit stránku","toc":"Obsah","bookmark":"Záložka","share":"Sdílet","printFormat":"Formát tisku","delete":"Odstranit stránku","deleteTitle":"Opravdu chcete odstranit stránku {{title}}?","deleteSubtitle":"Stránku lze obnovit z administrační oblasti.","viewingSource":"Prohlížení zdroje stránky {{path}}","returnNormalView":"Návrat do Normálního Zobrazení","id":"ID {{id}}","published":"Publikováno","private":"Soukromé","global":"Globální","loading":"Načítání stránky...","viewingSourceVersion":"Prohlížení zdroje od {{date}} stránky {{path}}","versionId":"ID verze {{id}}","unpublishedWarning":"Tato stránka není publikována.","tags":"Tagy","tagsMatching":"Stránky odpovídající tagům"},"error":{"unexpected":"Došlo k neočekáváné chybě."},"password":{"veryWeak":"Velmi slabé","weak":"Slabé","average":"Průměrné","strong":"Silné","veryStrong":"Velmi silné"},"user":{"search":"Hledat uživatele","searchPlaceholder":"Vyhledat uživatele..."},"duration":{"every":"Každý","minutes":"Minuty","hours":"Hodiny","days":"Den(dny)","months":"Měsíc(e)","years":"Rok(y)"},"outdatedBrowserWarning":"Váš prohlížeč je zastaralý. Přejděte na {{modernBrowser}}.","modernBrowser":"moderní prohlížeč","license":{"none":"Žádný","ccby":"Licence Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Licence Creative Commons typu Uvedení autora - nekomerční licence - licence NoDerivs","cc0":"Veřejná doména","alr":"Všechna práva vyhrazena"},"sidebar":{"browse":"Procházet","mainMenu":"Hlavní menu","currentDirectory":"Aktuální adresář","root":"Hlavní složka"},"comments":{"title":"Komentáře","newPlaceholder":"Napište nový komentář...","fieldName":"Vaše jméno","fieldEmail":"Vaše e-mailová adresa","markdownFormat":"Formát Markdown","postComment":"Přidat komentář","loading":"Načítání komentářů...","postingAs":"Přidat komentář jako {{name}}","beFirst":"Buďte první komentující.","none":"Doposud nebyly přidány žádné komentáře.","updateComment":"Aktualizovat komentář","deleteConfirmTitle":"Potvrdit odstranění","deleteWarn":"Jste si opravdu jisti, že chcete tento komentář trvale odstranit?","deletePermanentWarn":"Tuto akci nelze vrátit zpět!","modified":"upraveno {{reldate}}","postSuccess":"Nový komentář byl úspěšně přidán.","contentMissingError":"Komentář je prázdný nebo příliš krátký!","updateSuccess":"Komentář byl úspěšně aktualizován.","deleteSuccess":"Komentář byl úspěšně odstraněn.","viewDiscussion":"Zobrazit komentáře","newComment":"Přidat komentář","fieldContent":"Obsah","sdTitle":"Diskutovat"},"pageSelector":{"createTitle":"Vyberte Nové umístění stránky","moveTitle":"Přesunout / přejmenovat umístění stránky","selectTitle":"Vyberte stránku","virtualFolders":"Virtuální složky","pages":"Stránky","folderEmptyWarning":"Tato složka je prázdná."}},"auth":{"loginRequired":"Požadováno přihlášení","fields":{"emailUser":"E-mail / uživatelské jméno","password":"Heslo","email":"E-mailová adresa","verifyPassword":"Ověření hesla","name":"Jméno","username":"Uživatelské jméno"},"actions":{"login":"Přihlásit se","register":"Zaregistrovat se"},"errors":{"invalidLogin":"Neplatné přihlášení","invalidLoginMsg":"E-mail nebo heslo je neplatné.","invalidUserEmail":"Neplatný e-mail uživatele.","loginError":"Chyba při přihlášení","notYetAuthorized":"Nemáte oprávnění k přihlášení k této stránce.","tooManyAttempts":"Příliš mnoho pokusů!","tooManyAttemptsMsg":"Udělali jste příliš mnoho neúspěšných pokusů v krátkém čase, zkuste to znovu za {{time}}.","userNotFound":"Uživatel nenalezen"},"providers":{"local":"Místní","windowslive":"Účet Microsoft","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Dvoufázové ověření","subtitle":"Požadovaný bezpečnostní kód:","placeholder":"XXXXXX","verifyToken":"Ověřit"},"registerTitle":"Vytvořte si účet","switchToLogin":{"text":"Již máte účet? {{link}}","link":"Přihlásit se místo toho"},"loginUsingStrategy":"Přihlásit se pomocí {{strategy}}","forgotPasswordLink":"Zapomněl jste heslo?","orLoginUsingStrategy":"nebo se přihlásit pomocí...","switchToRegister":{"text":"Ještě nemáte účet? {{link}}","link":"Vytvořit účet"},"invalidEmailUsername":"Zadejte platný e-mail / uživatelské jméno.","invalidPassword":"Zadejte platné heslo.","loginSuccess":"Úspěšně přihlášeno! Přesměrování...","signingIn":"Přihlašování...","genericError":"Ověření je nedostupné.","registerSubTitle":"Vyplňte formulář níže a vytvořte si účet.","pleaseWait":"Počkejte prosím","registerSuccess":"Účet byl úspěšně vytvořen!","registering":"Vytváření účtu...","missingEmail":"Chybí e-mailová adresa.","invalidEmail":"E-mailová adresa je neplatná.","missingPassword":"Chybí heslo.","passwordTooShort":"Heslo je příliš krátké.","passwordNotMatch":"Obě hesla se neshodují.","missingName":"Jméno chybí.","nameTooShort":"Jméno je příliš krátké.","nameTooLong":"Jméno je příliš dlouhé.","forgotPasswordCancel":"Zrušit","sendResetPassword":"Obnovit heslo","forgotPasswordSubtitle":"Zadejte svoji e-mailovou adresu pro obdržení instrukcí k obnovení Vašeho hesla:","registerCheckEmail":"Zkontrolujte svoje e-maily pro aktivaci Vašeho účtu.","changePwd":{"subtitle":"Zvolte nové heslo","instructions":"Musíte zvolit nové heslo:","newPasswordPlaceholder":"Nové heslo","newPasswordVerifyPlaceholder":"Potvrďte nové heslo","proceed":"Změnit heslo","loading":"Měnění hesla..."},"forgotPasswordLoading":"Žádání o obnovení hesla...","forgotPasswordSuccess":"Zkontrolujte své e-maily pro pokyny k obnovení hesla!","selectAuthProvider":"Vyberte poskytovatele ověřování","enterCredentials":"Zadejte své přihlašovací údaje","forgotPasswordTitle":"Zapomněli jste heslo","tfaFormTitle":"Zadejte bezpečnostní kód vygenerovaný vaším důvěryhodným zařízením:","tfaSetupTitle":"Váš administrátor vyžaduje, aby bylo na vašem účtu povoleno dvoufaktorové ověřování.","tfaSetupInstrFirst":"1) Naskenujte QR kód níže pomocí vaší mobilní 2FA aplikace:","tfaSetupInstrSecond":"2) Zadejte bezpečnostní kód vygenerovaný z vašeho důvěryhodného zařízení:"},"admin":{"dashboard":{"title":"Řídicí panel","subtitle":"Wiki.js","pages":"Stránky","users":"Uživatelé","groups":"Skupiny","versionLatest":"Používáte nejnovější verzi.","versionNew":"Je dostupná nová verze: {{version}}","contributeSubtitle":"Wiki.js je bezplatný projekt s otevřeným zdrojovým kódem. Je tu několik možností, jak můžete přispět projektu.","contributeHelp":"Potřebujeme vaši pomoc!","contributeLearnMore":"Zjistit více","recentPages":"Poslední stránky","mostPopularPages":"Nejpopulárnější stránky","lastLogins":"Poslední přihlášení"},"general":{"title":"Obecné","subtitle":"Hlavní nastavení Vaší wiki","siteInfo":"Informace o stránce","siteBranding":"Značení stránky","general":"Obecné","siteUrl":"URL Stránky","siteUrlHint":"Úplná adresa URL vaší wiki, bez koncového lomítka. (např. https://wiki.example.com)","siteTitle":"Název Stránky","siteTitleHint":"Zobrazí se v horním panelu a připojí se ke všem titulům metadat.","logo":"Logo","uploadLogo":"Nahrát logo","uploadClear":"Vymazat","uploadSizeHint":"Pro dosažení nejlepších výsledků se doporučuje obrázek o {{size}} pixelů.","uploadTypesHint":"Pouze {{typeList}} nebo {{lastType}} soubory","footerCopyright":"Autorská práva v zápatí","companyName":"Název společnosti / organizace","companyNameHint":"Název, který se použije při zobrazování oznámení o autorských právech v zápatí. Chcete-li skrýt, nechte prázdné.","siteDescription":"Popisek Stránky","siteDescriptionHint":"Výchozí popis, pokud pro stránku není uveden žádný.","metaRobots":"Meta Roboti","metaRobotsHint":"Výchozí: Index, Sledovat. Lze také nastavit na základě jednotlivých stránek.","logoUrl":"URL loga","logoUrlHint":"Určete obrázek, který chcete použít jako logo. Podporovány jsou SVG, PNG, JPG ve čtvercovém poměru 34 x 34 pixelů nebo větší. Kliknutím na tlačítko vpravo nahrajte nový obrázek.","contentLicense":"Licence na obsah","contentLicenseHint":"Licence uvedená v zápatí všech obsahových stránek.","siteTitleInvalidChars":"Název webu obsahuje neplatné znaky.","saveSuccess":"Konfigurace webu úspěšně uložena."},"locale":{"title":"Lokalizace","subtitle":"Nastavte si možnosti lokalizace wiki","settings":"Nastavení lokalizace","namespacing":"Vícejazyčné jmenné prostory","downloadTitle":"Stáhnout lokalizace","base":{"labelWithNS":"Základní lokalizace","hint":"Všechny textové prvky uživatelského rozhraní se zobrazí ve vybraném jazyce.","label":"Lokalizace stránky"},"autoUpdate":{"label":"Aktualizovat automaticky","hintWithNS":"Automaticky stáhnout aktualizace pro všechny lokalizace povolené níže.","hint":"Automaticky stahovat aktualizace tohoto prostředí, jakmile budou k dispozici."},"namespaces":{"label":"Vícejazyčné jmenné prostory","hint":"Umožnit více jazykových verzí stejné stránky."},"activeNamespaces":{"label":"Aktivní jmenné prostory","hint":"Seznam lokalizací je povolen pro vícejazyčné jmenné prostory. Základní lokalizace definovaná výše bude vždy zahrnuta bez ohledu na tento výběr."},"namespacingPrefixWarning":{"title":"Kód lokalizace bude umístěn do všech cest. (např. /{{langCode}}/page-name)","subtitle":"Cesta bez lokalizovaného kódu bude automaticky přesměrována do základní lokalizace definované výše."},"sideload":"Balíček národního prostředí Sideload","sideloadHelp":"Pokud nejste připojeni k internetu nebo nemůžete stahovat soubory lokální soubory pomocí výše uvedené metody, můžete místo toho ručně načíst tyto balíčky nahráním.","code":"Kód","name":"Název","nativeName":"Název v daném jazyce","rtl":"ZprDoLe","availability":"Dostupnost","download":"Stáhnout"},"stats":{"title":"Statistiky"},"theme":{"title":"Vzhled","subtitle":"Upravit vzhled a dojem vaší wiki","siteTheme":"Motiv webové stránky.","siteThemeHint":"Motivy ovlivňují zobrazení stránek obsahu. Ostatní části webu (například editor nebo administrativní oblast) ovlivněny nejsou.","darkMode":"Tmavý režim.","darkModeHint":"Nedoporučuje se pro usnadnění přístupu. Nemusí být podporováno všemi motivy.","codeInjection":"Vkládání kódu","cssOverride":"Přepsání šablon stylů CSS","cssOverrideHint":"Kód CSS, který se má vložit po výchozím nastavení systému CSS. Pokud máte velké množství kódu CSS, zvažte použití vlastních motivů. Vložení příliš mnoho CSS kódu bude mít za následek malej výkon při načítání stránky! Šablona stylů CSS bude automaticky minifikována.","headHtmlInjection":"Vkládání do HTML hlavičky.","headHtmlInjectionHint":"Kód HTML, který se bude vkládat těsně před uzavírací tag HEAD. Obvykle pro tagy skriptů.","bodyHtmlInjection":"Vkládání textu do HTML","bodyHtmlInjectionHint":"Kód HTML, který se bude vkládat těsně před uzavírací tag BODY.","downloadThemes":"Stáhnout motivy","iconset":"Sada ikon","iconsetHint":"Sada ikon pro navigaci na postranním panelu.","downloadName":"Název","downloadAuthor":"Autor","downloadDownload":"Stáhnout","cssOverrideWarning":"{{caution}} Při přidávání stylů pro obsah stránky je nutné je přiřadit k třídě {{cssClass}}. Vynechání této funkce může narušit rozvržení editoru!","cssOverrideWarningCaution":"VAROVÁNÍ:","options":"Možnosti Témy"},"groups":{"title":"Skupiny"},"users":{"title":"Uživatelé","active":"Aktivní","inactive":"Neaktivní","verified":"Ověřeno","unverified":"Neověřeno","edit":"Upravit Uživatele","id":"ID {{id}}","basicInfo":"Základní Info","email":"E-mail","displayName":"Zobrazované Jméno","authentication":"Autentizace","authProvider":"Poskytovatel","password":"Heslo","changePassword":"Změnit Heslo","newPassword":"Nové Heslo","tfa":"Dvoufaktorová Autentizace (2FA)","toggle2FA":"Přepnout 2FA","authProviderId":"ID poskytovatele","groups":"Uživatelské Skupiny","noGroupAssigned":"Tento uživatel zatím není přiřazen k žádné skupině. Uživateli musíte přiřadit alespoň 1 skupinu.","selectGroup":"Vybrat skupinu...","groupAssign":"Přiřadit","extendedMetadata":"Rozšířená metadata","location":"Umístění","jobTitle":"Funkce","timezone":"Časové pásmo","userUpdateSuccess":"Uživatel byl úspěšně aktualizován.","userAlreadyAssignedToGroup":"Uživatel je již přiřazen k této skupině!","deleteConfirmTitle":"Odstranit uživatele?","deleteConfirmText":"Opravdu chcete smazat uživatele {{username}} ?","updateUser":"Aktualizovat uživatele","groupAssignNotice":"Z tohoto panelu nemůžete přiřadit uživatele do skupin Administrators nebo Guests.","deleteConfirmForeignNotice":"Uživatele, který již vytvořil obsah, nemůžete smazat. Místo toho musíte uživatele deaktivovat nebo odstranit veškerý obsah vytvořený tímto uživatelem.","userVerifySuccess":"Uživatel byl úspěšně ověřen.","userActivateSuccess":"Uživatel byl úspěšně aktivován.","userDeactivateSuccess":"Uživatel byl úspěšně deaktivován.","deleteConfirmReplaceWarn":"Jakýkoli obsah (stránky, nahrané soubory, komentáře apod.), který byl vytvořen tímto uživatelem bude přidělen k uživateli níže. Pokud nechcete, aby byl obsah přidělen k současnému aktivnímu uživateli, doporučujeme vytvořit fiktivního cílového uživatele (např. Smazaný uživatel).","userTFADisableSuccess":"2FA bylo úspěšně zakázáno.","userTFAEnableSuccess":"2FA bylo úspěšně povoleno."},"auth":{"title":"Ověření","subtitle":"Nakonfigurujte si nastavení ověřování vaší wiki","strategies":"Strategie","globalAdvSettings":"Globální pokročilá nastavení","jwtAudience":"Publikum JWT","jwtAudienceHint":"Publikum URN použité v JWT vydané při přihlášení. Obvykle název vaší domény. (např. urn: vase.domena.cz)","tokenExpiration":"Vypršení platnosti tokenu","tokenExpirationHint":"Doba platnosti tokenu, dokud není nutné jej obnovit. (výchozí: 30m)","tokenRenewalPeriod":"Interval obnovení tokenu","tokenRenewalPeriodHint":"Maximální doba, po jejiž uplynutí může být token obnoven. (výchozí hodnota: 14d)","strategyState":"Tato strategie je {{state}}{{locked}}","strategyStateActive":"aktivní","strategyStateInactive":"neaktivní","strategyStateLocked":"a nelze ji zakázat.","strategyConfiguration":"Konfigurace strategie","strategyNoConfiguration":"Tato strategie nemá žádné možnosti konfigurace, které můžete změnit.","registration":"Registrace","selfRegistration":"Povolit vlastní registraci","selfRegistrationHint":"Povolit všem úspěšně autorizovaným uživatelům dle strategií přístup na wiki.","domainsWhitelist":"Omezit na konkrétní e-mailové domény","domainsWhitelistHint":"Seznam domén oprávněných k registraci. Doména e-mailové adresy musí souhlasit s jedním z nich pro získání přístupu.","autoEnrollGroups":"Přiřadit ke skupině","autoEnrollGroupsHint":"Automaticky přiřadit nové uživatele do těchto skupin.","security":"Zabezpečení","force2fa":"Vynucení všech uživatelů, aby používali dvoufaktorové ověřování (2FA)","force2faHint":"Uživatelé budou muset nastavit 2FA při prvním přihlášení a nemohou být uživateli zakázány.","configReference":"Reference pro konfiguraci","configReferenceSubtitle":"Některé strategie mohou vyžadovat nastavení některých konfiguračních hodnot na straně vašeho poskytovatele. Tyto informace jsou poskytovány pouze pro referenci a stávající strategie je nemusí potřebovat.","siteUrlNotSetup":"Nejprve je nutné nastavit platnou {{siteUrl}}. V levém pruhu klepněte na položku {{general}}","allowedWebOrigins":"Povolené webové kořeny","callbackUrl":"URL zpětného volání / URI přesměrování","loginUrl":"Adresa URL pro přihlášení","logoutUrl":"Adresa URL pro odhlášení","tokenEndpointAuthMethod":"Metoda ověřování koncového bodu","refreshSuccess":"Seznam strategií byl aktualizován.","saveSuccess":"Konfigurace ověřování byla úspěšně uložena.","activeStrategies":"Aktivní Strategie","addStrategy":"Přidat Strategii","strategyIsEnabled":"Aktivní","strategyIsEnabledHint":"Mohou se uživatelé přihlásit pomocí této strategie?","displayName":"Zobrazované jméno","displayNameHint":"Název zobrazený koncovému uživateli pro tuto ověřovací strategii."},"editor":{"title":"Editor"},"logging":{"title":"Protokolování"},"rendering":{"title":"Vykreslování","subtitle":"Konfigurace kanálu vykreslování stránek"},"search":{"title":"Vyhledávač","subtitle":"Nakonfigurovat vyhledávací funkce vaší wiki","rebuildIndex":"Znovu sestavit index","searchEngine":"Vyhledávač","engineConfig":"Konfigurace Modulu","engineNoConfig":"Tento modul nemá žádné možnosti konfigurace, které lze změnit.","listRefreshSuccess":"Seznam vyhledávačů byl aktualizován.","configSaveSuccess":"Konfigurace vyhledávače byla úspěšně uložena.","indexRebuildSuccess":"Index byl úspěšně znovu vytvořen."},"storage":{"title":"Úložiště","subtitle":"Nastavení zálohování a synchronizace obsahu pro váš obsah.","targets":"Cíle","status":"Stav","lastSync":"Poslední synchronizace {{time}}","lastSyncAttempt":"Poslední pokus byl {{time}}","errorMsg":"Chybové hlášení","noTarget":"Nemáte žádný aktivní cíl úložiště.","targetConfig":"Cílová konfigurace","noConfigOption":"Tento cíl úložiště nemá žádné možnosti konfigurace, které lze upravit.","syncDirection":"Směr synchronizace","syncDirectionSubtitle":"Zvolte způsob zpracování synchronizace obsahu pro tento cíl úložiště.","syncDirBi":"Obousměrný","syncDirPush":"Pushnout do cíle","syncDirPull":"Vytáhnout z cíle","unsupported":"Nepodporováno","syncDirBiHint":"V obousměrném režimu je obsah nejprve stažen z cíle úložiště. Jakýkoliv novější obsah přepíše lokální obsah. Nový obsah od poslední synchronizace je pak pushnutý do cíle úložiště a přepíše jakýkoliv obsah v cíli, pokud je cíl přítomen.","syncDirPushHint":"Obsah je vždy pushnutý do cíle úložiště a přepisuje veškerý existující obsah. Toto je nejbezpečnější volba pro scénáře zálohování.","syncDirPullHint":"Obsah je vždy stažen z cíle úložiště a přepíše veškerý lokální obsah, který již existuje. Tato volba je obvykle vyhrazena pro import obsahu pro jedno použití. Při této možnosti buďte opatrní, protože veškerý lokální obsah bude vždy přepsán!","syncSchedule":"Plán Synchronizace","syncScheduleHint":"Z důvodů výkonu tento cíl úložiště synchronizuje změny v plánu v intervalech namísto každé změny. Definujte, v jakém intervalu má probíhat synchronizace.","syncScheduleCurrent":"Nyní nastavena na každý {{schedule}}.","syncScheduleDefault":"Výchozí nastavení je každý {{schedule}}.","actions":"Akce","actionRun":"Spustit","targetState":"Tento cíl úložiště je {{state}}","targetStateActive":"aktivní","targetStateInactive":"neaktivní","actionsInactiveWarn":"Před spuštěním akcí je nutné povolit tento cíl úložiště a použít změny."},"api":{"title":"API Přístup","subtitle":"Spravujte klíče pro přístup k API","enabled":"API povoleno","disabled":"API zakázáno","enableButton":"Povolit API","disableButton":"Zakázat API","newKeyButton":"Nový klíč API","headerName":"Jméno","headerKeyEnding":"Konec klíče","headerExpiration":"Vypršení platnosti","headerCreated":"Vytvořeno","headerLastUpdated":"Naposledy aktualizováno","headerRevoke":"Odvolat","noKeyInfo":"Nejsou vygenerovány žádné API klíče.","revokeConfirm":"Odvolat klíč rozhraní API?","revokeConfirmText":"Opravdu chcete zrušit klíč {{name}} ? Tuto akci nelze vrátit zpět!","revoke":"Odvolat","refreshSuccess":"Seznam API klíčů byl aktualizován.","revokeSuccess":"Klíč byl úspěšně zrušen.","newKeyTitle":"Nový klíč API","newKeySuccess":"Klíč API byl úspěšně vytvořen.","newKeyNameError":"Jméno chybí nebo je neplatné.","newKeyGroupError":"Musíte vybrat skupinu.","newKeyGuestGroupError":"Guests skupinu nelze použít pro API klíče.","newKeyNameHint":"Účel tohoto klíče","newKeyName":"Jméno","newKeyExpiration":"Vypršení platnosti","newKeyExpirationHint":"Klíč můžete kdykoli odvolat bez ohledu na vypršení platnosti.","newKeyPermissionScopes":"Rozsah oprávnění","newKeyFullAccess":"Plný přístup","newKeyGroupPermissions":"nebo použít oprávnění skupny...","newKeyGroup":"Skupina","newKeyGroupHint":"API klíč bude mít stejná oprávnění jako vybraná skupina.","expiration30d":"30 dní","expiration90d":"90 dní","expiration180d":"180 dní","expiration1y":"1 rok","expiration3y":"3 roky","newKeyCopyWarn":"Zkopírujte níže uvedený klíč jako {{bold}}","newKeyCopyWarnBold":"nebude znovu zobrazeno","toggleStateEnabledSuccess":"API bylo úspěšně aktivováno.","toggleStateDisabledSuccess":"Rozhraní API bylo úspěšně deaktivováno."},"system":{"title":"Systémové informace","subtitle":"Informace o Vašem systému","hostInfo":"Informace o hostiteli","currentVersion":"Aktuální verze","latestVersion":"Nejnovější verze","published":"Publikováno","os":"Operační systém","hostname":"Jméno hostitele","cpuCores":"Jádra CPU","totalRAM":"Celková paměť","workingDirectory":"Pracovní adresář","configFile":"Konfigurační soubor","ramUsage":"Využití paměti RAM: {{used}} / {{total}}","dbPartialSupport":"Vaše databáze není plně podporována. Některé funkce mohou být omezeny nebo nemusí fungovat podle očekávání.","refreshSuccess":"Informace o systému byly aktualizovány."},"utilities":{"title":"Nástroje","subtitle":"Údržba a různé nástroje","tools":"Nástroje","authTitle":"Ověření","authSubtitle":"Různé nástroje pro ověřování / uživatelé","cacheTitle":"Vyprázdnit Cache","cacheSubtitle":"Vyprázdnění mezipaměti různých komponent.","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Změnit GraphQL endpoint pro Wiki.js","importv1Title":"Import z Wiki.js 1.x","importv1Subtitle":"Migrace dat z předchozí instalace 1.x.","telemetryTitle":"Telemetrie","telemetrySubtitle":"Povolí/zakáže telemetrii nebo resetuje ID klienta","contentTitle":"Obsah","contentSubtitle":"Různé nástroje pro stránky"},"dev":{"title":"Vývojářské nástroje","flags":{"title":"Příznaky"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Přispějte k projektu Wiki.js","subtitle":"Pomozte podpořit Wiki.js vývoj a provoz","fundOurWork":"Financujte naši práci","spreadTheWord":"Propagujte nás","talkToFriends":"Povězte přátelům a kolegům jak úžasná je Wiki.js!","followUsOnTwitter":"Následujte nás na {{0}}.","submitAnIdea":"Pošlete nápad nebo hlasujte pro existující na {{0}}.","submitAnIdeaLink":"tabule žádostí o funkce","foundABug":"Našli jste chybu? Odešlete ji na {{0}}.","helpTranslate":"Pomozte přeložit Wiki.js do Vašeho jazyka. Dejte nám vědět na {{0}}.","makeADonation":"Přispějte","contribute":"Přispět","openCollective":"Wiki.js je také součástí iniciativy Open Collective transparentního učtu, který podporujje komunitní zdroje. Finančně můžete přispívat měsíčně nebo jednorázovým darováním:","needYourHelp":"Potřebujeme Vaši pomoc, abychom neustále zlepšovali software a provozovali různé přidružené služby (např. Hosting a síť).","openSource":"Wiki.js je bezplatný a otevřený software, který vám přináší {{0}} od {{1}} a {{2}} .","openSourceContributors":"přispěvatelé","tshirts":"Můžete si také koupit Wiki.js trička a projekt finančně podpořit:","shop":"Wiki.js obchod","becomeAPatron":"Staňte se patronem","patreon":"Staňte se podporovatelem nebo sponzorem prostřednictvím Patreonu (příspěvek jde přímo na podporu hlavního vývojáře Nicolasa Giarda, kterého cíl je pracovat na Wiki.js na plný úvazek)","paypal":"Podpořte nás jednorázově nebo opakovaně přes Paypal","ethereum":"Přjímáme dary přes Ethereum","github":"Staňte se sponzorem prostřednictvím GitHub Sponsors (jde přímo na podporu hlavního vývojářského cíle Nicolase Giarda, aby mohl pracovat na Wiki.js na plný úvazek)","becomeASponsor":"Staňte se sponzorem"},"nav":{"site":"Stránka","users":"Uživatelé","modules":"Moduly","system":"Systém"},"pages":{"title":"Stránky"},"navigation":{"title":"Navigace","subtitle":"Spravovat navigaci webu","link":"Odkaz","divider":"Oddělovač","header":"Záhlaví","label":"Popisek","icon":"Ikona","targetType":"Typ cíle","target":"Cíl","noSelectionText":"Vyberte navigační položku vlevo.","untitled":"Bez názvu {{kind}}","navType":{"external":"Externí odkaz","home":"Domů","page":"Stránka","searchQuery":"Vyhledávací dotaz","externalblank":"Externí odkaz (nové okno)"},"edit":"Upravit {{kind}}","delete":"Odstranit {{kind}}","saveSuccess":"Navigace byla úspěšně uložena.","noItemsText":"Klepnutím na tlačítko Přidat přidáte první navigační položku.","emptyList":"Navigace je prázdná","visibilityMode":{"all":"Viditelné všem","restricted":"Viditelné pro výběr skupin..."},"selectPageButton":"Vybrat stránku...","mode":"Režim navigace","modeSiteTree":{"title":"Mapa stránky","description":"Klasická navigace na základě stromové struktury"},"modeCustom":{"title":"Vlastní navigace","description":"Statické Navigační Menu + Tlačítko Stromu Stránky"},"modeNone":{"title":"Žádný","description":"Zakázat navigaci stránky"},"copyFromLocale":"Kopírovat z lokalizace...","sourceLocale":"Zdroj lokalizace","sourceLocaleHint":"Lokalizace, ze kterého budou navigační položky zkopírovány.","copyFromLocaleInfoText":"Vyberte lokalizaci, ze které budou zkopírovány položky. Položky budou připojeny k aktuálnímu seznamu položek v aktivní lokalizaci.","modeStatic":{"title":"Statická navigace","description":"Pouze statické navigační menu"}},"mail":{"title":"Schránka","subtitle":"Konfigurace nastavení schránky","configuration":"Konfigurace","dkim":"DKIM (volitelné)","test":"Odeslat testovací e-mail","testRecipient":"E-mailová adresa příjemce","testSend":"Poslat e-mail","sender":"Odesilatel","senderName":"Jméno odesilatele","senderEmail":"E-mail odesilatele","smtp":"SMTP nastavení","smtpHost":"Hostitel","smtpPort":"Port","smtpPortHint":"Běžně 465 (doporučeno), 587 nebo 25.","smtpTLS":"Zabezpečeno (TLS)","smtpTLSHint":"Mělo by být povoleno, pokud se používá port 465, jinak je vypnuto (587 nebo 25).","smtpUser":"Uživatelské jméno","smtpPwd":"Heslo","dkimHint":"DKIM (DomainKeys Identified Mail) poskytuje vrstvu zabezpečení všech e-mailů odeslaných z Wiki.js tím, že příjemcům poskytuje prostředky k ověření názvu domény a zajištění autenticity zprávy.","dkimUse":"Použít DKIM","dkimDomainName":"Název domény","dkimKeySelector":"Výběr klíče","dkimPrivateKey":"Soukromý klíč","dkimPrivateKeyHint":"Soukromý klíč pro výběr ve formátu PEM","testHint":"Odeslat testovací e-mail pro ujištění, že vaše SMTP konfigurace funguje.","saveSuccess":"Konfigurace byla úspěšně uložena.","sendTestSuccess":"Testovací e-mail byl úspěšně odeslán.","smtpVerifySSL":"Ověření certifikátu SSL","smtpVerifySSLHint":"Některé hostingy vyžadují kontrolu SSL pro zakázání. Nechte povolené pro zajištění správné bezpečnosti."},"webhooks":{"title":"Webhooky","subtitle":"Správa webhooků pro externí služby"},"adminArea":"Administrativní oblast","analytics":{"title":"Analytika","subtitle":"Přidejte do své wiki analytické a sledovací nástroje","providers":"Poskytovatelé","providerConfiguration":"Konfigurace Poskytovatele","providerNoConfiguration":"Tento poskytovatel nemá žádné možnosti konfigurace, které můžete upravovat.","refreshSuccess":"Seznam poskytovatelů byl úspěšně aktualizován.","saveSuccess":"Analitická konfigurace byla úspěšně uložena."},"comments":{"title":"Komentáře","provider":"Poskytovatel","subtitle":"Přidejte diskuzi k vašim wiki stránkám","providerConfig":"Konfigurace poskytovatele","providerNoConfig":"Tento poskytovatel nemá žádné možnosti konfigurace, které by se daly upravit."},"tags":{"title":"Tagy","subtitle":"Spravovat tagy stránky","emptyList":"Žádné tagy k zobrazení.","edit":"Upravit Tag","tag":"Tag","label":"Popisek","date":"Vytvářen {{created}} a naposledy aktualizován {{updated}}.","delete":"Smazat tento tag","noSelectionText":"Vyberte tag ze seznamu na levé straně.","noItemsText":"Chcete-li začít, přidejte na stránku tag.","refreshSuccess":"Tagy byly aktualizovány.","deleteSuccess":"Tag úspěšně odstraněn.","saveSuccess":"Tag byl úspěšně uložen.","filter":"Filtr...","viewLinkedPages":"Zobrazit Propojené Stránky","deleteConfirm":"Odstranit Tag?","deleteConfirmText":"Opravdu chcete smazat tag {{tag}} ? Značka bude také odpojena od všech stránek."},"ssl":{"title":"SSL","subtitle":"Správa konfigurace SSL","provider":"Poskytovatel","providerHint":"Pokud již máte vlastní certifikát, vyberte vlastní certifikát.","domain":"Doména","domainHint":"Zadejte plně kvalifikovanou doménu směřující na vaši wiki. (např. wiki.example.com)","providerOptions":"Možnosti poskytovatele","providerDisabled":"Zakázáno","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Vlastní certifikát","ports":"Porty","httpPort":"Port HTTP","httpPortHint":"Port, který není typu SSL, server bude naslouchat požadavkům protokolu HTTP. Obvykle 80 nebo 3000.","httpsPort":"Port HTTPS","httpsPortHint":"Port SSL, na kterém bude server naslouchat požadavkům protokolu HTTPS. Obvykle 443.","httpPortRedirect":"Přesměrovat požadavky HTTP na HTTPS","httpPortRedirectHint":"Automaticky přesměruje všechny požadavky na portu HTTP na HTTPS.","writableConfigFileWarning":"Chcete-li zachovat konfiguraci portů, musí být váš konfigurační soubor zapisovatelný.","renewCertificate":"Obnovit Certifikát","status":"Stav Certifikátu","expiration":"Vypršení Platnosti Certifikátu","subscriberEmail":"E-mail Odběratele","currentState":"Aktuální Stav","httpPortRedirectTurnOn":"Zapnout","httpPortRedirectTurnOff":"Vypnout","renewCertificateLoadingTitle":"Obnovení Certifikátu...","renewCertificateLoadingSubtitle":"Neopouštět tuto stránku.","renewCertificateSuccess":"Certifikát byl úspěšně obnoven.","httpPortRedirectSaveSuccess":"Přesměrování HTTP bylo úspěšně změněno."},"security":{"title":"Zabezpečení","maxUploadSize":"Maximální velikost pro nahrávání","maxUploadBatch":"Maximální počet souborů na nahrání","maxUploadBatchHint":"Kolik souborů lze nahrát v jedné dávce?","maxUploadSizeHint":"Maximální velikost jednoho souboru.","maxUploadSizeSuffix":"bajtů","maxUploadBatchSuffix":"soubory","uploads":"Nahrávání","uploadsInfo":"Toto nastavení ovlivní pouze Wiki.js. Pokud používáte reverzní proxy (např. Nginx, apache, Cloudflare), musíte také změnit nastavení tak, aby odpovídala.","subtitle":"Konfigurace nastavení zabezpečení","login":"Přihlášení","loginScreen":"Přihlašovací obrazovka","jwt":"Konfigurace JWT","bypassLogin":"Přeskočit přihlášovací obrazovku","bypassLoginHint":"Uživatel by měl být automaticky přesměrován na první způsob přihlášení","loginBgUrl":"URL Adresa obrázku pozadí na přihlašovacího stránce","loginBgUrlHint":"Určete obrázek, který chcete použít jako přihlašovací pozadí. Podporovány jsou soubory PNG a JPG, doporučuje se rozlišení 1920x1080. Pro použití výchozího nechte prázné. Kliknutím na tlačítko vpravo nahrajte nový obrázek. Uvědomte si, že skupina Hosté musí mít přístup ke čtení u vybraného obrázku!","hideLocalLogin":"Skrýt lokální možnost přihlášení","hideLocalLoginHint":"Skrýt lokální možnost přihlášení. Je možné ji použít, když do URL zadáte parametr ?all.","loginSecurity":"Zabezpečení","enforce2fa":"Vynutit dvoufaktorové ověřování","enforce2faHint":"Vynutit používání dvoufaktorové autentifikace ve formulářích s uživatelskkým jménem a heslem."},"extensions":{"title":"Rozšíření","subtitle":"Nainstalujte rozšíření pro rozšíření funkcionality"}},"editor":{"page":"Stránka","save":{"processing":"Probíhá zpracování...","pleaseWait":"Prosím, čekejte...","createSuccess":"Stránka byla úspěšně vytvořena.","error":"Při vytváření stránky došlo k chybě","updateSuccess":"Stránka úspěšně aktualizována.","saved":"Uloženo"},"props":{"pageProperties":"Vlastnosti Stránky","pageInfo":"Informace o stránce","title":"Název","shortDescription":"Krátký Popis","shortDescriptionHint":"Zobrazeno pod názvem","pathCategorization":"Cesta & Kategorizace","locale":"Lokalizace stránky","path":"Cesta","pathHint":"Nezahrnuji žádná úvodní ani koncová lomítka.","tags":"Tagy","tagsHint":"Pomocí tagů můžete stránky kategorizovat a snadněji je najít.","publishState":"Stav Publikování","publishToggle":"Publikováno","publishToggleHint":"Nepublikované stránky mohou uživatelé stále vidět, pokud mají k této stránce oprávnění k zápisu.","publishStart":"Publikovat od ...","publishStartHint":"Ponechat prázdné pro počáteční datum","publishEnd":"Publikovat koncem...","publishEndHint":"Ponechat prázdné pro koncové datum","info":"Informace","scheduling":"Plánování","social":"Sociální","categorization":"Kategorizace","socialFeatures":"Sociální funkce","allowComments":"Povolit komentáře","allowCommentsHint":"Povolit možnost komentování na této stránce.","allowRatings":"Povolit hodnocení","displayAuthor":"Zobrazit informace o autorovi","displaySharingBar":"Zobrazit panel nástrojů pro sdílení","displaySharingBarHint":"Zobrazit panel nástrojů s tlačítky pro sdílení a tisk této stránky","displayAuthorHint":"Zobrazit autora stránky spolu s časem poslední verze.","allowRatingsHint":"Povolit možnost hodnocení na této stránce.","scripts":"Skripty","css":"CSS","cssHint":"CSS bude automaticky minifikováno při uložení. Ponechejte pouze vlastní kód CSS, neobklopujte ho HTML značkami stylu.","styles":"Styly","html":"HTML","htmlHint":"Váš javascript kód musí být obkloben HTML značkami pro skript."},"unsaved":{"title":"Zrušit neuložené změny?","body":"Máte neuložené změny. Opravdu chcete opustit editor a zrušit všechny změny, které jste provedli od posledního uložení?"},"select":{"title":"Který Editor chcete použít pro tuto stránku?","cannotChange":"Po vytvoření stránky tohle již nelze změnit.","customView":"nebo vytvořit vlastní zobrazení?"},"assets":{"title":"Objekty","newFolder":"Nová Složka","folderName":"Název Složky","folderNameNamingRules":"Musí následovat složku objektu {{namingRules}}.","folderNameNamingRulesLink":"pravidla při pojmenování","folderEmpty":"Tato složka objektů je prázdná.","fileCount":"{{count}} souborů","headerId":"ID","headerFilename":"Název souboru","headerType":"Typ","headerFileSize":"Velikost souboru","headerAdded":"Přidáno","headerActions":"Akce","uploadAssets":"Nahrát Objekty","uploadAssetsDropZone":"Zde můžete procházet nebo přetahovat soubory ...","fetchImage":"Načíst Vzdálený Obrázek","imageAlign":"Zarovnání obrázku","renameAsset":"Přejmenovat Objekt","renameAssetSubtitle":"Zadejte novou cestu objektu:","deleteAsset":"Odstranit Objekt","deleteAssetConfirm":"Opravdu chcete odstranit objekt","deleteAssetWarn":"Tuto akci nelze vrátit zpět!","refreshSuccess":"Seznam objektů úspěšně obnoven.","uploadFailed":"Nahrávání souboru se nezdařilo.","folderCreateSuccess":"Adresář objektu úspěšně vytvořen.","renameSuccess":"Objekt úspěšně přejmenován.","deleteSuccess":"Objekt úspěšně odstraněn.","noUploadError":"Nejprve musíte vybrat soubor, který chcete nahrát!"},"backToEditor":"Zpět do editoru","markup":{"bold":"Tučné","italic":"Kurzíva","strikethrough":"Přeškrtnutí","heading":"Nadpis {{level}}","subscript":"Dolní index","superscript":"Horní index","blockquote":"Citace-blok","blockquoteInfo":"Informační Citace-blok","blockquoteSuccess":"Úspěch Citace-blok","blockquoteWarning":"Varovná Citace-blok","blockquoteError":"Chybová Citace-blok","unorderedList":"Nečíslovaný Seznam","orderedList":"Uspořádaný Seznam","inlineCode":"Vnořený Kód","keyboardKey":"Tlačidlo Klávesnice","horizontalBar":"Horizontální Bar","togglePreviewPane":"Skrýt / Zobrazit Panel Náhledu","insertLink":"Vložit odkaz","insertAssets":"Vložit objekty","insertBlock":"Vložit blok","insertCodeBlock":"Vložit blok kódu","insertVideoAudio":"Vložit video / audio","insertDiagram":"Vložit diagram","insertMathExpression":"Vložit matematický výraz","tableHelper":"Pomocník pro Tabulku","distractionFreeMode":"Volný režim Bez rozptýlení","markdownFormattingHelp":"Nápověda pro formátování Markdownu","noSelectionError":"Nejprve je nutné vybrat text!","toggleSpellcheck":"Přepnout kontrolu pravopisu"},"ckeditor":{"stats":"{{chars}} znaky, {{words}} slova"},"conflict":{"title":"Vyřešte konflikt při ukládání","useLocal":"Použít místní","useRemote":"Použít vzdálený","useRemoteHint":"Zrušit lokální verzi a použít poslední.","useLocalHint":"Použijte obsah v levém panelu","viewLatestVersion":"Zobrazit poslední verzi","infoGeneric":"Novější verzi této stránky uložil {{authorName}}, {{date}}","whatToDo":"Co chcete dělat?","whatToDoLocal":"Použít vaše úpravy a ignorovat poslední změny.","whatToDoRemote":"Použít vzdálenou verzi a zrušit vaše změny.","overwrite":{"title":"Přepsat vzdálenou verzí?","description":"Opravdu chcete nahradit vaše úpravy vzdálenou verzí? {{refEditsLost}}","editsLost":"Vaše aktuální úpravy budou ztraceny."},"localVersion":"Lokální verze {{refEditable}}","editable":"(upravitelné)","readonly":"(pouze ke čtení)","remoteVersion":"Vzdálená verze {{refReadOnly}}","leftPanelInfo":"Vámi editovaná stránka vychází z verze {{date}}","rightPanelInfo":"Naposledy upraveno","pageTitle":"Titulek","pageDescription":"Popis:","warning":"Konflikt při ukládání! Tuto stránku již upravil jiný uživatel."},"unsavedWarning":"Máte neuložené úpravy. Opravdu chcete opustit editor?"},"tags":{"currentSelection":"Aktuální výběr","clearSelection":"Vymazat výběr","selectOneMoreTags":"Vyberte jeden nebo více tagů","searchWithinResultsPlaceholder":"Hledat ve výsledcích ...","locale":"Lokalizace","orderBy":"Seřadit podle","selectOneMoreTagsHint":"Vyberte jeden nebo více tagů vlevo.","retrievingResultsLoading":"Načítání výsledků stránek.","noResults":"Nepodařilo se najít žádnou stránku s vybranými tagy.","noResultsWithFilter":"Nepodařilo se najít žádnou stránku odpovídající současnému nastavení filtrů.","pageLastUpdated":"Posledně upraveno {{date}}","orderByField":{"creationDate":"Datum vytvoření","ID":"ID","lastModified":"Posledně upraveno","path":"Cesta","title":"Název"},"localeAny":"Libovolná"},"history":{"restore":{"confirmTitle":"Obnovit verzi stránky?","confirmText":"Opravdu chcete obnovit obsah této stránky tak, jak byl k datu {{date}}? Tato verze bude zkopírována na začátek aktuální historie. Novější verze zůstanou zachovány.","confirmButton":"Obnovit","success":"Verze stránky byla úspěšně obnovena!"}},"profile":{"displayName":"Zobrazované jméno","location":"Umístění","jobTitle":"Pracovní pozice","timezone":"Časové pásmo","title":"Profil","subtitle":"Moje osobní informace","myInfo":"Moje informace","viewPublicProfile":"Zobrazit veřejný profil","auth":{"title":"Ověření","provider":"Poskytovatel","changePassword":"Změnit heslo","currentPassword":"Aktuální heslo","newPassword":"Nové heslo","verifyPassword":"Potvrďte nové heslo","changePassSuccess":"Heslo bylo úspěšně změněno."},"groups":{"title":"Skupiny"},"activity":{"title":"Aktivita","joinedOn":"Připojil se","lastUpdatedOn":"Profil byl naposledy aktualizován dne","lastLoginOn":"Poslední přihlášení dne","pagesCreated":"Stránky byly vytvořeny","commentsPosted":"Komentáře zveřejněny"},"save":{"success":"Profil býl úspěšně uložen"},"pages":{"title":"Stránky","subtitle":"Seznam stránek, které jsem vytvořil nebo naposledy upravil","emptyList":"Žádné stránky k zobrazení.","refreshSuccess":"Seznam stránek byl aktualizován.","headerTitle":"Název","headerPath":"Cesta","headerCreatedAt":"Vytvořeno","headerUpdatedAt":"Naposledy upraveno"},"comments":{"title":"Komentáře"},"preferences":"Předvolby","dateFormat":"Formát data","localeDefault":"Výchozí národní prostředí","appearance":"Vzhled","appearanceDefault":"Výchozí web","appearanceLight":"Světlý","appearanceDark":"Tmavý"}}	f	Czech	čeština	100	2021-02-26T18:17:33.342Z	2021-02-26T18:48:01.848Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2021-02-26 18:19:14.174+01
2	2.1.85.js	1	2021-02-26 18:19:14.176+01
3	2.2.3.js	1	2021-02-26 18:19:14.193+01
4	2.2.17.js	1	2021-02-26 18:19:14.196+01
5	2.3.10.js	1	2021-02-26 18:19:14.198+01
6	2.3.23.js	1	2021-02-26 18:19:14.199+01
7	2.4.13.js	1	2021-02-26 18:19:14.203+01
8	2.4.14.js	1	2021-02-26 18:19:14.219+01
9	2.4.36.js	1	2021-02-26 18:19:14.222+01
10	2.4.61.js	1	2021-02-26 18:19:14.224+01
11	2.5.1.js	1	2021-02-26 18:19:14.231+01
12	2.5.12.js	1	2021-02-26 18:19:14.233+01
13	2.5.108.js	1	2021-02-26 18:19:14.236+01
14	2.5.118.js	1	2021-02-26 18:19:14.238+01
15	2.5.122.js	1	2021-02-26 18:19:14.254+01
16	2.5.128.js	1	2021-02-26 18:19:14.256+01
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"8c02cd17-2158-4dcc-b121-6b4c01bde745","icon":"mdi-home","kind":"link","label":"Home","target":"/","targetType":"home","visibilityMode":"all","visibilityGroups":null}]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	home-test		f	t			deleted	1	<p>wdas</p>\n	html	2021-02-26T18:20:30.399Z	ckeditor	en	1	2021-02-26T17:26:51.976Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	home	1	home-cs	f	f	\N	\N	2	cs	[]
2	home-kopie	1	home-cs	f	f	\N	\N	3	cs	[]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
2	home	fe1082dc88339775ff88bb4a46f2596d8f8aff2a	home-cs		f	t	\N			<p>asdfasfg</p>\n	<p>asdfasfg</p><div>\n</div>	[]	html	2021-02-26T18:18:54.828Z	2021-02-26T18:19:03.230Z	ckeditor	cs	1	1	{"js":"","css":""}
3	home-kopie	449211ea5acbf7dbe02c6b7425795cd796216396	home-cs		f	t	\N			<p>asdfasfg</p>\n	<p>asdfasfg</p><div>\n</div>	[]	html	2021-02-26T18:34:36.377Z	2021-02-26T18:34:43.224Z	ckeditor	cs	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"6.x","hosts":"","indexName":"wiki","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
certs	{"jwk":{"kty":"RSA","n":"xWZU9geQXFrznBitDoJKfTyNltAreNl-7coxqSflx7kMVBSW3lKwbLFK0DI-ic4e7Hox-jtmnDcmsKzacWX6tyHsAjVpGvJsqBsc49xdSn-K-j6Sspj-3EJNt6LvIf8E6vU8ze5H64rDg-BY21ePpHmMTk9sDA8JMYyCXGi3UCPHZR64ChGiIsy1YaiRYqFvjWoSdxuCvd2xYSngbHBUfh-kHeUjOq6HD-lT7VPr6uMO3LqvZFlRnoGBD3dcSSj6Y2y6V0idkT1muy-hp9q-uRKC0hxqw5HNZ-vQjJAkRzQbz1-Juy5G2mMSkmH1T2sX3K-X1J5vLg4uMoG375nlLQ","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAxWZU9geQXFrznBitDoJKfTyNltAreNl+7coxqSflx7kMVBSW3lKw\\nbLFK0DI+ic4e7Hox+jtmnDcmsKzacWX6tyHsAjVpGvJsqBsc49xdSn+K+j6Sspj+\\n3EJNt6LvIf8E6vU8ze5H64rDg+BY21ePpHmMTk9sDA8JMYyCXGi3UCPHZR64ChGi\\nIsy1YaiRYqFvjWoSdxuCvd2xYSngbHBUfh+kHeUjOq6HD+lT7VPr6uMO3LqvZFlR\\nnoGBD3dcSSj6Y2y6V0idkT1muy+hp9q+uRKC0hxqw5HNZ+vQjJAkRzQbz1+Juy5G\\n2mMSkmH1T2sX3K+X1J5vLg4uMoG375nlLQIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,3EB8A211A61A1E89F7E85DDCCCEC93F3\\n\\nyH0Fja+D28s1omHPWi26J+SKNI6J2fp4VcdBrk9nxsIZeNt6yCB6WQpGD3jO+Zby\\n6fNuR4gcz0itjwvzV9uH3JUeYXwMDfO/7TrSWMRHNNYgSXKvriDvh8oEbuqVK5yI\\nol5F+C1j9V9PPVE9p5uC2flVVwXBUZleZKtHBDuaYrAAZ0Sc5wgEM7y03eo8Y1Xe\\nhRWvxcLNHKnJgjrIt9//PAfKIlFkxCGmoOfWQcNbz1QFw+x2NVV1aLVwOezwWLHY\\nT9FHftw9DgbvLNwiszzMXnxjiYD93pmdT7eYUuZsPBMMZgw5Ykg2pi+ZEqOswt3i\\na1oc6s/Ia/bHfm3dDm/+TYamMWoP1isPjOfY9+E9DmizWqvobb44QdULFeL03btp\\nnEaLhl9rnC6U95r1RAh541+ln/LfcqtwF1LgbpmuOJZ/9bMPCNnICk4oGuPnP6M9\\nsZdp6EE7dfOFRfZfkw76K3A+QUbiz32VeQ4UkRzGytPqzhsCsA01l1ENzD3eetor\\n6FSF9ls1BgWfn4G60xOHzVQBw/RjHuSuDFe5fNvBeHWkxxg9CdaUAG/QskrzmUXl\\nwpPd/G91X4Sjl2gOwtRZZ3owzvXEmzBqmluMvavWmIHZVuy98iwmWV1TRy+0xE/d\\noMEmjCKaIFF9rmpNUxfaVKwXZajgfj6gRDj2P7PWrnbXUb1JMhL9B4F1+5ykOx4X\\nEcgQ6Ka9vdEIvhDBqTC7/DzNR8UvFCZlu7EAtVAR2tVqqqIbiwOiCX8vu/O3PnXw\\nWKP7Lb/zpnE3Kfc4Fx7W4PHqsCbcSGzQ81KhRahBYpq0lwEfCWzsOucja4GC/+R3\\nlXBePX72STPagC6Fbr2JCe4Q88BVfTTf1q2KhKiFor5VF7Tqp4hDMM7fPQunrjw+\\nvQ0GgqOqdhS5MW0OD2VcADJZ7d6SULgkZd2nr6f4HoWQ2bToap0/HFZ0TmDnBqCo\\nISveebmHWzZQv6DVQrh+tuOxUgajSeFxuPfkwiaxlsJOCcXSiPsxtnCwCRTXZkFa\\n99glNwySUPjPWg9ynQ5iU8d2+vT4NgGzD9J880w8XoMqFYsX+qSaaEZiWaXRWn32\\noCYqyn51bBiS6vfw512cFmGjmCvMBA9J5/hKB79yFXT8lPWuxnOms2j15jbd7vNZ\\nks4dfpA8hQ4igOyztJib70Dp+PuEPXX10uyinr69JJFSeOuF3Fuaf6EwAVezTxzH\\nbFc9AJXociZgpOMDNULzufY94J89Hpn8VETTBiODuCDqKQ7PiRVVGbLzFo/FUeyW\\nJSveRtTaR7PqcrHXVCvMudxvKId90IQPx0we2pm1Kkv8VSlDqQXFOsBX0WHuBT6T\\naiM6OSMAmu5ZDxfAWqmgfd6XlzI5xg9XLSTPszxR894n1HclT5mLf5zm5g165ixm\\ntBi+mbnf8kg2ZO8dPNH78N2lVKaHUZkUvj9w+AQ31X0ySh287CKS4xAKEmoNaP/J\\neT7njkP+29GaP9+qLab0jgRMPL1YEVT2OFEL2cfFYHYQJ6p4MITyUTENggt094Bl\\nQE9q/c0uaZIHTO2ch202sXaD+CzzQ828u1F1XaqkkR5fm3WpNS3hezaEgHvNpxM5\\n-----END RSA PRIVATE KEY-----\\n"}	2021-02-26T17:25:52.871Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2021-02-26T17:25:52.916Z
logo	{"hasLogo":false,"logoIsSquare":false}	2021-02-26T17:25:52.985Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2021-02-26T17:25:52.998Z
sessionSecret	{"v":"a9d4e7cf15416c6af846146e4ca610b5b03e4e608245d50be5f85a7852df798d"}	2021-02-26T17:25:53.035Z
telemetry	{"isEnabled":false,"clientId":"828aee48-2082-45ec-9c90-557a4c066c31"}	2021-02-26T17:25:53.064Z
lang	{"code":"cs","autoUpdate":true,"namespacing":false,"namespaces":["cs"],"rtl":false}	2021-02-26T18:17:52.683Z
host	{"v":"https://helpdesk/wiki"}	2021-02-26T18:39:20.498Z
title	{"v":"GiTy Wiki"}	2021-02-26T18:39:20.500Z
company	{"v":"Gity a.s."}	2021-02-26T18:39:20.502Z
contentLicense	{"v":"ccbysa"}	2021-02-26T18:39:20.504Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2021-02-26T18:39:20.506Z
logoUrl	{"v":"https://static.requarks.io/logo/wikijs-butterfly.svg"}	2021-02-26T18:39:20.511Z
auth	{"autoLogin":false,"enforce2FA":false,"hideLocal":false,"loginBgUrl":"","audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2021-02-26T18:39:20.515Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2021-02-26T18:39:20.517Z
security	{"securityOpenRedirect":true,"securityIframe":true,"securityReferrerPolicy":true,"securityTrustProxy":true,"securitySRI":true,"securityHSTS":false,"securityHSTSDuration":300,"securityCSP":false,"securityCSPDirectives":""}	2021-02-26T18:39:20.530Z
uploads	{"maxFileSize":5242880,"maxFiles":10}	2021-02-26T18:39:20.532Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2021-02-26T18:46:14.343Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
disk	t	push	{"path":"./backup","createDailyBackups":true}	P0D	{"status":"operational","message":"","lastAttempt":"2021-02-26T18:47:54.593Z"}
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","gitBinaryPath":""}	PT5M	{"status":"pending","message":"Initializing...","lastAttempt":null}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
3	3	3
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2021-02-26T17:25:55.738Z	2021-02-26T17:25:55.738Z	local	en	markdown	\N		
1	matej.hyks@gity.eu	Administrator	\N	$2a$12$F3pvo966bd2Xl.hENq25ru/AVArSoZ66IQ4Kop5hucBBi5fIaPVvi	f	\N			\N	Europe/Prague	f	t	t	f	2021-02-26T17:25:54.633Z	2021-02-26T18:53:54.515Z	local	en	markdown	2021-02-26T18:56:49.555Z	DD.MM.YYYY	dark
3	operator@gity.eu	Operátor	\N	$2a$12$b8rBNt/41meLRkk6sM9c6evp0fx.9XTXTj00Meqidb8f6oTwZrOiC	f	\N			\N	America/New_York	f	t	t	f	2021-02-26T18:56:18.412Z	2021-02-26T18:57:33.743Z	local	en	markdown	2021-02-27T09:47:04.332Z		
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 1, false);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.groups_id_seq', 3, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 1, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 1, false);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.pages_id_seq', 3, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 3, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

