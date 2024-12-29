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
