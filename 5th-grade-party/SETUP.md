# CSE Fifth Grade Party · Explore the Multiverse

## Included in this first version

- Responsive animated blue-gradient landing page, world-landmark portal design.
- Committee cards for six teams, with names transcribed from planning photos (verify spelling and membership).
- Suggested milestone checklist, committee filters, interactive November 2026 calendar, and budget planning overview.
- Seven open discussion rooms (all approved members may read/write) plus an administrator-only posting room (Announcements).
- Secure Supabase-based email sign-in and persistent message history **once configured**.
- Administrators can add milestones and events once configured. The static initial sample milestones remain visible until backend records exist.

## Important limits

This is a ready-to-deploy **starter site**, not a deployed or connected service. Chat messages are not stored until you configure Supabase. There is no image upload, searchable history, push notification, editable existing milestone, contact directory, document storage, or interactive budget accounting yet. Do not describe those as implemented.

**Private data:** Never copy committee phone numbers, emails, chat exports, passwords, or service_role API keys into this public repository. The HTML contains member names only; if you need membership names to be private too, move committee details behind authenticated access before publishing.

## Deploy alongside the existing PTA GitHub Pages site

1. Make a folder named `5th-grade-party` at the root of your existing PTA GitHub Pages repository.
2. Copy the site files from this folder (`index.html`, `styles.css`, `app.js`, `config.js`) into that new folder. Do not upload `supabase-schema.sql` if you prefer it outside the public repo.
3. Add a link on your PTA homepage such as `<a href="/5th-grade-party/">5th Grade Party</a>`. If your site is served under a GitHub project path rather than at the domain root, use a relative link `href="5th-grade-party/"` from the repository root homepage instead.
4. GitHub Pages serves the site automatically under `/5th-grade-party/` once GitHub deployment finishes. Existing PTA site remains unchanged except the added link.
5. Opening `index.html` directly on a computer can fail because JS uses ES modules. Preview via a local server, for example `python -m http.server 8080` in the folder then open `http://localhost:8080`.

## Activate member chat securely

1. Create a Supabase project and open its SQL Editor. Run `supabase-schema.sql` once (on an empty new project).
2. In **Authentication > Providers**, enable email magic links. Configure the Site URL and redirect allow list for your actual deployed `https://.../5th-grade-party/` URL.
3. From Supabase Project Settings copy the **Project URL** and **publishable/anon key** into `config.js`. These client-side keys are intended to be public; **never use the secret/service-role key**. Example:
   ```js
   export const SUPABASE_URL = 'https://YOURPROJECT.supabase.co';
   export const SUPABASE_ANON_KEY = 'YOUR_PUBLIC_ANON_OR_PUBLISHABLE_KEY';
   ```
4. Open your site, enter your email, click the email sign-in link.
5. In Supabase **Authentication > Users**, copy your UUID. In SQL Editor, run:
   ```sql
   insert into public.members (user_id, display_name, role)
   values ('REPLACE-THIS-WITH-YOUR-REAL-UUID', 'PTA Administrator', 'admin');
   ```
6. Sign out and back in (or reload), and verify you can send a message in `general` and `announcements`.
7. Each other volunteer signs in once; after you verify who they are, approve each UUID with role `member` using the same INSERT syntax. Unknown sign-ins have no chat or data access.
8. Verify a non-member cannot read chats; verify members cannot post to `announcements`; verify admins can.

**Privacy note:** Supabase does not inherently limit who can receive a login link; the `members` table with RLS is the enforced approval list. Email addresses and authentication data stay inside Supabase, not the GitHub repo. Admins should review Supabase service limits, data retention, consent for sharing volunteer information, and administrator recovery procedures before launch.

## Next upgrades to consider

- Uploads in a private Supabase Storage bucket with membership-aware access policies.
- Admin-managed contact directory (phone numbers), visible only to approved members.
- Editable milestone status, due dates, assigned owners, task completion and decision log.
- Proper budget entries, fundraising income, spending approvals.
- Chat message search, notification opt-in and read markers.
- Separate public student/parent info vs strictly private planning pages.

## Files

- `index.html` page structure and content
- `styles.css` responsive visual design
- `app.js` navigation, committee cards, calendar, milestones, authentication, optional persisted chat
- `config.js` Supabase configuration (blank by default)
- `supabase-schema.sql` secure tables and database policies
