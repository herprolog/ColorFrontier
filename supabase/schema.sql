
-- COLOR FRONTIER
-- オンライン対戦用データベース

create table if not exists public.rooms (
    code text primary key
        check (code ~ '^[A-Z0-9]{6}$'),

    state jsonb not null,

    updated_at timestamptz not null default now()
);

-- RLSを有効化
alter table public.rooms enable row level security;

-- ルームの閲覧
create policy "rooms_select"
on public.rooms
for select
to anon, authenticated
using (true);

-- ルームの作成
create policy "rooms_insert"
on public.rooms
for insert
to anon, authenticated
with check (true);

-- ゲーム状態の更新
create policy "rooms_update"
on public.rooms
for update
to anon, authenticated
using (true)
with check (true);

grant select, insert, update
on public.rooms
to anon, authenticated;
