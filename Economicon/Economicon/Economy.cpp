#include "Economy.h"

Economy::Economy(Economy* se, int ms) : 
	superEconomy(se), 
	moneySupply(ms)
{	
	if (superEconomy != NULL) 
	{
		superEconomy->registerSubEconomy(this);
	}
}

void Economy::registerSubEconomy(Economy* e)
{
	subEconomies.insert(subEconomies.end(), e);
}
