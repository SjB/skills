---
name: visual-verification
description: Verify running desktop UI changes with screenshots and recordings. Use when changing shell styling, layout, panels, menus, notifications, animations, transitions, or capture flows; inspect the artifacts before reporting completion.
disable-model-invocation: true
---

# Visual Verification

Use this before finishing a change with a visual effect. Automated tests do not
replace verification in the running UI.

1. Check the command needed for the selected branch with `command -v`. Start the
   changed UI and keep its PID if it runs in the background.
2. Capture a screenshot for layout, styling, state, or focus changes:

   ```bash
   screenshot_filename="${screenshot_filename:-visual-verification-candidate.png}"
   hyprshot -m output -m active -f "$screenshot_filename"
   ```

   `-m output -m active` captures the active output; `-f` sets the filename.
   Use `omarchy screenshot` when interactive region selection is needed.
   Capture reference and candidate states as separate files for layout or
   layer-shell changes.
3. Record a short video for animation, transition, timing, capture, or
   screen-recording changes:

   ```bash
   video_filename="${video_filename:-visual-verification.mp4}"
   screen-recorder -o "$video_filename"
   # Exercise the changed behavior.
   screen-recorder stop
   ```

4. Inspect each saved artifact for clipping, overlap, spacing, stale state,
   focus, and visual regressions. For interactive changes, use `wtype` when
   available (for example, `wtype -k Right -k Return`) and verify the resulting
   state or command output.
5. Stop only the UI process started for verification, and confirm it is the
   tracked PID. Finish when the changed behavior is visibly correct and every
   relevant screenshot or recording has been inspected.
