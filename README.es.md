<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/readme/banner-es-dark.svg">
  <img src="assets/readme/banner-es-light.svg" alt="no-ai-coauthor — Este proyecto se mudó a RepoRinse" width="100%">
</picture>


> [!IMPORTANT]
> **Este proyecto se mudó.** no-ai-coauthor ya no recibe mantenimiento.
> Su sucesor es **[RepoRinse](https://github.com/robgallardof/RepoRinse)** — el mismo objetivo, más seguro y mucho más completo.

<a href="https://github.com/robgallardof/RepoRinse">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://socialify.git.ci/robgallardof/RepoRinse/image?theme=Dark&font=Inter&language=1&description=1&name=1&owner=1&pattern=Circuit%20Board" />
    <img src="https://socialify.git.ci/robgallardof/RepoRinse/image?theme=Light&font=Inter&language=1&description=1&name=1&owner=1&pattern=Circuit%20Board" alt="RepoRinse" width="80%" />
  </picture>
</a>

<br/><br/>

<a href="https://github.com/robgallardof/RepoRinse/blob/main/README.es.md"><img src="https://img.shields.io/badge/Ir%20a-RepoRinse-6D28D9?style=for-the-badge&logo=github&logoColor=white" alt="Ir a RepoRinse" /></a>
<a href="https://github.com/robgallardof/RepoRinse/blob/main/docs/migration/no-ai-couathor.md#español"><img src="https://img.shields.io/badge/Gu%C3%ADa-de%20migraci%C3%B3n-0EA5E9?style=for-the-badge&logo=readthedocs&logoColor=white" alt="Guía de migración" /></a>

![estado](https://img.shields.io/badge/estado-obsoleto-lightgrey)
![licencia](https://img.shields.io/badge/licencia-MIT-blue)

[English](README.md) · **Español**

</div>

<p align="center"><img src="assets/readme/divider.svg" alt="" width="80%" /></p>

<a id="-por-qué-cambiar"></a>
<p align="center"><img src="assets/readme/sections/es-01.svg" alt="01 · ¿Por qué cambiar?" width="100%" /></p>

| | no-ai-coauthor | RepoRinse |
|---|:---:|:---:|
| Quita trailers `Co-Authored-By` de IA y pies "Generated with" | ✅ | ✅ |
| Respeta coautores humanos — incluso personas llamadas *Claude* | ⚠️ regex | ✅ |
| Convive con Husky / pre-commit / lefthook (encadena hooks existentes) | ❌ | ✅ |
| Nunca reemplaza tu `core.hooksPath` global | ❌ | ✅ |
| Desinstalación byte por byte con manifest | ❌ | ✅ |
| Configurable (`.reporinse.toml`) y `--dry-run` en todo | ❌ | ✅ |
| Revisión de espacios, Unicode invisible y tamaño de cambios | ❌ | ✅ |
| Límites para Claude Code, Codex, Gemini CLI y Cursor | ❌ | ✅ |

<a id="-cámbiate-en-3-pasos"></a>
<p align="center"><img src="assets/readme/sections/es-02.svg" alt="02 · Cámbiate en 3 pasos" width="100%" /></p>

**1. Quita el hook anterior** (desde tu clon de este repositorio):

```sh
./install.sh --uninstall                 # instalación global
./install.sh --uninstall --repo RUTA     # instalación por repositorio
```
```powershell
.\install.ps1 -Uninstall
.\install.ps1 -Uninstall -Repo RUTA
```

**2. Instala RepoRinse** — sigue su [guía de instalación](https://github.com/robgallardof/RepoRinse/blob/main/README.es.md#-instalación).

**3. Instala el hook que lo reemplaza:**

```sh
reporinse install --provider git --only git.ai-attribution --yes                 # un repositorio
reporinse install --provider git --scope user --only git.ai-attribution --yes    # todos los repositorios
```

¿Aún no quieres quitar el hook anterior? Una instalación de RepoRinse por repositorio lo mantiene funcionando: se
encadena y corre primero. Todos los detalles, incluido qué es automático y qué es manual, están en la
**[guía de migración](https://github.com/robgallardof/RepoRinse/blob/main/docs/migration/no-ai-couathor.md#español)**.

<p align="center"><img src="assets/readme/divider.svg" alt="" width="80%" /></p>

<details>
<summary><b>📦 Documentación anterior (no-ai-coauthor)</b></summary>

### Qué hacía

Un pequeño hook `commit-msg` en POSIX `sh` que quitaba los trailers `Co-Authored-By:` que mencionaban a Claude,
Anthropic, OpenAI, ChatGPT, Codex, Gemini, Copilot o Cursor, y las líneas `Generated with Claude Code`.

### Instalar (no recomendado — usa RepoRinse)

```sh
git clone https://github.com/robgallardof/no-ai-couathor.git
cd no-ai-couathor
./install.sh                    # global (configura core.hooksPath en ~/.config/git/hooks)
./install.sh --repo RUTA        # un solo repositorio
```
```powershell
.\install.ps1
.\install.ps1 -Repo C:\ruta\a\tu\repo
```

### Desinstalar

```sh
./install.sh --uninstall
./install.sh --uninstall --repo RUTA
```

Solo quita el hook si es nuestro y restaura cualquier `commit-msg.bak`. Pruebas: `./test.sh`.

</details>

### Filtro de compatibilidad con Docker (opcional)

Solo para flujos existentes; RepoRinse sigue siendo el reemplazo recomendado.
El contenedor limpia un archivo de mensaje montado explícitamente y no instala hooks:

```sh
docker build -t no-ai-coauthor:local .
docker run --rm --network none --user "$(id -u):$(id -g)" -v "$PWD:/repo" no-ai-coauthor:local .git/COMMIT_EDITMSG
```

Usuario de ejecución, Compose y límites: [guía de Docker](docs/DOCKER.md) (en inglés).
Pruebas de imagen y Git aislado: `python scripts/test_docker.py`.

<a id="-licencia"></a>
<p align="center"><img src="assets/readme/sections/es-03.svg" alt="03 · Licencia" width="100%" /></p>

[MIT](LICENSE)

<br/>

<img src="assets/readme/footer-es.svg" alt="no-ai-coauthor" width="100%" />

## OpenCode / DeepSeek

El hook de Git se ejecuta también cuando OpenCode o DeepSeek invocan `git commit`.
Reconoce sus trailers y pies de atribución; `test.sh` lo comprueba mediante commits reales.
Este proyecto sigue obsoleto: para bloqueos antes de herramientas, usa los
[puentes nativos de RepoRinse](https://github.com/robgallardof/RepoRinse/blob/main/docs/integrations/opencode-deepseek.md).
No se instala configuración del agente ni se requiere una clave de modelo.
