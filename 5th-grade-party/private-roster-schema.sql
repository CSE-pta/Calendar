-- Optional secure committee roster. Run once in Supabase SQL Editor.
create table if not exists public.committee_roster (
 id bigint generated always as identity primary key,
 committee text not null check (committee in ('Decorating','Food','Entertainment','Fundraising','Swag','Upstairs')),
 display_name text not null,
 created_at timestamptz not null default now()
);
alter table public.committee_roster enable row level security;
create policy "approved member reads roster" on public.committee_roster for select to authenticated using ((select public.is_member()));
create policy "admin adds roster" on public.committee_roster for insert to authenticated with check ((select public.is_admin()));
create policy "admin updates roster" on public.committee_roster for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
create policy "admin deletes roster" on public.committee_roster for delete to authenticated using ((select public.is_admin()));
-- Add committee names only through the Supabase dashboard or authenticated admin tooling.
-- Never add personal phone numbers or committee rosters to GitHub files.
