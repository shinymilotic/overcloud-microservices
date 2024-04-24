CREATE TABLE public.permissions (
	id uuid NOT NULL,
	permission_name varchar(255) NOT NULL,
	description text NULL,
	CONSTRAINT permissions_permission_name_key UNIQUE (permission_name),
	CONSTRAINT permissions_pkey PRIMARY KEY (id)
);

CREATE TABLE public.roles (
	id uuid NOT NULL,
	"name" varchar(50) NOT NULL,
	CONSTRAINT roles_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX roles_name_uindex ON public.roles USING btree (name);

CREATE TABLE public.users (
	id uuid NOT NULL,
	email varchar(320) NOT NULL,
	username varchar(32) NOT NULL,
	"password" varchar(64) NOT NULL,
	bio text NULL,
	image varchar(250) NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"enable" bool NULL DEFAULT true,
	expired_time timestamp NULL,
	credentials_expired_time timestamp NULL,
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_unique UNIQUE (username)
);


CREATE TABLE public.user_role (
	role_id uuid NOT NULL,
	user_id uuid NOT NULL,
	CONSTRAINT user_role_pk PRIMARY KEY (role_id, user_id),
	CONSTRAINT role___fk FOREIGN KEY (role_id) REFERENCES public.roles(id),
	CONSTRAINT user___fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);
CREATE INDEX user_role_user__index ON public.user_role USING btree (user_id);

INSERT INTO public.roles
(id, "name")
VALUES('56f9e88c-0066-4e3e-8793-119f6f2012d6'::uuid, 'ADMIN');
INSERT INTO public.roles
(id, "name")
VALUES('80e1e7af-0f80-4a5f-ab42-bfbfa6513da9'::uuid, 'USER');


CREATE TABLE public.refresh_token (
	id uuid primary key,
	refresh_token text unique,
    user_id uuid,
    CONSTRAINT refresh_token_fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);