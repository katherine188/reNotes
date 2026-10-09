from pathlib import Path
import re

archivo = Path("lib/data/datos_prueba.dart")
contenido = archivo.read_text(encoding="utf-8")

bloques = re.split(r"(?=Nota\()", contenido)
notas = []

for bloque in bloques:
    if not bloque.startswith("Nota("):
        continue

    titulo = re.search(r"titulo:\s*'([^']*)'", bloque)
    descripcion = re.search(r"descripcion:\s*'((?:[^'\\]|\\.)*)'", bloque, re.S)

    if titulo and descripcion:
        notas.append((titulo.group(1), len(descripcion.group(1))))

print(f"Total de notas encontradas: {len(notas)}")
for titulo, cantidad in notas:
    print(f"{titulo}: {cantidad} caracteres")

print(f"\nNotas con más de 600 caracteres: {sum(cantidad > 600 for _, cantidad in notas)}")
