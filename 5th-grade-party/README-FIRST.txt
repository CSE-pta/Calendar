CSE 5th Grade Party — Profile and Chat Message Deletion

1. GitHub: Replace index.html, app.js, styles.css inside Calendar/5th-grade-party/ ONLY. Do not replace config.js or the PTA homepage.
2. Supabase SQL Editor: run CHAT_DELETE_SQL.sql. It creates an RLS DELETE policy allowing the message author or a project administrator to delete a message. It does not remove existing messages.
3. Reload website (Ctrl+Shift+R). Sign in, open My Profile, update first and last names. The full name will be used in chat.
4. Open Team Chat. A Delete control appears next to your own messages, or all messages for an admin. Confirming permanently removes that message for all users.
5. Do not publish private roster SQL, email addresses, keys, or private personal information into public GitHub files.
6. Test deletion with a disposable test chat message before inviting other people. Deletion is permanent.
7. Chat history and profile changes rely on Supabase: test live functionality after deployment.
