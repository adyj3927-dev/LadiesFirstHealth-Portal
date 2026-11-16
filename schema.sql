-- Ladies First volunteer sign-ups
-- Run this once in Supabase: Dashboard → SQL Editor → New query → paste → Run.

create table if not exists public.volunteers (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  first_name  text not null check (char_length(first_name) between 1 and 80),
  last_name   text not null check (char_length(last_name)  between 1 and 80),
  email       text not null check (char_length(email) <= 254 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  year        text not null check (year in ('First-year', 'Sophomore', 'Junior', 'Senior', 'Graduate student'))
);

-- One sign-up per email (the site shows "you're already signed up" on a repeat)
create unique index if not exists volunteers_email_key on public.volunteers (lower(email));

-- Security: the public website may only ADD a sign-up.
-- Nobody can read, edit or delete the list from the website; view it in the Supabase dashboard (Table Editor).
alter table public.volunteers enable row level security;

drop policy if exists "Website can add sign-ups" on public.volunteers;
create policy "Website can add sign-ups"
  on public.volunteers for insert
  to anon
  with check (true);

grant insert on public.volunteers to anon;
