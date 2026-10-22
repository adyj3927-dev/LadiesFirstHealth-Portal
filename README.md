
Ladies First: Women's Health Collective — Website
Website and volunteer portal for Ladies First: Women's Health Collective, a student-led women's health club at UMass Amherst.

Structure
ladies-first-health/
├── volunteer-portal/   # Volunteer sign-up page (live now)
│   └── index.html
├── supabase/
│   └── schema.sql      # Database table + security rules
└── README.md
The main club website will be added to this repo later.

Volunteer portal setup
Create a Supabase project.
Open SQL Editor, paste supabase/schema.sql, and run it.
Go to Project Settings → API and copy the Project URL and the anon public key.
Paste both into the top of the <script> in volunteer-portal/index.html.
Open the page and submit a test sign-up.
The anon key is safe to commit: Row Level Security only allows inserts, so the public can't read anyone's info. Never commit the service_role key.

Viewing sign-ups
Supabase dashboard → Table Editor → volunteers. Use the export option there to download a CSV for the e-board.

Deploying
GitHub Pages: repo Settings → Pages, deploy from the main branch. The portal will be at https://<username>.github.io/ladies-first-health/volunteer-portal/.


