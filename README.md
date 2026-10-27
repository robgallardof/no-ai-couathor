<a id="top"></a>

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


OpenCode and DeepSeek can also use the Git hook. For policies before tools run, use [RepoRinse](https://github.com/robgallardof/RepoRinse).

<a id="-why-move"></a>
<h2 align="center"><img src="assets/readme/sections/en-01.svg" alt="01 · Why move?" width="100%" /></h2>

| | no-ai-coauthor | RepoRinse |
|---|:---:|:---:|
| Removes AI `Co-Authored-By` trailers and "Generated with" footers | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Keeps human co-authors — even people named *Claude* | <img src="assets/readme-builder/icons/spark.svg" width="20" height="20" alt="" /> regex | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Coexists with Husky / pre-commit / lefthook (chains existing hooks) | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Never overrides your global `core.hooksPath` | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Byte-for-byte uninstall with a manifest | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Configurable (`.reporinse.toml`) and `--dry-run` everywhere | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Whitespace, invisible Unicode and change-scope checks | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Guardrails for Claude Code, Codex, Gemini CLI and Cursor | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |

<a id="-switch-in-3-steps"></a>
<h2 align="center"><img src="assets/readme/sections/en-02.svg" alt="02 · Switch in 3 steps" width="100%" /></h2>

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
<summary><b><img src="assets/readme-builder/icons/box.svg" width="20" height="20" alt="" /> Legacy documentation (no-ai-coauthor)</b></summary>

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

### Optional Docker compatibility filter

For existing legacy workflows only; RepoRinse remains the recommended replacement.
The container filters an explicitly mounted message file and does not install hooks:

```sh
docker build -t no-ai-coauthor:local .
docker run --rm --network none --user "$(id -u):$(id -g)" -v "$PWD:/repo" no-ai-coauthor:local .git/COMMIT_EDITMSG
```

Runtime UID, Compose and limitations: [Docker guide](docs/DOCKER.md).
Real image and isolated Git-hook tests: `python scripts/test_docker.py`.

<a id="-license"></a>
<h2 align="center"><img src="assets/readme/sections/en-03.svg" alt="03 · License" width="100%" /></h2>

[MIT](LICENSE)

<br/>

<p align="center"><a href="#top">Back to top</a></p>

<!-- readme-builder:signature:start -->
<p align="center"><a href="https://github.com/robgallardof"><picture><source media="(prefers-color-scheme: dark)" srcset="assets/readme/brand/signature-en-dark.svg" /><img src="assets/readme/brand/signature-en-light.svg" alt="no-ai-coauthor / Roberto Gallardo" width="100%" /></picture></a></p>
<!-- readme-builder:signature:end -->
