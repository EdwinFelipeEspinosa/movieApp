# Blueprint de la UI Dinámica: Guía de Patrones y Componentes

**Misión:** Construir componentes HTML a prueba de fallos para el motor de localización y dinamismo de la interfaz de usuario. Este documento define los patrones y reglas esenciales que todo desarrollador debe seguir.

---

### 🔧 La Caja de Herramientas: Anatomía de la Clave de BD

Toda acción se inicia con una "instrucción" desde la base de datos. Esta es su estructura:

```
  MODULO.CONTENEDOR.ACCION[CODIGO_LANG]| PARÁMETROS
     |         |          |          |             |
     |         |          |          |             └─> 1|0|1|| (Editable|Requerido|oculto|...)
     |         |          |          |
     |         |          |          └─> Coincide con data-lang (MAYÚSCULAS)
     |         |          |
     |         |          └─> HTML (General) o LABEL (Formularios)
     |         |
     |         └─> Coincide con el id/data-container principal
     |
     └─> Módulo de la aplicación
```
---

### Parte 1: Patrones para Componentes Generales (Acción `HTML`)

> [!NOTE]
> Estos patrones se usan para cualquier elemento que **no** sea un campo de formulario (textos, títulos, botones, enlaces, etc.).

#### **Patrón 1.1: Elemento Simple y Autónomo**
* **Uso:** Un botón, un título, un badge, o cualquier elemento que se gestiona como una sola unidad.

**Plano HTML**
```html
<a id="id_unico" data-lang="CODIGO_LANG">
  Inscríbete
</a>
```

**Instrucción BD (Clave)**
```
...HTML[CODIGO_LANG]|1|0|1...
```

#### **Patrón 1.2: Elemento Agrupado (Etiqueta + Valor)**
* **Uso:** Para mostrar un dato donde solo la etiqueta se traduce, pero se necesita ocultar el bloque completo.

**Plano HTML**
```html
<div id="material_id_hijo">
  <span id="id_hijo" data-lang="CODIGO_LANG">
    Solicitado
  </span>: ${una_fecha}
</div>
```

**Instrucción BD (Clave)**
```
...HTML[CODIGO_LANG]|1|0|1...
```

---
### Parte 2: Patrones para Campos de Formulario (Acción `LABEL`)

> [!IMPORTANT]
> Estos patrones son **exclusivos para elementos de formulario** (`input`, `select`, etc.). Usar la acción `LABEL` en la BD es **obligatorio** para activar la gestión de estado (`required`, `editable`).

> **Regla Crítica:** La coincidencia de IDs entre el contenedor (`material_...`) y el campo es obligatoria.

#### **Patrón 2.1: Campo de Formulario (Ej: Select)**
* **Uso:** Para cualquier campo de entrada (`input`, `select`, etc.) que necesite una etiqueta, validación y control de visibilidad.

**Plano HTML**
```html
<div id="material_tip_certificado" class="md-form">
  <select id="tip_certificado" data-lang="SELECT_TITLE_CERTIFICADO" required>
  </select>
  <label for="tip_certificado">
    Título del Certificado
  </label>
</div>
```

**Instrucción BD (Clave)**
```
...LABEL[SELECT_TITLE_CERTIFICADO]|1|1|1...
(Editable|Requerido|Visible)
```

---
### Apéndice: Reglas Fundamentales y Diagnóstico

> [!WARNING]
> #### **Checklist de Errores Comunes: "Mi elemento no se oculta, ¿por qué?"**
> * **`[ ]` ¿El contenedor principal (`<div id="..." data-container="...">`) tiene ambos atributos?**
> * **`[ ]` ¿El elemento que lleva `data-lang` tiene su propio `id` único?**
> * **`[ ]` Si es un elemento agrupado o de formulario, ¿el `id` del padre es exactamente `material_` + el `id` del hijo?**
> * **`[ ]` ¿Estás usando la acción `LABEL` para un campo de formulario?**

> [!TIP]
> #### **Reglas de Oro (Resumen)**
> 1.  **Contenedor Principal de la Vista:** El `div` que engloba toda la sección (ej. `<div id="CERF21_VIEW1">`) siempre debe tener `id` y `data-container` idénticos.
> 2.  **Elemento Objetivo:** El tag con `data-lang` siempre debe tener un `id` único (especialmente en bucles).
> 3.  **Mayúsculas/Minúsculas:**
>     * `data-lang="MI_CODIGO"` debe coincidir con el `[MI_CODIGO]` de la BD (Convención: Mayúsculas).
>     * `id="mi_id"` debe ser consistente. El wrapper (`material_mi_id`) se construye a partir de él (Convención: Minúsculas).
