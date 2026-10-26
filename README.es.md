<div align="center">

# ✂️ no-ai-coauthor

**Tus commits, tu nombre.**<br>
Un hook de Git diminuto que quita la atribución a la IA de cada mensaje de commit —<br>
Claude Code, Copilot, Codex, Cursor, Gemini o cualquier otro agente.

![git hook](https://img.shields.io/badge/git-hook%20commit--msg-F05032?logo=git&logoColor=white)
![shell](https://img.shields.io/badge/POSIX-sh-4EAA25?logo=gnubash&logoColor=white)
![plataformas](https://img.shields.io/badge/macOS%20%7C%20Linux%20%7C%20Windows-compatible-0078D4)
![dependencias](https://img.shields.io/badge/dependencias-cero-2ea44f)
![licencia](https://img.shields.io/badge/licencia-MIT-blue)

[English](README.md) · **Español**

</div>

---

## ✨ Qué hace

Los agentes de IA para programar suelen firmar tus commits. Este hook se ejecuta justo antes de que Git guarde el
mensaje y quita esas líneas en silencio, para que el historial solo muestre a las personas dueñas del trabajo.

<table>
<tr><th>Antes</th><th>Después</th></tr>
<tr><td>

```text
feat: login con enlace mágico

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

</td><td>

```text
feat: login con enlace mágico
```

</td></tr>
</table>

| | |
|---|---|
| 🧹 **Quita** | Los trailers `Co-Authored-By:` que mencionan a **Claude, Anthropic, OpenAI, ChatGPT, Codex, Gemini, Copilot o Cursor**, y las líneas `Generated with Claude Code` (con o sin el 🤖). |
| 🤝 **Respeta** | Los coautores humanos, el resto de tu mensaje y cualquier commit que solo *menciona* esos nombres en el texto. |
| 🧽 **Limpia** | Las líneas en blanco que quedan al final. |
| 🌍 **Sirve con cualquier agente** | Es un hook de Git normal: no importa qué herramienta hizo el commit. |
| 🪶 **Cero dependencias** | ~10 líneas de `sh` POSIX + `grep` + `awk`, que vienen con Git en todos lados (incluido Git for Windows). |

## 🚀 Instalación

```sh
git clone https://github.com/robgallardof/no-ai-couathor.git
cd no-ai-couathor
```

### Opción A — en todos los repositorios de tu equipo (recomendada)

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

> Si los scripts están bloqueados: `powershell -ExecutionPolicy Bypass -File .\install.ps1`

</details>

Copia el hook a `~/.config/git/hooks/` y apunta ahí el `core.hooksPath` global de Git.

> [!NOTE]
> Un `core.hooksPath` global hace que Git ignore los hooks de `.git/hooks/` de cada repositorio. Si un proyecto usa
> sus propios hooks (husky, pre-commit, lefthook…), usa la **Opción B** en ese proyecto. Los repositorios que definen
> su propio `core.hooksPath` siguen usándolo.

### Opción B — un solo repositorio

```sh
./install.sh --repo /ruta/a/tu/repo
```
```powershell
.\install.ps1 -Repo C:\ruta\a\tu\repo
```

Si el repositorio ya tenía un hook `commit-msg`, se guarda como `commit-msg.bak`.

### Opción C — incluirlo dentro de un proyecto

Copia `hooks/commit-msg` al proyecto como `.githooks/commit-msg`, súbelo y pide a cada clon que lo active una vez:

```sh
git config core.hooksPath .githooks
```

## ✅ Comprueba que funciona

```sh
git commit --allow-empty -m "prueba" -m "Co-Authored-By: Claude <noreply@anthropic.com>"
git log -1 --format=%B      # → solo "prueba"
git reset --soft HEAD~1     # deshace el commit de prueba
```

O corre las pruebas incluidas: `./test.sh`

## 🗑️ Desinstalar

```sh
./install.sh --uninstall                # global
./install.sh --uninstall --repo RUTA    # un repositorio
```
```powershell
.\install.ps1 -Uninstall
.\install.ps1 -Uninstall -Repo RUTA
```

Solo borra el hook si es el nuestro, y restaura el `commit-msg.bak` si existe.

## 💡 Tip: apágalo también desde el origen

Claude Code puede omitir la atribución por sí mismo. En `~/.claude/settings.json`:

```json
{
  "attribution": { "commit": "", "pr": "" }
}
```

(versiones anteriores: `"includeCoAuthoredBy": false`). El hook sigue valiendo la pena: cubre a todos los agentes y
cualquier configuración que se te olvide; las descripciones de pull requests no pasan por Git de todos modos.

## ❓ Preguntas frecuentes

<details>
<summary><b>¿Modifica los commits que ya están en el historial?</b></summary>

No. Solo limpia los commits nuevos (incluidos `--amend`, merges y rebases que generan mensaje). Para reescribir
historial viejo usa `git rebase -i` o `git filter-repo`.
</details>

<details>
<summary><b>¿Se puede saltar?</b></summary>

Sí, como cualquier hook local: `git commit --no-verify` no lo ejecuta. Los agentes normalmente no usan esa opción.
</details>

<details>
<summary><b>¿Cómo agrego otra herramienta a la lista?</b></summary>

Edita el patrón en `hooks/commit-msg` — los nombres están en `(claude|anthropic|openai|…)` — y vuelve a instalar.
</details>

## 📄 Licencia

[MIT](LICENSE)
