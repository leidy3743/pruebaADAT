import json
import re
from pathlib import Path
from pdfminer.high_level import extract_text

PDF_PATH = Path("instance/Roman-Gonzalez-Computational Thinking Test (CTt).pdf")
OUTPUT_JSON = Path("ctt_questions.json")

# Expresión regular para preguntas tipo opción múltiple (ajustar según formato real)
QUESTION_REGEX = re.compile(r"(\d+)[.\)]\s*(.*?)\s*A\)\s*(.*?)\s*B\)\s*(.*?)\s*C\)\s*(.*?)\s*D\)\s*(.*?)\s*Respuesta correcta:\s*([A-D])", re.DOTALL)

def extract_questions(pdf_path):
    text = extract_text(str(pdf_path))
    questions = []
    for match in QUESTION_REGEX.finditer(text):
        num, statement, option_a, option_b, option_c, option_d, correct = match.groups()
        questions.append({
            "statement": statement.strip(),
            "option_a": option_a.strip(),
            "option_b": option_b.strip(),
            "option_c": option_c.strip(),
            "option_d": option_d.strip(),
            "correct_answer": correct.strip(),
            "label": "ctt",
            "percentage": 1,
            "image_url": ""
        })
    return questions

def main():
    questions = extract_questions(PDF_PATH)
    with open(OUTPUT_JSON, "w", encoding="utf-8") as f:
        json.dump(questions, f, ensure_ascii=False, indent=2)
    print(f"Extraídas {len(questions)} preguntas y guardadas en {OUTPUT_JSON}")

if __name__ == "__main__":
    main()
