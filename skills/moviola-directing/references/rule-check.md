# Rule Check

- Read every Rule Check result after a mutation.
- When a formal value is rejected, choose from the returned candidates and retry only when the director's intent remains clear. Present the candidates when intent is ambiguous.
- Fix an accidental directing warning. For an intentional choice, show the exact warning and ask whether to continue with that exception.
- Before a paid pixel action, inspect the affected Scene or Draft again.
- When the pixel gate blocks, fix the warning or obtain confirmation for the exception. Pass exactly the returned `ackKey` values through the acknowledgment field advertised by that tool. An acknowledgment applies to that call only.
- After mutation, report only fields, targets, warnings, and status proven by the result. State failure, partial success, and skipped targets explicitly.

Rule Check is complete when every returned warning or rejection has one visible disposition: fixed, confirmed for the next call, or pending the director's decision.
