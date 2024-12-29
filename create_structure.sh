#!/bin/bash

# Crear la estructura de directorios
mkdir -p curso_rust
cd curso_rust

# Crear directorios para cada capítulo
for i in {1..20}; do
    mkdir -p "capitulo_$i/src"
    
    # Crear Cargo.toml para cada capítulo
    cat > "capitulo_$i/Cargo.toml" << EOF
[package]
name = "capitulo_${i}"
version = "0.1.0"
edition = "2021"

[dependencies]
EOF
    
    # Crear README.md básico para cada capítulo
    cat > "capitulo_$i/README.md" << EOF
# Capítulo ${i}

## Contenido
- [Descripción del contenido]

## Ejemplos incluidos
1. [Ejemplo 1]
2. [Ejemplo 2]

## Cómo ejecutar
\`\`\`bash
cd capitulo_${i}
cargo run
\`\`\`
EOF
    
    # Crear main.rs básico para cada capítulo
    cat > "capitulo_$i/src/main.rs" << EOF
fn main() {
    println!("Ejemplos del Capítulo ${i}");
}
EOF
done

# Crear archivo principal Cargo.toml
cat > Cargo.toml << EOF
[package]
name = "curso_rust"
version = "0.1.0"
edition = "2021"
authors = ["Curso Rust"]

[workspace]
members = [
$(for i in {1..20}; do echo "    \"capitulo_$i\","; done)
]

[[bin]]
name = "curso_rust"
path = "main.rs"
EOF

# Crear main.rs principal
cat > main.rs << EOF
use std::io::{self, Write};
use std::process::Command;

fn main() {
    println!("¡Bienvenido al Curso Práctico de Rust! 🦀\n");
    
    loop {
        println!("\nSeleccione un capítulo (1-20) o 'q' para salir:");
        io::stdout().flush().unwrap();
        
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        
        let input = input.trim();
        
        if input.eq_ignore_ascii_case("q") {
            break;
        }
        
        match input.parse::<u32>() {
            Ok(num) if num >= 1 && num <= 20 => {
                ejecutar_capitulo(num);
            }
            _ => println!("Por favor ingrese un número válido entre 1 y 20"),
        }
    }
}

fn ejecutar_capitulo(num: u32) {
    println!("Ejecutando ejemplos del Capítulo {}...", num);
    let capitulo = format!("capitulo_{}", num);
    
    let status = Command::new("cargo")
        .args(["run", "-p", &capitulo])
        .status()
        .expect("Failed to execute command");
        
    if !status.success() {
        println!("Error al ejecutar el capítulo {}", num);
    }
}
EOF

# Crear README.md principal
cat > README.md << EOF
# Curso Práctico de Rust 🦀

Este curso está basado en el [Libro de Rust en Español](https://book.rustlang-es.org/) pero con ejemplos prácticos adicionales y ejercicios complementarios.

## Estructura del Curso

El curso está organizado en capítulos, cada uno con sus propios ejemplos y ejercicios.

## Cómo usar este curso

### Requisitos previos
- Rust instalado (rustc y cargo)
- Git (opcional)

### Ejecutar los ejemplos

Hay dos formas de ejecutar los ejemplos:

1. **Individualmente**: Navega a cada capítulo y ejecuta:
\`\`\`bash
cd capitulo_X
cargo run
\`\`\`

2. **Desde el programa principal**:
\`\`\`bash
cargo run
\`\`\`
Luego sigue las instrucciones en pantalla para seleccionar el ejemplo.

## Contenido de los Capítulos

$(for i in {1..20}; do echo "### Capítulo $i
- [Ver detalles](capitulo_$i/README.md)
"; done)

## Licencia

Este proyecto está bajo la licencia MIT.
EOF

# Hacer el script ejecutable
chmod +x create_structure.sh

echo "¡Estructura del curso creada exitosamente!"