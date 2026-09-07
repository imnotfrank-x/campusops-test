# CampusOps — starter público de Desarrollo Móvil Integral

## Entrega de semana 1 — equipo 4

La entrega de esta semana contiene la definición del caso, tres riesgos priorizados, el diagnóstico de una falla reversible y las aportaciones de Oscar, Jarumi y Fernanda. La aplicación conserva el alcance de línea base; los flujos de negocio se desarrollan en semanas posteriores.

| Evidencia obligatoria | Archivo |
|---|---|
| Problema, alcance, actores, flujo y nueve criterios verificables | [Definición del problema](docs/problem-definition.md) |
| Exactamente tres riesgos con probabilidad, impacto, mitigación y comprobación | [Registro de riesgos](docs/risk-register.md) |
| Observaciones reales de falla y corrección | [baseline.json](reports/week-01/baseline.json) |
| Decisión, alternativas, beneficio/costo y verificación | [engineering.json](evidence/week-01/engineering.json) |
| Tres integrantes, commits propios, archivos, predicciones y resultados | [individual.json](evidence/week-01/individual.json) |

El [índice de la entrega](docs/GUIA_EQUIPO_SEMANA_01.md) relaciona las aportaciones con la [rúbrica](RUBRICA.md). El [registro de cierre](docs/cierre-integracion.md) enlaza comandos y resultados. Las instrucciones completas y el orden obligatorio están en [LEEME_PRIMERO.md](LEEME_PRIMERO.md).

Para identificar la versión congelada se utiliza `git rev-list -n 1 week-01-final`. Los SHA de `baseline.json` y `engineering.json` identifican el trabajo técnico; el último commit de evidencias sólo puede modificar `reports/` y `evidence/`. El reporte `failure.json` se genera después de etiquetar, según el paso 15, y no requiere un commit posterior.

## Base técnica del proyecto

Base técnica: Expo SDK 57, React Native 0.86, React 19, TypeScript estricto y Node.js 22. Este repositorio es el punto de partida del equipo; no contiene pruebas ocultas, respuestas, secretos ni lógica privada de calificación.

Lee `docs/CAMPUSOPS.md` (caso y alcance) y `docs/CAMPUSOPS_API.md` (contratos y variantes públicas). La pantalla inicial sólo comprueba la línea base; no implementa los flujos que el equipo debe construir. Los adaptadores en `src/course-evaluation/` permanecen intencionalmente pendientes para sus semanas: la suite completa no tiene que pasar al recibir el starter; sí debe pasar `make feedback`.

El nombre es provisional. Se conservan slug e identificadores nativos existentes para no romper builds o instalación. Los fixtures del backend son públicos, ficticios y sólo para desarrollo; no equivalen a una autenticación de producción.

## Requisitos

- Node.js 22.22.0 (la versión esperada está en `.nvmrc`).
- npm, GNU Make y Git.
- Python 3 para ejecutar el evaluador semanal original.
- Para Android nativo: JDK 17 y Android SDK con Platform 35, Build Tools 35 y NDK 27.1.12297006.
- Equipo de exactamente tres integrantes y repositorio público de GitHub, conforme a las instrucciones docentes.

## Inicio reproducible

```bash
nvm use
make setup
make feedback
```

`make setup` comprueba si la copia Git es superficial. Sólo en ese caso ejecuta `git fetch --unshallow origin` antes de `npm ci`, para que el evaluador pueda consultar el padre del commit de evidencias. La descarga conserva el SHA de `HEAD` y requiere acceso al remoto `origin`; si falla la consulta de Git o la descarga, la preparación se detiene. En una copia con historial completo no descarga historial. El workflow semanal original ya llama a `make setup` antes de evaluar.

La descarga no usa `--tags`: al evaluar una etiqueta anotada, Actions puede crear una referencia local ligera al mismo SHA. Pedir la actualización explícita de etiquetas provoca `would clobber existing tag`; completar sólo el historial conserva esa referencia y permite comprobar la evidencia congelada.

La receta requiere un shell POSIX, disponible en Ubuntu y Git Bash. En PowerShell con GNU Make y Git for Windows, si `sh` no está en el PATH, se puede indicar su ubicación con `make 'SHELL=C:/Program Files/Git/bin/sh.exe' setup` (ajusta la ruta a tu instalación).

Al registrar cambios técnicos como este ajuste, hay que repetir el cierre de los pasos 9 a 17 de `LEEME_PRIMERO.md`: actualizar las evidencias con el nuevo SHA técnico y crear después el commit exclusivo de evidencias. Completar el historial permite comprobar la relación entre commits, pero no corrige un `commitSha` desactualizado.

Para desarrollo local:

```bash
make run-backend
make run
```

`make feedback` ejecuta la misma base pública del workflow: typecheck, lint, smoke test, auditoría crítica y bundle Android de Expo. Un resultado verde ofrece retroalimentación, pero la calificación final la determina una reproducción docente desde el SHA entregado y checks adicionales controlados por la materia.

## Actividades semanales

Cada paquete semanal agrega el enunciado dirigido al alumno, su test público y un workflow de feedback. Copia únicamente los archivos indicados por el paquete y ejecuta:

```bash
make verify-week-01
make public-test-week-01
```

Sustituye `01` por la semana efectiva correspondiente. Para semana 1, después de aprobar esas comprobaciones, crear el commit exclusivo de evidencias y crear la etiqueta anotada, ejecutar `make evidence-week-01`. El orden completo está en los pasos 9 a 17 de `LEEME_PRIMERO.md`; el comando de evidencia congelada necesita que la etiqueta ya exista. No edites tests o workflows para ocultar fallos. Consulta `docs/EVIDENCE_CONTRACT.md` y `docs/SUBMISSION.md` antes de entregar.

## Identidad, entrega y seguridad

- Configura en Git el nombre y correo aprobados en el roster; no compartas una sola identidad entre integrantes.
- La entrega semanal es el tag `week-XX-final`, su SHA completo y la URL del repositorio.
- No subas `.env`, tokens, credenciales, datos personales reales ni archivos de firma.
- El backend incluido es sintético y no contiene credenciales.
- Todo valor `EXPO_PUBLIC_*` queda expuesto al cliente y jamás debe contener secretos.
