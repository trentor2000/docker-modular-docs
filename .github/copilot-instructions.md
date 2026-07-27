# Copilot Instructions for docker-modular-docs

## Quick Start

### Build & Development Commands

**Local Development (Docker)**
```bash
docker-compose up
```
Runs MkDocs dev server at `http://localhost:8000`. Changes to `.md` files hot-reload automatically.

**Direct Python Development**
```bash
pip install mkdocs mkdocs-material mkdocs-material-extensions mkdocs-awesome-pages-plugin mkdocs-git-revision-date-localized-plugin
mkdocs serve
```

**Build Static Site**
```bash
mkdocs build
```
Generates `site/` directory with static HTML.

**Deploy to GitHub Pages**
```bash
mkdocs gh-deploy --force
```
(This is automated via GitHub Actions on push to `master`)

## Architecture & Structure

### Project Overview
This is a **MkDocs-based documentation site** for Docker infrastructure, designed for educational purposes. It covers modular Docker architectures with reproducible configurations for teaching.

### Key Directory Structure
- **docs/** - All markdown content organized by topic
  - `index.md` - Homepage/intro
  - `arquitectura/` - Technical architecture diagrams and design principles
  - `scripts/` - Documentation for infrastructure shell scripts
  - `labs/` - 6 hands-on laboratory exercises for students
  - `pedagogia/` - Teaching models and best practices
  - `manuales/` - User guides (students, teachers, quick reference)
  - `whitepaper/` - Technical justification and design patterns
  - `buenas-practicas/` - Best practices across security, networking, persistence, etc.
  - `anexos/` - Installation guides and appendices
  - `apendices/` - FAQ, troubleshooting, glossary

### Site Configuration
- **mkdocs.yml** - Defines theme (Material), language (Spanish), navigation structure, and markdown extensions
- Theme features include: tabbed navigation, syntax highlighting, emoji support, code copying
- Built-in search and tags plugin enabled

### Deployment
- **Dockerfile** - Python 3.11 slim image with MkDocs + Material + plugins
- **docker-compose.yml** - Simple service exposing port 8000
- **.github/workflows/deploy.yml** - Automated deployment to GitHub Pages on push to `master`

## Key Conventions

### Content Organization
- **Language**: All documentation is in Spanish (es)
- **Markdown Format**: Standard markdown with Material theme extensions
  - Use `pymdownx` extensions for advanced features (tabs, details, emoji, syntax highlighting)
  - Code blocks include line numbers and annotation support
  - Tabs use alternate style for modern appearance

### Navigation Structure (mkdocs.yml)
- Site is organized hierarchically via `nav:` section in mkdocs.yml
- Each nav entry links to a .md file in docs/
- Add new pages by:
  1. Creating `.md` file in appropriate subdirectory
  2. Adding entry to `nav:` section in mkdocs.yml (maintains order)

### Content Style
- Use descriptive page titles that appear in navigation
- Include metadata in .md files (Material supports front matter if needed)
- Code examples should be runnable shell commands or docker-compose snippets
- Labs section has 6 sequential exercises building skills progressively

### Build Artifacts
- `.gitignore` excludes `site/` (build output), `__pycache__/`, and local docker compose files
- Don't commit built files — they're generated during deployment

## Workflow Tips

**Adding Content**
1. Create new `.md` file in appropriate `docs/*/` subdirectory
2. Update `mkdocs.yml` nav structure to include the new file
3. Test locally: `docker-compose up` or `mkdocs serve`
4. Push to `master` — GitHub Actions handles deployment automatically

**Editing Content**
- Small typo fixes: just edit the .md file
- Major restructuring: coordinate updates to `mkdocs.yml` nav section
- Links are relative to root (e.g., `docs/archivo.md` → reference as `archivo.md`)

**Docker Development**
- Volumes are mounted, so changes persist
- Container runs `mkdocs serve -a 0.0.0.0:8000`
- Port 8000 exposed for browser access
- Run `docker-compose down` to stop

## Common Issues

- **Changes not appearing**: Check browser cache or hard refresh (Ctrl+Shift+R)
- **Import errors in mkdocs.yml**: Ensure all extensions in pip install are listed in Dockerfile and workflow
- **GitHub Pages not updating**: Verify workflow permissions (needs write access) and check Actions tab for failures
