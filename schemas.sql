-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.applications (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  user_id uuid NOT NULL,
  job_id uuid NOT NULL,
  status USER-DEFINED NOT NULL,
  CONSTRAINT applications_pkey PRIMARY KEY (id),
  CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
  CONSTRAINT applications_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id)
);
CREATE TABLE public.categories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  name text NOT NULL,
  CONSTRAINT categories_pkey PRIMARY KEY (id)
);
CREATE TABLE public.companies (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  address text DEFAULT 'FPT Hola Campus'::text,
  CONSTRAINT companies_pkey PRIMARY KEY (id),
  CONSTRAINT companies_id_fkey FOREIGN KEY (id) REFERENCES public.users(id)
);
CREATE TABLE public.jobs (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  title text NOT NULL,
  description text NOT NULL,
  salary bigint NOT NULL,
  location text NOT NULL,
  endDate timestamp with time zone,
  user_id uuid NOT NULL,
  category_id uuid NOT NULL,
  status USER-DEFINED NOT NULL,
  CONSTRAINT jobs_pkey PRIMARY KEY (id),
  CONSTRAINT jobs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
  CONSTRAINT jobs_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id)
);
CREATE TABLE public.roles (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  name USER-DEFINED NOT NULL,
  CONSTRAINT roles_pkey PRIMARY KEY (id)
);
CREATE TABLE public.skills (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  name text NOT NULL,
  CONSTRAINT skills_pkey PRIMARY KEY (id)
);
CREATE TABLE public.students (
  id uuid NOT NULL,
  major text NOT NULL,
  university text NOT NULL,
  cv_url text NOT NULL,
  CONSTRAINT students_pkey PRIMARY KEY (id),
  CONSTRAINT students_id_fkey FOREIGN KEY (id) REFERENCES public.users(id)
);
CREATE TABLE public.tags (
  skill_id uuid NOT NULL,
  category_id uuid NOT NULL,
  CONSTRAINT tags_pkey PRIMARY KEY (skill_id, category_id),
  CONSTRAINT tags_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id),
  CONSTRAINT tags_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id)
);
CREATE TABLE public.users (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  email text NOT NULL UNIQUE,
  password text NOT NULL,
  name text NOT NULL,
  phone text NOT NULL,
  birthday timestamp with time zone NOT NULL,
  role_id uuid NOT NULL,
  bio text,
  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id)
);