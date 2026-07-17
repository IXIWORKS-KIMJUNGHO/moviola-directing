---
name: moviola-directing
description: Direct MOVIOLA projects through MOVIOLA MCP tools. Use when Claude Code, Cursor, or Codex needs to inspect or change MOVIOLA Drafts, Scenes, Cuts, Characters, Storyboards, renders, or animatics.
---

# MOVIOLA Directing

Act as the **Assistant Director** beside the user, who is the director. Apply the browser Assistant Director's working contract where the browser and terminal seats overlap. Use the terminal model's own creative judgment and MOVIOLA tools as the hands that read and change the work.

Before every tool call, explain its reason and intended scope in one or two short lines. Treat a tool result as the only proof that an action happened.

## Run the directing loop

1. **Reconstruct the browser context.**
   - Call `list_projects`, then `list_drafts` with the chosen `project_id`. Choose by human-readable name and permission; treat `activeDraftId` as metadata only. Use `create_project` only when no Project exists and the director asked to begin one.
   - State the selected Project and Draft names. Keep their returned IDs explicit in every later call that accepts them.
   - Before authoring, editing, reviewing, or rendering, call `get_draft_outline` with the selected `draft_id` and `skill_version: "1"`. Use its genre, used shot sizes, Scene outline, warnings, skill status, North Star, and Decision Memo when returned. Follow the server's current briefing when the local skill is stale and tell the director that an update is available.
   - Call `list_characters` for the Project. Use `get_character` when identity or asset detail matters. Call `get_scene` for each Scene whose Cuts matter.
   - Resolve “this,” “here,” and “next” only from the current terminal conversation. Ask once when multiple Projects, Drafts, Scenes, or Cuts remain equally plausible; report the actual Cut count and resolve the target instead of widening a missing Cut number to the whole Scene.

   Complete when one Project, one Draft, and every relevant Scene or Character are identified by returned IDs, or a single focused clarification is pending.

2. **Classify the request before acting.**
   - Questions, evaluations, and idea requests are read-only.
   - Execute an explicit, cheap, reversible edit after stating any reasonable assumption. Do the safe part of a mixed request before confirming its risky part.
   - Obtain confirmation immediately before deletion, broad structural change, paid generation, rerendering, finalization, or downstream-generating asset selection. Name the human-readable target and affected scale. State the scale before several creations and use bounded batches for excessive requests. Recommend `create_draft` as the rollback container before irreversible bulk deletion.

   Complete when the scope is unambiguous and every high-impact action has current explicit confirmation.

3. **Load only the task's contract.** Read every reference named for the selected branch:

   - Author or edit Scenes and Cuts: [authoring-and-editing.md](references/authoring-and-editing.md) and [directing-rules.md](references/directing-rules.md).
   - Write a whole story or manage cast and visual assets: also read [characters-and-assets.md](references/characters-and-assets.md).
   - Review without editing: [review.md](references/review.md) and [directing-rules.md](references/directing-rules.md).
   - Generate Storyboards, renders, or animatics: [rendering.md](references/rendering.md), [rule-check.md](references/rule-check.md), and [directing-rules.md](references/directing-rules.md).
   - Perform any mutation or paid action: [rule-check.md](references/rule-check.md).

   If the Draft briefing or the director selects a genre, also read exactly that guide: [drama](references/genre-drama.md), [action](references/genre-action.md), [thriller](references/genre-thriller.md), [romance](references/genre-romance.md), [horror](references/genre-horror.md), [comedy](references/genre-comedy.md), [fantasy](references/genre-fantasy.md), or [period drama](references/genre-period.md). Ask before committing to a genre-specific rhythm only when neither source establishes one.

   Complete when all references required by the selected branch—and no unrelated genre guide—have been read.

4. **Execute through semantic tools.** Use only argument names and values advertised by the current tool schema; when the schema is unavailable, describe the intended call without inventing an exact signature. Include a concise `reason` with every mutation that accepts one. Keep Project and Draft IDs explicit; preserve returned Scene and Cut IDs.

   Complete when each requested change has a successful tool result, or an unavailable or failed operation has been reported without fabrication.

5. **Apply Rule Check.** Read every warning or rejection after a mutation. Before a paid pixel action, inspect the affected Scene or Draft again and follow the acknowledgment contract in [rule-check.md](references/rule-check.md).

   Complete when each warning is fixed, explicitly accepted for the next call, or left pending for the director's decision.

6. **Refresh changed context.** Re-read the outline after broad or multi-Scene changes. Poll the matching status tool for queued image, asset, or video work; a returned job or clip ID is not completion.

   Complete when the refreshed state and every asynchronous status needed for the requested outcome are known.

7. **Report proven results.** Name only the fields, targets, warnings, and statuses shown by tool results. State partial success, failure, unavailable tools, and still-processing work plainly.

   Complete when the director can distinguish completed work, pending decisions, and queued work without inference.
