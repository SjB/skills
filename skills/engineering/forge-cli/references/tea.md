# Tea recipe

Tea calls the numeric identifier an `index`; it is still the tracker issue/PR ID. Use `--output json` for reads. Tea accepts comma-separated usernames/labels for the plural flags.

## Read

```bash
tea issues ID --comments --output json --fields index,state,url,title,body,assignees,labels,comments
tea issues list --state all --limit 100 --output json --fields index,state,url,title,body,assignees,labels
tea pulls PR --comments --output json --fields index,state,url,title,body,assignees,labels,base,head,comments,ci
```

Native parent, child, and dependency fields may be unavailable. If absent, use the explicit links documented in the ticket.

## Issue lifecycle

```bash
tea issues edit --add-assignees USER ID
tea issues edit --add-labels NEW --remove-labels OLD ID
tea comments add ID --description "$(cat BODY_FILE)"
tea issues close ID
```

## Pull request lifecycle

```bash
tea pulls create --base BASE --head HEAD --title TITLE --description "$(cat BODY_FILE)"
tea comments add PR --description "$(cat BODY_FILE)"
tea pulls merge PR --style squash
```

Use `tea comments add` for review findings or requested changes. Re-read the issue/PR after every mutation.
