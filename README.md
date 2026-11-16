# Ladies First: Women's Health Collective

Website and volunteer sign-up for Ladies First: Women's Health Collective, a student-led women's health club at UMass Amherst.

## Structure

```
index.html           # The whole site: Home + Volunteer With Us (#volunteer)
assets/              # Photos, logo artwork, hearts
supabase/schema.sql  # Volunteer sign-up table + security rules
```

It's a static site with no build step. Any static host works (Vercel, Netlify, GitHub Pages).

## Settings

At the top of the `<script>` in `index.html`, edit `window.LF_CONFIG`:

- `supabaseUrl`, `supabaseKey`: from Supabase → Project Settings → API (use the **anon / publishable** key, never the service_role / secret key)
- `instagramUrl`: the club Instagram
- `eventUrl`: where the "Period packing event" heart links

## Viewing sign-ups

Supabase dashboard → Table Editor → `volunteers`. The website can only add rows; it can't read the list.
