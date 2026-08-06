CSE PTA GITHUB PAGES — CLEAN DEPLOY PACKAGE

Upload every file in this folder to the ROOT of the Calendar repository on the main branch.

Required GitHub Pages settings:
- Source: Deploy from a branch
- Branch: main
- Folder: / (root)

Files:
- index.html — public PTA calendar
- pta_calendar.html — PTA calendar editor/admin page
- pta_calendar_functions.csv — live calendar event data
- pta_calendar_dropdown_menu_items.json — calendar dropdown data
- kindergarten-parent-guide.html — guide landing page
- CSE-Kindergarten-Parent-Guide-2026-2027.pdf — downloadable guide
- 2026-8-6 Cypress Springs Elementary School PTA General Calendar.pdf — printable calendar
- .nojekyll — tells GitHub Pages this is a plain static website

Expected addresses after a successful GitHub deployment:
https://cse-pta.github.io/Calendar/
https://cse-pta.github.io/Calendar/kindergarten-parent-guide.html

Temporary addresses during a GitHub Pages outage:
https://raw.githack.com/CSE-pta/Calendar/main/index.html
https://raw.githack.com/CSE-pta/Calendar/main/kindergarten-parent-guide.html

Do not repeatedly delete and re-upload index.html. Upload this set once and wait for one deployment.
