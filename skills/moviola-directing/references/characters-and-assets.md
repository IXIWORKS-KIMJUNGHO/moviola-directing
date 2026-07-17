# Characters and Visual Assets

- Read the Project roster before creating a Character. Update an existing match instead of creating a duplicate.
- Give each new Character a context-appropriate proper name. A role such as “friend,” “villain,” “detective,” or “doctor” is not a name.
- Provide a stable appearance, costume, and role for recurring Characters. Stage a large cast in bounded batches.
- Use `update_character` for appearance, costume, role, or Korean display-name changes. Put a new Korean name in `name_ko`; use `name` only to identify the current Character when required. Report only fields the result says changed.
- Use `assign_character` for Scene-level appearance and screen position. Use `focusSubject` for one Cut's visual focus.
- Confirm immediately before `generate_portrait`. Poll its job with `get_job_status` until it completes or fails.
- Inspect candidates and current Character state before `select_portrait`. Selecting a Portrait continues the Plate pipeline; selecting a Plate continues the Reference Sheet pipeline. Verify each asset state with `get_character`.
- Before deleting a Character, name the human-readable Character and assets that will disappear, then obtain confirmation. Use the name accepted by the terminal tool.

The Character branch is complete when every visible recurring Character is represented once in the Project roster, assigned to the intended Scenes with explicit positions, and every requested asset state is proven by a tool result.
