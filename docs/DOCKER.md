# Optional legacy compatibility filter

This project remains deprecated. New installations should use
[RepoRinse](https://github.com/robgallardof/RepoRinse), whose Docker image supports
repository checks and fixes with a maintained rule engine. This image only packages
the existing legacy message filter; its documented regex limitations still apply.

```sh
docker build -t no-ai-coauthor:local .
docker run --rm --network none -v "$PWD:/repo" no-ai-coauthor:local --help
docker run --rm --network none --user "$(id -u):$(id -g)" \
  -v "$PWD:/repo" no-ai-coauthor:local .git/COMMIT_EDITMSG
```

PowerShell:

```powershell
docker run --rm --network none -v "${PWD}:/repo" no-ai-coauthor:local .git/COMMIT_EDITMSG
```

The named existing file is edited in place, exactly as by the old hook. The runtime
is non-root, needs no network or port, and rejects files outside `/repo`. It does not
install a Git hook, change host configuration, or run a daemon. For automatic hook
execution, install RepoRinse natively; its executable must be reachable from host Git.

Compose is also one-shot:

```sh
NO_AI_COAUTHOR_REPO=/path/to/repo NO_AI_COAUTHOR_USER="$(id -u):$(id -g)" \
  docker compose run --rm no-ai-coauthor .git/COMMIT_EDITMSG
```

`NO_AI_COAUTHOR_REPO` defaults to the current project; `NO_AI_COAUTHOR_USER` defaults
to `10001:10001`. Linux mounts generally need your host UID:GID. Compose uses a
read-only container filesystem, writable repository mount, temporary `/tmp`, no
network, dropped capabilities and no privilege escalation.

Verification:

```sh
python scripts/test_docker.py
```

The image build runs the original real-Git hook/install/uninstall test in an isolated
container. The runtime smoke test uses only temporary messages, checks the non-root
identity, human-trailer preservation, idempotence, path refusal and Compose. It never
installs anything in your real repositories or global Git configuration.

### Verification — 2026-10-26

The image built successfully on Docker Desktop (Linux containers) and ran the
original real-Git cases during its verification stage. The runtime smoke test
passed for UID 10001, a message filename with spaces, AI-trailer removal, human
trailer preservation, repeat-run idempotence, outside/missing-path refusal and
Compose with no network. Native PowerShell hook installation was NOT EXECUTED;
the existing hook's regex behaviour and deprecation status remain unchanged.
