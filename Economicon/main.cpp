#include "Economicon/Economy.h"
#include <iostream>

using namespace std;

int main()
{
	Economy world;
	EconomicPolicy ep;
	
	cout << world.economicPolicy.incomeTaxRate << endl;
	
	return 0;
}
