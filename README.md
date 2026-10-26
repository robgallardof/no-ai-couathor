<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/readme/banner-en-dark.svg">
  <img src="assets/readme/banner-en-light.svg" alt="no-ai-coauthor — This project moved to RepoRinse" width="100%">
</picture>


> [!IMPORTANT]
> **This project has moved.** no-ai-coauthor is no longer maintained.
> Its successor is **[RepoRinse](https://github.com/robgallardof/RepoRinse)** — same goal, safer and much more complete.

<a href="https://github.com/robgallardof/RepoRinse">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://socialify.git.ci/robgallardof/RepoRinse/image?theme=Dark&font=Inter&language=1&description=1&name=1&owner=1&pattern=Circuit%20Board" />
    <img src="https://socialify.git.ci/robgallardof/RepoRinse/image?theme=Light&font=Inter&language=1&description=1&name=1&owner=1&pattern=Circuit%20Board" alt="RepoRinse" width="80%" />
  </picture>
</a>

<br/><br/>

<a href="https://github.com/robgallardof/RepoRinse"><img src="https://img.shields.io/badge/Go%20to-RepoRinse-6D28D9?style=for-the-badge&logo=github&logoColor=white" alt="Go to RepoRinse" /></a>
<a href="https://github.com/robgallardof/RepoRinse/blob/main/docs/migration/no-ai-couathor.md"><img src="https://img.shields.io/badge/Migration-guide-0EA5E9?style=for-the-badge&logo=readthedocs&logoColor=white" alt="Migration guide" /></a>

![status](https://img.shields.io/badge/status-deprecated-lightgrey)
![license](https://img.shields.io/badge/license-MIT-blue)

**English** · [Español](README.es.md)

</div>

<p align="center"><img src="assets/readme/divider.svg" alt="" width="80%" /></p>

<a id="-why-move"></a>
<p align="center"><img src="assets/readme/sections/en-01.svg" alt="01 · Why move?" width="100%" /></p>

| | no-ai-coauthor | RepoRinse |
|---|:---:|:---:|
| Removes AI `Co-Authored-By` trailers and "Generated with" footers | ✅ | ✅ |
| Keeps human co-authors — even people named *Claude* | ⚠️ regex | ✅ |
| Coexists with Husky / pre-commit / lefthook (chains existing hooks) | ❌ | ✅ |
| Never overrides your global `core.hooksPath` | ❌ | ✅ |
| Byte-for-byte uninstall with a manifest | ❌ | ✅ |
| Configurable (`.reporinse.toml`) and `--dry-run` everywhere | ❌ | ✅ |
| Whitespace, invisible Unicode and change-scope checks | ❌ | ✅ |
| Guardrails for Claude Code, Codex, Gemini CLI and Cursor | ❌ | ✅ |

<a id="-switch-in-3-steps"></a>
<p align="center"><img src="assets/readme/sections/en-02.svg" alt="02 · Switch in 3 steps" width="100%" /></p>

**1. Remove the old hook** (from your clone of this repository):

```sh
./install.sh --uninstall                 # global install
./install.sh --uninstall --repo PATH     # per-repository install
```
```powershell
.\install.ps1 -Uninstall
.\install.ps1 -Uninstall -Repo PATH
```

**2. Install RepoRinse** — follow its [installation guide](https://github.com/robgallardof/RepoRinse#-install).

**3. Install the replacement hook:**

```sh
reporinse install --provider git --only git.ai-attribution --yes                 # one repository
reporinse install --provider git --scope user --only git.ai-attribution --yes    # every repository
```

Not ready to remove the old hook yet? A repo-scope RepoRinse install keeps it working: it is chained and runs first.
All the details, including what is automated and what is manual, are in the
**[migration guide](https://github.com/robgallardof/RepoRinse/blob/main/docs/migration/no-ai-couathor.md)**.

<p align="center"><img src="assets/readme/divider.svg" alt="" width="80%" /></p>

<details>
<summary><b>📦 Legacy documentation (no-ai-coauthor)</b></summary>

### What it did

A tiny POSIX `sh` `commit-msg` hook that removed `Co-Authored-By:` trailers mentioning Claude, Anthropic, OpenAI,
ChatGPT, Codex, Gemini, Copilot or Cursor, and `Generated with Claude Code` lines.

### Install (not recommended — use RepoRinse)

```sh
git clone https://github.com/robgallardof/no-ai-couathor.git
cd no-ai-couathor
./install.sh                    # global (sets core.hooksPath to ~/.config/git/hooks)
./install.sh --repo PATH        # a single repository
```
```powershell
.\install.ps1
.\install.ps1 -Repo C:\path\to\your\repo
```

### Uninstall

```sh
./install.sh --uninstall
./install.sh --uninstall --repo PATH
```

Only removes the hook if it is ours, and restores any `commit-msg.bak`. Tests: `./test.sh`.

</details>

<a id="-license"></a>
<p align="center"><img src="assets/readme/sections/en-03.svg" alt="03 · License" width="100%" /></p>

[MIT](LICENSE)

<br/>

<img src="assets/readme/footer-en.svg" alt="no-ai-coauthor" width="100%" />
