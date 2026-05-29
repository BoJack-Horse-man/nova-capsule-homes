create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  category text not null,
  short_description text,
  full_description text,
  price_range text,
  size text,
  best_for text,
  features text[],
  main_image text,
  gallery_images text[],
  seo_title text,
  seo_description text,
  published boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text not null,
  email text,
  country text,
  city text,
  interested_product text,
  buyer_type text,
  budget_range text,
  units_needed text,
  preferred_contact text,
  message text,
  status text default 'New',
  source_page text,
  created_at timestamptz default now()
);

create table if not exists public.blog_posts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text unique not null,
  content text,
  image text,
  youtube_url text,
  seo_title text,
  seo_description text,
  published boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.products enable row level security;
alter table public.leads enable row level security;
alter table public.blog_posts enable row level security;

create policy "Public can view published products"
on public.products
for select
using (published = true);

create policy "Public can view published blog posts"
on public.blog_posts
for select
using (published = true);

create policy "Public can submit leads"
on public.leads
for insert
with check (true);

insert into public.products (
  name,
  slug,
  category,
  short_description,
  price_range,
  size,
  best_for,
  features,
  seo_title,
  seo_description,
  published
)
values (
  'Nova Grand Capsule 38',
  'nova-grand-capsule-38',
  'Space Capsule House',
  'A premium capsule house model designed for resorts, Airbnb stays, scenic retreats, and modern commercial projects.',
  'Request latest price',
  'Approx. 38 sqm',
  'Resorts, Airbnb, private retreats, commercial stays',
  array['Modern capsule design', 'Large panoramic window', 'Prefab structure', 'Custom layout options'],
  'Nova Grand Capsule 38 | Luxury Capsule House for Resorts',
  'Explore the Nova Grand Capsule 38, a premium prefab capsule house for resorts, Airbnb projects, and modern retreats.',
  true
)
on conflict (slug) do nothing;