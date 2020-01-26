'''
Created on Jun 18, 2013

@author: mejones
'''

class Entity(object):
    
    def __init__(self, name, maxHealth):
        self.name = name
        self.maxHealth = maxHealth
        self.health = self.maxHealth
        self.attackPower = 0
        self.defensePower = 0
        self.healPower = 0
    
    def attack(self, entity):
        netDamage = min(self.attackPower - entity.defensePower, entity.health)
        entity.health -= netDamage
        print "%s attacks %s for %d damage!" % (self.name, entity.name, netDamage)
        
    def heal(self, entity=None):
        if entity == None:
            entity = self
        netHeal = min(self.healPower, entity.maxHealth - entity.health)
        entity.health += netHeal
        print "%s heals %s for %d health!" % (self.name, entity.name, netHeal)
    
    def __str__(self):
        return "%s (Health: %d/%d)" % (self.name, self.health, self.maxHealth)
    
    
    
    
        