CSE Party public dashboard and sign-in cleanup

Replace ONLY index.html, app.js, and styles.css in Calendar/5th-grade-party/ on GitHub. Do not replace config.js or change Supabase.

Changes: Four home statistics cards remain visible before sign-in. All protected committee, calendar, budget, chat, and document areas remain gated. Normal sign-in hides the Save new password button. It appears only when following a recovery link or selecting Account / Password while signed in.

Refresh website using Ctrl+Shift+R after GitHub Pages deploys. Test in a signed-out/private window and a signed-in window. Security also requires Supabase Row Level Security and private storage; front-end hiding alone does not secure content.
