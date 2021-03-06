SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: auth_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_tokens (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size bigint,
    image_updated_at timestamp without time zone,
    slug character varying NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories_products (
    category_id bigint,
    product_id bigint
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    aasm_state character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    purchases_count integer,
    user_id bigint,
    total numeric(10,2) NOT NULL
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size bigint,
    image_updated_at timestamp without time zone,
    price numeric,
    description text,
    description_tsvector tsvector,
    similarities jsonb DEFAULT '[]'::jsonb NOT NULL,
    currency integer DEFAULT 0,
    amount integer DEFAULT 0 NOT NULL,
    discount_price numeric
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchases (
    id bigint NOT NULL,
    user_id bigint,
    product_id bigint,
    amount integer,
    price numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    order_id bigint
);


--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    roles integer DEFAULT 1,
    confirmed boolean DEFAULT false NOT NULL,
    confirmation_token character varying,
    blocked_at timestamp without time zone,
    currency integer DEFAULT 0,
    facebook_id bigint
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    ios_minimal_recomended character varying DEFAULT '0.0.0'::character varying,
    ios_minimal_compatible character varying DEFAULT '0.0.0'::character varying,
    ios_blocked character varying[] DEFAULT '{}'::character varying[],
    android_minimal_recomended character varying DEFAULT '0.0.0'::character varying,
    android_minimal_compatible character varying DEFAULT '0.0.0'::character varying,
    android_blocked character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: auth_tokens auth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT auth_tokens_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: description_tsvector_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX description_tsvector_index ON public.products USING gin (description_tsvector);


--
-- Name: index_auth_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_auth_tokens_on_user_id ON public.auth_tokens USING btree (user_id);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_name ON public.categories USING gist (name public.gist_trgm_ops);


--
-- Name: index_categories_products_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_products_on_category_id ON public.categories_products USING btree (category_id);


--
-- Name: index_categories_products_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_products_on_product_id ON public.categories_products USING btree (product_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_user_id ON public.orders USING btree (user_id);


--
-- Name: index_products_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_deleted_at ON public.products USING btree (deleted_at);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_name ON public.products USING gist (name public.gist_trgm_ops);


--
-- Name: index_purchases_on_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_purchases_on_order_id ON public.purchases USING btree (order_id);


--
-- Name: index_purchases_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_purchases_on_product_id ON public.purchases USING btree (product_id);


--
-- Name: index_purchases_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_purchases_on_user_id ON public.purchases USING btree (user_id);


--
-- Name: products description_tsvector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER description_tsvector_update BEFORE INSERT OR UPDATE ON public.products FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('description_tsvector', 'pg_catalog.english', 'description');


--
-- Name: purchases fk_rails_0d630f0bc7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_rails_0d630f0bc7 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: auth_tokens fk_rails_0d66c22f4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT fk_rails_0d66c22f4c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: purchases fk_rails_2888c5cba9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_rails_2888c5cba9 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: categories_products fk_rails_a1088dab8c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_products
    ADD CONSTRAINT fk_rails_a1088dab8c FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: purchases fk_rails_a9d81871ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_rails_a9d81871ca FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: categories_products fk_rails_ef34d93ed9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_products
    ADD CONSTRAINT fk_rails_ef34d93ed9 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders fk_rails_f868b47f6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_f868b47f6a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170524153901'),
('20170601194112'),
('20170601195211'),
('20170601195240'),
('20170601200319'),
('20170607133132'),
('20170609175121'),
('20170610112643'),
('20170611102632'),
('20170617142355'),
('20170617142503'),
('20170705130615'),
('20170707104840'),
('20170718134111'),
('20170718134509'),
('20170720193424'),
('20170720193551'),
('20170724073206'),
('20170728111718'),
('20170728121426'),
('20170814110755'),
('20170816084513'),
('20170821113212'),
('20170829153658'),
('20170909203801'),
('20170920060910'),
('20170920083525'),
('20170921072836'),
('20170922090356'),
('20170928082553'),
('20170929072507'),
('20171018040224'),
('20171018121520'),
('20171018131351'),
('20180118153838'),
('20180118154010'),
('20180223180844'),
('20180223181026');


