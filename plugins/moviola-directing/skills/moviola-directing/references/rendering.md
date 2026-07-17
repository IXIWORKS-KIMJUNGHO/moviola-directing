# Storyboards, Renders, and Animatics

- Use `generate_storyboard` for the initial Sketch board.
- Use `regenerate_cut` for one existing Cut and `regenerate_board` once for a whole-board request. Update semantic Cut fields before confirming and rerendering.
- Use `finalize_render` only after Sketch images exist. Pass exactly `Digital Art` or `Photorealistic` when those are the advertised values.
- Use `animate_cut` for one Cut and `animate_draft` for a requested batch. Poll `get_clip_status`; use `list_clips` to inspect the Draft's clip set.
- Treat image and video generation, rerendering, finalization, Portrait generation, and asset selections that trigger downstream generation as paid or high-impact. State the target and affected Cut count, then obtain confirmation immediately before the call.
- Treat `job_id` and `clip_id` as queued or processing. Poll the matching status tool and report completed, failed, or still processing from its result.

The rendering branch is complete when the requested jobs are either proven complete, proven failed, or accurately handed back as still processing with their identifiers.
