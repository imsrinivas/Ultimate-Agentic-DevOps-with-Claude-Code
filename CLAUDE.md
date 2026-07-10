# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **DMI (DevOps Micro Internship) Week 1 assignment** — a static portfolio website designed as a learning exercise for deploying static sites with Nginx on Ubuntu Linux. There is no build process, testing framework, or package manager.

**Purpose:** Students deploy this to an Ubuntu VM using Nginx and keep it live for 24 hours to demonstrate Linux and web server fundamentals.

## File Structure

- **index.html** — Main portfolio landing page. Contains the primary content and footer (see ownership proof requirement below).
- **style.css** — All styling for the site. Single stylesheet shared across all pages.
- **privacy.html, terms.html** — Additional pages linked from the main site.
- **images/** — Static assets (logos, icons, etc.). Served as-is by Nginx.
- **README.md** — Student-facing deployment instructions.

## Ownership Proof Requirement (DMI Rule)

Before deployment, the site footer in `index.html` **must** be edited to include the deployer's details. The original footer:

```html
<p>Crafted with <span>cloud</span> excellence by Pravin Mishra</p>
```

Must be updated to something like:

```html
<p><strong>Deployed by:</strong> DMI Cohort 2 | [Name] | Group [#] | Week 1 | [Date]</p>
```

This visible footer text serves as proof of ownership and deployment. Screenshots of the running site with the edited footer are required for submission.

## Local Development

Since this is a static site, you can test locally without any build step:

```bash
# Option 1: Use Python's built-in server (Python 3)
python3 -m http.server 8000

# Option 2: Use Node's http-server (if installed)
npx http-server

# Then visit http://localhost:8000
```

Open `index.html` directly in a browser to see the site (though this won't work properly for all assets if the HTML uses absolute paths).

## Deployment

**Target:** Ubuntu VM with Nginx

**Quick steps:**
1. SSH into Ubuntu VM
2. Install Nginx: `sudo apt install nginx -y`
3. Clone repo to `/var/www/html` or upload files directly
4. Ensure `index.html` footer is edited with deployment details
5. Start Nginx: `sudo systemctl start nginx`
6. Access via `http://<public-ip>`

See README.md for full deployment guide.

## Git Workflow

Per global CLAUDE.md: all changes go to the `claude-updates` branch, never directly to `main`. After each session, stage and push to `claude-updates` for Srinivas to review and merge.

## Common Tasks

**Updating the portfolio content:** Edit `index.html` directly. Changes will be visible on any deployed instance after reloading.

**Changing styling:** Modify `style.css`. Single stylesheet means you can search by class/ID easily.

**Adding images:** Place in `images/` folder and reference in HTML as `images/filename.ext`.

**Testing changes before deployment:** Use the local server commands above to verify in a browser.

## Important Notes

- No build tools, transpilers, or asset processing — this is raw HTML/CSS/images.
- Nginx serves files from `/var/www/html` by default; ensure paths in HTML are relative or absolute depending on deployment context.
- The site is intentionally simple to keep focus on Linux and web server skills, not frontend complexity.
