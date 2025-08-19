# Blueprint de la UI Dinámica: Guía de Patrones y Componentes

**Misión:** Construir componentes HTML a prueba de fallos para el motor de localización y dinamismo de la interfaz de usuario. Este documento define los patrones y reglas esenciales que todo desarrollador debe seguir.

---

### 🔧 La Caja de Herramientas: Anatomía de la Clave de BD

Toda acción se inicia con una "instrucción" desde la base de datos. Esta es su estructura:

```
  MODULO.CONTENEDOR.ACCION[CODIGO_LANG]| PARÁMETROS
     |         |          |          |             |
     |         |          |          |             └─> 1|0|1|| (Editable|Requerido|Oculto|...)
     |         |          |          |                  - Editable: 1=Sí, 0=No (deshabilitado)
     |         |          |          |                  - Requerido: 1=Sí, 0=No
     |         |          |          |                  - Oculto: 1=Sí, 0=No (visible)
     |         |          |          |
     |         |          |          └─> Coincide con data-lang (MAYÚSCULAS)
     |         |          |
     |         |          └─> HTML, LABEL, HREF, COLOR, etc. (Ver catálogo)
     |         |
     |         └─> Coincide con el id/data-container principal
     |
     └─> Módulo de la aplicación
```
---

### Parte 1: Patrones para Componentes Generales (Acción `HTML`)
_Estos patrones se usan para cualquier elemento que no sea un campo de formulario (textos, títulos, botones, enlaces, etc.)._

#### **Patrón 1.1: Elemento Simple y Autónomo**
```html
<a id="id_unico" data-lang="CODIGO_LANG">Inscríbete</a>
```

#### **Patrón 1.2: Elemento Agrupado (Etiqueta + Valor)**
```html
<div id="material_id_hijo">
  <span id="id_hijo" data-lang="CODIGO_LANG">Solicitado</span>: ${una_fecha}
</div>
```
---
### Parte 2: Patrones para Campos de Formulario (Acción `LABEL`)
> [!IMPORTANT]
> **Exclusivo para `<input>`, `<select>`, etc.** Usar la acción `LABEL` es obligatorio para activar la gestión de estado (`required`, `editable`). La coincidencia de IDs entre el contenedor y el campo es obligatoria.

```html
<div id="material_tip_certificado" class="md-form">
  <select id="tip_certificado" data-lang="SELECT_TITLE_CERTIFICADO" required></select>
  <label for="tip_certificado">Título del Certificado</label>
</div>
```
---
### Parte 3: Catálogo de Acciones Adicionales
_Estas acciones se aplican a los elementos definidos en los patrones anteriores._

#### **Atributos de Elemento**
| Acción | Descripción |
| :--- | :--- |
| **`HREF`** | Modifica el destino de un enlace `<a>`. |
| **`SRC`** | Cambia la fuente de una imagen `<img>`. |
| **`PLACEHOLDER`**| Asigna el texto de ejemplo en un `<input>`.|
| **`SEARCHABLE`** | Asigna el texto "Buscar..." en un `<select>` con buscador. |

#### **Ayuda y Popovers**
| Acción | Descripción |
| :--- | :--- |
| **`HLPTIT`** | Asigna el **título** a un popover de ayuda. |
| **`HLPCON`** | Asigna el **contenido** a un popover de ayuda. |
| **`HLPDET`** | Añade un texto de ayuda **detallado** debajo del campo. |

---
### Parte 4: Aplicando Estilos Dinámicos (Acciones de Color, Fondo, etc.)

Existen dos tipos de acciones de estilo: directas y por asociación.

#### **4.1 Estilos Directos**
Estas acciones se aplican **directamente sobre la etiqueta que lleva el atributo `data-lang`**.

* **Acciones:** `COLOR`, `BGCOLOR`, `BORDERCOLOR`, `BORDERTCOLOR`, `BORDERLCOLOR`, `BORDERRCOLOR`, `BGIMAGE`, `BGGRADIENT`.
* **Ejemplo:**
  * **HTML:** `<h2 id="titulo" data-lang="TITULO_PRINCIPAL">Mi Título</h2>`
  * **Clave BD:** `...COLOR[TITULO_PRINCIPAL]|...`
  * **Resultado:** El texto del `<h2>` cambiará de color.

#### **4.2 Estilos por Asociación**
Estas acciones usan la etiqueta con `data-lang` como referencia para **buscar y estilizar un elemento relacionado**.

* **Acción: `LABELCOLOR`**
  * **Propósito:** Cambia el color de la etiqueta `<label>` asociada a un campo.
  * **Mecanismo:** Busca la `<label>` cuyo atributo `for` coincida con el `id` del campo que tiene el `data-lang`.
  * **Plano HTML:** Requiere el Patrón de Formulario (Parte 2).

* **Acción: `ICONCOLOR`**
  * **Propósito:** Cambia el color de un ícono `<i>` asociado a un elemento.
  * **Mecanismo:** El script busca el ícono en este orden: 1. Dentro del elemento, 2. Al lado del elemento, o 3. Dentro de su contenedor `material_...`.
  * **Plano HTML (Ejemplo):**
    ```html
    <div id="material_mi_campo" class="md-form">
      <i class="far fa-user prefix"></i>
      <input id="mi_campo" data-lang="MI_CAMPO_LANG" type="text">
      <label for="mi_campo">Usuario</label>
    </div>
    ```
  * **Clave BD:** `...ICONCOLOR[MI_CAMPO_LANG]|...`
  * **Resultado:** El ícono `<i class="far fa-user">` cambiará de color.

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
