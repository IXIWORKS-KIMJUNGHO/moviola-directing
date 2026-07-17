# Authoring and Editing

## Use the terminal model's own brain

The terminal seat does not expose `create_scenario`, `ai_shot`, `ai_shot_all`, `advise`, or `revision_proposal`. Perform that creative reasoning directly, then persist it through semantic edit tools.

- For a whole story from an empty Draft, establish a one-sentence concept and causal Scene flow, state the intended Scene count, then create each Scene with its complete planned Cuts in one `add_scene` call per Scene. Build the Draft when asked; do not stop at prose.
- Establish the recurring principal cast before writing the whole story. Follow the Character contract selected from `SKILL.md`, and assign visible Characters after each Scene exists.
- Use 5–8 Scenes, 3–6 Cuts per Scene, and at most 40 Cuts as short-film defaults, not hard limits. Follow the director's requested scale while staging an excessive request in bounded batches.
- For one Scene, call `add_scene` once with all available `location`, `description`, `timeOfDay`, `weather`, `mood`, and `cuts`. Infer a cheap missing detail from the established story and state the assumption.
- Insert an opening Scene with `afterOrder: 0`; insert after a known Scene with that Scene's order.
- When the director declares a supported genre, call `set_draft_genre`, refresh the Draft briefing, then use the genre guide selected from `SKILL.md`.
- Write concrete visual Cut descriptions containing people, actions, props, spatial relationships, and visible details. Store shot size, angle, lens, composition, and movement only in their dedicated fields.
- Keep Character names, fixed appearance, costume, screen position, props, and the 180-degree screen axis continuous unless the work shows a deliberate change.
- Choose coverage from dramatic intent: master or two-shot for relationship, OTS/reverse/POV/reaction for dialogue, and motivated movement for action or emotional change. Vary coverage only when the beat calls for it.
- Use only values advertised by the current tool schema. Report a rejected value instead of guessing or silently normalizing it.

## Route edits by meaning

- Add a complete Scene and its Cuts with `add_scene`.
- Add or split blank Cut slots inside an existing Scene with `add_cut`; then fill required fields with `update_cut`. Keep a Cut split inside its Scene.
- Change one existing Cut field with `update_cut`. Use `field: focusSubject` for the Character or object that a Cut watches.
- Place an existing Character into a Scene with `assign_character` and an explicit screen position.
- Delete, move, or duplicate a Cut with `delete_cut`, `move_cut`, or `duplicate_cut`. A duplicated Cut receives a new identifier and does not copy its image or video.
- Move a Scene with `move_scene`. Delete one with `delete_scene`, using the human-readable Scene name and visible Cut count when its schema requests them.
- Preserve Scene and Cut identifiers. Change structure with its dedicated tool; never rewrite `id` or `order` through `update_cut`.
- When no semantic tool can change a requested Scene-level field, state the limitation and offer a feasible Cut-level alternative.

Terminal conversation is not stored by MOVIOLA. Scenes, Cuts, North Star, and Decision Memo are the shared memory between seats; record durable intent there through the available semantic tools.
