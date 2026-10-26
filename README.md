<div align="center">

# ✂️ no-ai-coauthor

**Your commits, your name.**<br>
A tiny Git hook that strips AI attribution from every commit message —<br>
Claude Code, Copilot, Codex, Cursor, Gemini or any other agent.

![git hook](https://img.shields.io/badge/git-commit--msg%20hook-F05032?logo=git&logoColor=white)
![shell](https://img.shields.io/badge/POSIX-sh-4EAA25?logo=gnubash&logoColor=white)
![platforms](https://img.shields.io/badge/macOS%20%7C%20Linux%20%7C%20Windows-supported-0078D4)
![dependencies](https://img.shields.io/badge/dependencies-zero-2ea44f)
![license](https://img.shields.io/badge/license-MIT-blue)

**English** · [Español](README.es.md)

</div>

---

## ✨ What it does

AI coding agents like to sign your commits. This hook runs right before Git saves the message and quietly removes
those lines, so the history only shows the people who actually own the work.

<table>
<tr><th>Before</th><th>After</th></tr>
<tr><td>

```text
feat: add login with magic link

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

</td><td>

```text
feat: add login with magic link
```

</td></tr>
</table>

| | |
|---|---|
| 🧹 **Removes** | `Co-Authored-By:` trailers mentioning **Claude, Anthropic, OpenAI, ChatGPT, Codex, Gemini, Copilot or Cursor**, and `Generated with Claude Code` lines (with or without the 🤖). |
| 🤝 **Keeps** | Human co-authors, the rest of your message, and any commit that merely *mentions* those names in its text. |
| 🧽 **Tidies** | Trailing blank lines left behind. |
| 🌍 **Works with every agent** | It is a plain Git hook: it doesn't matter which tool wrote the commit. |
| 🪶 **Zero dependencies** | ~10 lines of POSIX `sh` + `grep` + `awk`, which ship with Git everywhere (including Git for Windows). |

## 🚀 Installation

```sh
git clone https://github.com/robgallardof/no-ai-couathor.git
cd no-ai-couathor
```

### Option A — every repository on your machine (recommended)

<details open>
<summary><b>macOS / Linux / Git Bash</b></summary>

```sh
./install.sh
```

</details>

<details open>
<summary><b>Windows (PowerShell)</b></summary>

```powershell
.\install.ps1
```

> If scripts are blocked: `powershell -ExecutionPolicy Bypass -File .\install.ps1`

</details>

This copies the hook to `~/.config/git/hooks/` and points Git's global `core.hooksPath` there.

> [!NOTE]
> A global `core.hooksPath` makes Git ignore the hooks inside each repository's `.git/hooks/`. If a project relies on
> its own hooks (husky, pre-commit, lefthook…), use **Option B** for that project instead. Repositories that set their
> own `core.hooksPath` keep using it.

### Option B — a single repository

```sh
./install.sh --repo /path/to/your/repo
```
```powershell
.\install.ps1 -Repo C:\path\to\your\repo
```

If the repository already had a `commit-msg` hook, it is kept as `commit-msg.bak`.

### Option C — ship it inside a project

Copy `hooks/commit-msg` into the project as `.githooks/commit-msg`, commit it, and ask each clone to enable it once:

```sh
git config core.hooksPath .githooks
```

## ✅ Check that it works

```sh
git commit --allow-empty -m "test" -m "Co-Authored-By: Claude <noreply@anthropic.com>"
git log -1 --format=%B      # → only "test"
git reset --soft HEAD~1     # undo the test commit
```

Or run the bundled tests: `./test.sh`

## 🗑️ Uninstall

```sh
./install.sh --uninstall                # global
./install.sh --uninstall --repo PATH    # one repository
```
```powershell
.\install.ps1 -Uninstall
.\install.ps1 -Uninstall -Repo PATH
```

Only removes the hook if it is ours, and restores any `commit-msg.bak`.

## 💡 Tip: also turn it off at the source

Claude Code can skip the attribution itself. In `~/.claude/settings.json`:

```json
{
  "attribution": { "commit": "", "pr": "" }
}
```

(older versions: `"includeCoAuthoredBy": false`). The hook is still worth having: it covers every agent, every
machine setting you forget, and pull-request descriptions don't go through Git anyway.

## ❓ FAQ

<details>
<summary><b>Does it touch commits that are already in history?</b></summary>

No. It only cleans new commits (including `--amend`, merges and rebases that create a message). To rewrite old
history use `git rebase -i` or `git filter-repo`.
</details>

<details>
<summary><b>Can it be skipped?</b></summary>

Yes, like any client-side hook: `git commit --no-verify` doesn't run it. Agents normally don't use that flag.
</details>

<details>
<summary><b>How do I add another tool to the list?</b></summary>

Edit the pattern in `hooks/commit-msg` — the names are in `(claude|anthropic|openai|…)` — and reinstall.
</details>

## 📄 License

[MIT](LICENSE)
