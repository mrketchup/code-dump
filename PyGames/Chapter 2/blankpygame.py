'''
Created on Dec 1, 2013

@author: mejones
'''

import pygame
import sys
from pygame.locals import *

if __name__ == '__main__':
    pygame.init()
    DISPLAYSURF = pygame.display.set_mode((400, 300))
    pygame.display.set_caption('Hello World!')
    while True:
        for event in pygame.event.get():
            if event.type == QUIT:
                pygame.quit()
                sys.exit()
            pygame.display.update()
                
