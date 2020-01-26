#include <vector>
#include "EconomicPolicy.h"

#ifndef ECONOMY_H
#define ECONOMY_H

using namespace std;

class Economy
{
	
public: 
	Economy* superEconomy;
	vector<Economy*> subEconomies;
	EconomicPolicy economicPolicy;
	int moneySupply;
	
	Economy(Economy* se = NULL, int ms = 0);
	void registerSubEconomy(Economy*);
};

#endif
