import json
import re
from pathlib import Path
from pdfminer.high_level import extract_text

PDF_PATH = Path("instance/Roman-Gonzalez-Computational Thinking Test (CTt).pdf")
OUTPUT_JSON = Path("ctt_questions.json")

# Patrones alternativos para capturar preguntas con distintas variantes de formato
PATTERNS = [
    # 1) Variante con "A) ... B) ... C) ... D) ... Respuesta correcta: X"
    re.compile(r"(\d+)\s*[.\)]\s*(.*?)\s*A\)\s*(.*?)\s*B\)\s*(.*?)\s*C\)\s*(.*?)\s*D\)\s*(.*?)\s*Respuesta\s*(?:correcta|:)\s*[:]?\s*([A-D])",
               re.DOTALL | re.IGNORECASE),
    # 2) Variante con minúsculas "a) b) c) d)" y posible línea intermedia
    re.compile(r"(\d+)\s*[.\)]\s*(.*?)\s*a\)\s*(.*?)\s*b\)\s*(.*?)\s*c\)\s*(.*?)\s*d\)\s*(.*?)\s*(?:Respuesta\s*(?:correcta)?\s*[:]?\s*([A-Da-d]))?",
               re.DOTALL | re.IGNORECASE),
    # 3) Variante con opciones separadas por saltos de línea y sin texto de respuesta
    re.compile(r"(\d+)\s*[.\)]\s*(.*?)\s*A[\).]\s*(.*?)\n+\s*B[\).]\s*(.*?)\n+\s*C[\).]\s*(.*?)\n+\s*D[\).]\s*(.*?)\n+\s*(?:Respuesta\s*(?:correcta)?\s*[:]?\s*([A-Da-d]))?",
               re.DOTALL | re.IGNORECASE),
]

def extract_questions(pdf_path: Path):
    text = extract_text(str(pdf_path))
    questions = []
    matched_spans = []

    for pattern in PATTERNS:
        for m in pattern.finditer(text):
            if any(ms[0] <= m.start() <= ms[1] or ms[0] <= m.end() <= ms[1] for ms in matched_spans):
                continue  # evitar duplicados si varios patrones coinciden en el mismo bloque
            groups = list(m.groups())
            # Normalizar
            num = groups[0]
            statement, option_a, option_b, option_c, option_d = [g.strip() if g else "" for g in groups[1:6]]
            correct = (groups[6] or "").strip().upper()
            if correct and correct not in {"A", "B", "C", "D"}:
                correct = ""  # si quedó algo raro, lo dejamos vacío

            questions.append({
                "statement": statement,
                "option_a": option_a,
                "option_b": option_b,
                "option_c": option_c,
                "option_d": option_d,
                "correct_answer": correct,
                "label": "CTt",
                "percentage": 1,
                "image_url": ""
            })
            matched_spans.append((m.start(), m.end()))

    return questions

def main():
    if not PDF_PATH.exists():
        raise FileNotFoundError(f"No se encontró el PDF en {PDF_PATH.resolve()}")

    questions = extract_questions(PDF_PATH)
    with open(OUTPUT_JSON, "w", encoding="utf-8") as f:
        json.dump(questions, f, ensure_ascii=False, indent=2)

    print(f"Extraídas {len(questions)} preguntas y guardadas en {OUTPUT_JSON}")
    if len(questions) == 0:
        print("Aviso: no se detectaron preguntas. Revisa el formato del PDF o comparte una muestra del texto extraído para ajustar el parser.")

if __name__ == "__main__":
    main()
