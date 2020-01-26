'''
Created on Oct 28, 2012

@author: mejones
'''
import xml.parsers.expat
from Question import Question

class Parser(object):
    def __init__(self):
        self.questions = []
    
    def start_element(self, name, attrs):
        self.curText = ''
        if name == 'question':
            self.curQuestion = Question()
            self.curQuestion.number = int(attrs['number'])
        elif name == 'answers':
            self.curQuestion.correct_answer = attrs['correct']
        elif name == 'answer':
            self.curLetter = attrs['letter']
    
    def end_element(self, name):
        if name == 'question':
            self.questions.append(self.curQuestion)
        elif name == 'question_text':
            self.curQuestion.question = self.curText
        elif name == 'answer':
            self.curQuestion.answers[self.curLetter] = self.curText
    
    def char_data(self, data):
        self.curText += data

    def parse(self):
        p = xml.parsers.expat.ParserCreate()
        p.StartElementHandler = self.start_element
        p.EndElementHandler = self.end_element
        p.CharacterDataHandler = self.char_data
        f = open('questions.xml')
        p.ParseFile(f)
        f.close()
        return self.questions