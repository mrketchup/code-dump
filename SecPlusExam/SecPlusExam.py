'''
Created on Oct 28, 2012

@author: mejones
'''

def shuffle(questions):
    import random
    l = len(questions)
    for i in range(l):
        j = random.randint(0, l - 1)
        q = questions[i]
        questions[i] = questions[j]
        questions[j] = q

if __name__ == '__main__':
    from XmlParser import Parser
    p = Parser()
    all_questions = p.parse()
    shuffle(all_questions)
    
    number = int(raw_input('How many questions do you want? '))
    
    test_questions = all_questions[:number]
    correct = 0
    for i in range(len(test_questions)):
        print '=' * 80
        print 'Question ' + str(i + 1) + ':'
        print test_questions[i]
        answer = raw_input('Answer: ')
        if answer.upper() == test_questions[i].correct_answer:
            print 'Correct!'
            correct += 1
        else:
            print 'Wrong! The correct answer is ' + test_questions[i].correct_answer
    print '=' * 80
    print 'EXAM COMPLETE'
    print 'Grade: ' + str(100.0 * correct / number) + ' (' + str(correct) + \
        '/' + str(number) + ')'
        