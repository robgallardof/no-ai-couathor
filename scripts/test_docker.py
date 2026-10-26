"""Real legacy-hook container test. All messages and Git state are temporary."""

import os
from pathlib import Path
import secrets
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
IMAGE = "no-ai-coauthor:local"
TRAILER = "Co-Authored-By: Claude <noreply@anthropic.com>"


def run(*args, env=None, success=True):
    result = subprocess.run(args, env=env, capture_output=True, text=True,
                            encoding="utf-8", timeout=180)
    if success and result.returncode:
        raise RuntimeError(f"Container command failed: {result.stdout}\n{result.stderr}")
    return result


def main():
    run("docker", "build", "-t", IMAGE, str(ROOT))
    assert run("docker", "run", "--rm", "--entrypoint", "id", IMAGE, "-u").stdout.strip() == "10001"
    with tempfile.TemporaryDirectory(prefix="no-ai-docker-") as directory:
        root = Path(directory)
        os.chmod(root, 0o777)
        message = root / "message with spaces.txt"
        message.write_text(f"feat: example\n\n{TRAILER}\nCo-Authored-By: Ana <ana@example.invalid>\n", encoding="utf-8")
        os.chmod(message, 0o666)
        user = f"{os.getuid()}:{os.getgid()}" if hasattr(os, "getuid") else "10001:10001"
        base = ["docker", "run", "--rm", "--network", "none", "--user", user,
                "-v", f"{root}:/repo", IMAGE]
        run(*base, message.name)
        expected = "feat: example\n\nCo-Authored-By: Ana <ana@example.invalid>\n"
        assert message.read_text(encoding="utf-8") == expected
        run(*base, message.name)
        assert message.read_text(encoding="utf-8") == expected
        assert run(*base, "/etc/passwd", success=False).returncode != 0
        assert run(*base, "missing.txt", success=False).returncode != 0
        assert run(*base, "../etc/passwd", success=False).returncode != 0
        assert not (root / ".git").exists(), "one-shot filter installed unexpected Git state"
        env = dict(os.environ, NO_AI_COAUTHOR_REPO=directory, NO_AI_COAUTHOR_USER=user)
        compose = ["docker", "compose", "-p", "no-ai-smoke-" + secrets.token_hex(3),
                   "-f", str(ROOT / "compose.yaml")]
        try:
            run(*compose, "run", "--rm", "no-ai-coauthor", message.name, env=env)
            assert message.read_text(encoding="utf-8") == expected
        finally:
            run(*compose, "down", "--remove-orphans", env=env, success=False)
    print("PASS: original Git hook cases in image build, non-root filter, human trailer, idempotence, path refusal, Compose without network")


if __name__ == "__main__":
    main()
