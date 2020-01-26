from pyPdf import PdfFileReader
import re
from Question import Question

if __name__ == '__main__':
    pdffile = PdfFileReader(file("SY0-301.pdf", "r"))
    all_text = ''
    for page in pdffile.pages:
        text = page.extractText().strip()
        text = text.replace('Explanation:', '')
        text = text.replace('CompTIA SY0-301 Exam"Pass Any Exam. Any Time." - ' +
                            'www.actualtests.com', '')
        text = text.replace('CompTIA SY0-301', '')
        text = text.replace('CompTIA Security+Version: 15.0', '')
        text = text.replace('  ', ' ')
        all_text += ' ' + text
    
    qp = re.compile(r'QUESTION\sNO:\s\d+.*?Answer:\s\w,?\w?')
    pp = re.compile(r'QUESTION\sNO:\s(\d+)(.*?)(A[.].*?)Answer:\s(\w,?\w?)')
    q_list = re.findall(qp, all_text)
    
    questions = []
    for q in q_list:
        parts = re.match(pp, q)
        question = Question()
        question.number = int(parts.group(1))
        question.question = parts.group(2).strip()
        question.correct_answer = parts.group(4).strip()
        
        letters = ['A', 'B', 'C', 'D', 'E', 'F']
        ans = parts.group(3).split(letters[0] + '.')
        for i in range(1, len(letters)):
            try:
                ans += ans[i].split(letters[i] + '.')
                ans.pop(i) 
            except:
                pass
        ans.pop(0)
        for i in range(len(ans)):
            question.answers[letters[i]] = ans[i].strip()
            
        questions.append(question)
        
    f = open('questions', 'w')
    f.write('<exam_questions>\n')
    for q in questions:
        f.write('\t<question number="' + str(q.number) + '">\n')
        f.write('\t\t<question_text>' + q.question + '</question_text>\n')
        f.write('\t\t<answers correct="' + q.correct_answer + '">\n')
        for k in sorted(q.answers):
            f.write('\t\t\t<answer letter="' + k + '">' + q.answers[k] + '</answer>\n')
        f.write('\t\t</answers>\n')
        f.write('\t</question>\n')
    f.write('</exam_questions>\n')
    f.close()
