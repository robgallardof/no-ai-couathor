<a id="top"></a>

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

OpenCode y DeepSeek también pueden usar el hook de Git. Para guardas antes de ejecutar herramientas, utiliza [RepoRinse](https://github.com/robgallardof/RepoRinse).

<a id="-por-qué-cambiar"></a>
## <img src="assets/readme-builder/icons/layers.svg" width="24" height="24" alt="" /> ¿Por qué cambiar?

| | no-ai-coauthor | RepoRinse |
|---|:---:|:---:|
| Quita trailers `Co-Authored-By` de IA y pies "Generated with" | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Respeta coautores humanos — incluso personas llamadas *Claude* | <img src="assets/readme-builder/icons/spark.svg" width="20" height="20" alt="" /> regex | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Convive con Husky / pre-commit / lefthook (encadena hooks existentes) | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Nunca reemplaza tu `core.hooksPath` global | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Desinstalación byte por byte con manifest | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Configurable (`.reporinse.toml`) y `--dry-run` en todo | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Revisión de espacios, Unicode invisible y tamaño de cambios | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |
| Límites para Claude Code, Codex, Gemini CLI y Cursor | <img src="assets/readme-builder/icons/close.svg" width="20" height="20" alt="" /> | <img src="assets/readme-builder/icons/check.svg" width="20" height="20" alt="" /> |

<a id="-cámbiate-en-3-pasos"></a>
## <img src="assets/readme-builder/icons/layers.svg" width="24" height="24" alt="" /> Cámbiate en 3 pasos

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

<details>
<summary><b><img src="assets/readme-builder/icons/box.svg" width="20" height="20" alt="" /> Documentación anterior (no-ai-coauthor)</b></summary>

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
## <img src="assets/readme-builder/icons/code.svg" width="24" height="24" alt="" /> Licencia

[MIT](LICENSE)

<br/>

<p align="center"><a href="#top">Volver al inicio</a></p>

<!-- readme-builder:signature:start -->
<p align="center"><a href="https://github.com/robgallardof"><picture><source media="(prefers-color-scheme: dark)" srcset="assets/readme/brand/signature-es-dark.svg" /><img src="assets/readme/brand/signature-es-light.svg" alt="no-ai-coauthor / Roberto Gallardo" width="100%" /></picture></a></p>
<!-- readme-builder:signature:end -->
