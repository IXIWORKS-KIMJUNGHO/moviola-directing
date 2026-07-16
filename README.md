# MOVIOLA Directing

Direct, author, edit, and review MOVIOLA Drafts from Claude Code, Cursor, or
Codex. The skill combines MOVIOLA's canonical Directing Rules with a safe MCP
workflow for Scenes, Cuts, Storyboards, Characters, and Animatics.

## Install the Agent Skill

Install `moviola-directing` globally for Claude Code, Cursor, and Codex:

```bash
npx skills add IXIWORKS-KIMJUNGHO/moviola-directing \
  --skill moviola-directing \
  --global \
  --agent claude-code --agent cursor --agent codex \
  --yes
```

## Install the Codex plugin

The Codex plugin packages the same skill. Install either the Agent Skill above
or this plugin; installing both is unnecessary.

```bash
codex plugin marketplace add IXIWORKS-KIMJUNGHO/moviola-directing --ref main
codex plugin add moviola-directing@ixiworks-moviola
```

## Connect MOVIOLA MCP

Create a personal token in MOVIOLA under **Settings → Personal tokens**. Keep
the token in an environment variable rather than a config file:

```bash
export MOVIOLA_PAT="mv_pat_replace_with_your_token"
codex mcp add moviola \
  --url https://storyboard-api.fly.dev/mcp \
  --bearer-token-env-var MOVIOLA_PAT
```

For Claude Code:

```bash
claude mcp add --transport http moviola https://storyboard-api.fly.dev/mcp \
  --header "Authorization: Bearer $MOVIOLA_PAT"
```

The skill always asks you to select an explicit Project and Draft. It advises
freely, but waits for your direction before destructive changes, broad
structural edits, rerenders, or paid image and video generation.

## Repository layout

- `skills/moviola-directing`: cross-agent skill discovered by `npx skills`
- `plugins/moviola-directing`: Codex plugin package
- `.agents/plugins/marketplace.json`: Codex marketplace catalog

These files are generated release artifacts. MOVIOLA's server-side Directing
Rules remain the canonical source.
