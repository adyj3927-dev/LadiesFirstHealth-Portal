-- Fix: the volunteers table from the old portal is missing columns the new site sends.
-- Safe to run more than once. Keeps every existing sign-up.

-- 1. Add the columns the website saves (skips any that already exist)
alter table public.volunteers add column if not exists first_name text;
alter table public.volunteers add column if not exists last_name  text;
alter table public.volunteers add column if not exists email      text;
alter table public.volunteers add column if not exists year       text;
alter table public.volunteers add column if not exists created_at timestamptz default now();

-- 2. Old required columns the new form doesn't fill (like SPIRE ID) become optional
do $$
declare r record;
begin
  for r in
    select c.column_name
    from information_schema.columns c
    where c.table_schema = 'public' and c.table_name = 'volunteers'
      and c.is_nullable = 'NO' and c.column_default is null and c.is_identity = 'NO'
      and c.column_name not in ('first_name', 'last_name', 'email', 'year')
      and c.column_name not in (
        select a.attname from pg_index i
        join pg_attribute a on a.attrelid = i.indrelid and a.attnum = any(i.indkey)
        where i.indrelid = 'public.volunteers'::regclass and i.indisprimary)
  loop
    execute format('alter table public.volunteers alter column %I drop not null', r.column_name);
  end loop;
end $$;

-- 3. The website may only add sign-ups (it can't read or change the list)
alter table public.volunteers enable row level security;
drop policy if exists "Website can add sign-ups" on public.volunteers;
create policy "Website can add sign-ups" on public.volunteers for insert to anon with check (true);
grant insert on public.volunteers to anon;

-- 4. Tell the API about the new columns right away
notify pgrst, 'reload schema';
