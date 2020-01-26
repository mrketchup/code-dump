'''
Created on Oct 28, 2012

@author: mejones
'''

class Question(object):
    def __init__(self):
        self.number = 0
        self.question = ''
        self.answers = {}
        self.correct_answer = ''
        
    def __str__(self):
        s = self.question + '\n'
        for k in sorted(self.answers):
            s += k + '. ' + self.answers[k] + '\n'
        return s