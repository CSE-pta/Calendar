-- Run in the Supabase SQL Editor. Never put personal phone numbers in the public GitHub repository.
-- Only approved members added by a trusted administrator in Supabase SQL Editor can read/write.
create table if not exists public.members (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  role text not null default 'member' check (role in ('member','admin')),
  created_at timestamptz not null default now()
);
create table if not exists public.messages (
  id bigint generated always as identity primary key,
  room_id text not null check (room_id in ('general','announcements','decorating','food','entertainment','fundraising','swag','upstairs')),
  user_id uuid not null default auth.uid() references public.members(user_id),
  display_name text not null check (char_length(display_name) between 1 and 80),
  body text not null check (char_length(body) between 1 and 2000),
  created_at timestamptz not null default now()
);
create table if not exists public.milestones (
  id bigint generated always as identity primary key,
  title text not null,
  committee text not null check (committee in ('Decorating','Food','Entertainment','Fundraising','Swag','Upstairs')),
  status text not null default 'Not started' check (status in ('Not started','In progress','Completed')),
  due_date date,
  created_at timestamptz not null default now()
);
create table if not exists public.events (
  id bigint generated always as identity primary key,
  title text not null,
  date date not null,
  description text default '',
  created_at timestamptz not null default now()
);
create or replace function public.is_member() returns boolean language sql stable security definer set search_path = '' as $$
  select exists(select 1 from public.members m where m.user_id = (select auth.uid()));
$$;
create or replace function public.is_admin() returns boolean language sql stable security definer set search_path = '' as $$
  select exists(select 1 from public.members m where m.user_id = (select auth.uid()) and m.role = 'admin');
$$;
revoke all on function public.is_member() from public;
revoke all on function public.is_admin() from public;
grant execute on function public.is_member() to authenticated;
grant execute on function public.is_admin() to authenticated;
alter table public.members enable row level security;
alter table public.messages enable row level security;
alter table public.milestones enable row level security;
alter table public.events enable row level security;
create policy "members may see own profile" on public.members for select to authenticated using (user_id = (select auth.uid()));
create policy "approved members read chat" on public.messages for select to authenticated using ((select public.is_member()));
create policy "approved members chat except announcements" on public.messages for insert to authenticated with check (
  (select public.is_member()) and user_id = (select auth.uid()) and (room_id <> 'announcements' or (select public.is_admin()))
);
create policy "admins remove messages" on public.messages for delete to authenticated using ((select public.is_admin()));
create policy "approved members read milestones" on public.milestones for select to authenticated using ((select public.is_member()));
create policy "admins insert milestones" on public.milestones for insert to authenticated with check ((select public.is_admin()));
create policy "admins update milestones" on public.milestones for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
create policy "admins remove milestones" on public.milestones for delete to authenticated using ((select public.is_admin()));
create policy "approved members read events" on public.events for select to authenticated using ((select public.is_member()));
create policy "admins insert events" on public.events for insert to authenticated with check ((select public.is_admin()));
create policy "admins update events" on public.events for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
create policy "admins remove events" on public.events for delete to authenticated using ((select public.is_admin()));
-- Optional: expose inserts to approved users via realtime. Messages are fetched with RLS restrictions.
alter publication supabase_realtime add table public.messages;
-- To approve a member after they sign in using an email link, find their UUID in Authentication > Users.
-- Replace example below and run it in SQL Editor using a trusted administrator account:
-- insert into public.members (user_id, display_name, role) values ('USER-UUID-HERE', 'Committee Admin', 'admin');
-- Members must NEVER be able to insert themselves into public.members.

-- ADDITIONAL BUDGET TABLE: safe to run along with the full schema on a new project.
create table if not exists public.budget_transactions (
 id bigint generated always as identity primary key,
 kind text not null check (kind in ('income','expense','allocation')),
 category text not null check (char_length(category) between 1 and 80),
 description text not null check (char_length(description) between 1 and 160),
 amount numeric(12,2) not null check (amount > 0),
 entry_date date not null,
 created_at timestamptz not null default now()
);
alter table public.budget_transactions enable row level security;
create policy "approved members read budget" on public.budget_transactions for select to authenticated using ((select public.is_member()));
create policy "admins add budget" on public.budget_transactions for insert to authenticated with check ((select public.is_admin()));
create policy "admins change budget" on public.budget_transactions for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
create policy "admins delete budget" on public.budget_transactions for delete to authenticated using ((select public.is_admin()));
