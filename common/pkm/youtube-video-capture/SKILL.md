---
name: youtube-video-capture
description: Fetch subtitles from a YouTube video, summarize the content, and save both the summary and raw subtitles to the Video bundle in the Obsidian vault. Use when the user wants to capture a YouTube video, mentions "summarize this video", "capture this talk", or pastes a YouTube URL wanting it saved to vault.
disable-model-invocation: true
---

Capture a YouTube video into the Obsidian vault. Extract subtitles, produce a summary, and save both to the `Video/` bundle as OKF-conformant notes.

## Dependencies

`yt-dlp` must be installed. Check with `which yt-dlp`. If missing, tell the user to install it (`pip install yt-dlp` or `brew install yt-dlp`) and stop.

## Extract subtitles

Run `yt-dlp` to download auto-generated English subtitles as SRT:

```bash
yt-dlp --write-auto-subs --sub-lang en-orig --convert-subs srt --skip-download -o "/tmp/yt-subs-%(id)s.%(ext)s" "<url>"
```

If no subtitles are available, tell the user and stop.

Read the SRT file. Strip timestamps and sequence numbers to produce clean, contiguous text for summarization.

## Summarize

Produce a prose summary from the full subtitle text. Synthesize the content — do not regurgitate the transcript. Then extract **key takeaways** as a bulleted list.

## Write to vault

The vault root is `/home/sjb/Documents/sjb-brain/`. The `Video/` bundle is an OKF bundle. Create the directory if it doesn't exist, with an `index.md` and `log.md` following the pattern of other bundles in the vault.

### Filenames

- Summary: `YYYY-MM-DD_HH-mm_<kebab-case-title>.md`
- Subtitle: `YYYY-MM-DD_HH-mm_<kebab-case-title>.srt`

Use the video title, kebab-cased.

### Summary note

Write a markdown note with OKF v0.1 frontmatter:

```yaml
---
id: <kebab-case-title>
type: Video Summary
aliases: []
tags: [video, youtube, <content-derived-tags>]
area: <derived-from-content-or-empty>
project: ''
---
```

Body:

- Video title as the note's `#` heading
- Link to the original YouTube URL
- The prose summary
- `## Key Takeaways` with bulleted list
- `## Subtitle` with a markdown link to the `.srt` file

Use standard markdown links, never `[[wikilinks]]`.

### Subtitle file

Copy the SRT file into `Video/` alongside the summary. No frontmatter.

### Bundle maintenance

After writing the pair:

1. Update `Video/index.md` — add the new summary under a `## Flat Notes` or appropriate heading, with a one-line description.
2. Append an entry to `Video/log.md` noting the addition with a timestamp.

### Safety

- If a filename collides, append a numeric suffix.
- Redact likely credentials, secrets, or tokens from any inline content.
- If the video has no subtitles, stop — do not attempt to transcribe.
