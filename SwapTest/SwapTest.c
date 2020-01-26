#include <stdio.h>
#include <time.h>

int main()
{
	clock_t t1, t2;
	double time;
	int i;

	for(i=10000; i<=100000000; i*=10)
	{	
		int j;
		for(j=0; j<i; j++)
		{
			
		}
	}
	
	printf("\n*** Xor  Swapping ***\n");

	for(i=10000; i<=100000000; i*=10)
	{
		int a = 2;
		int b = 5;
		int j;
		
		t1 = clock();
		for(j=0; j<i; j++)
		{
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
		}
		t2 = clock();
		
		time = (double)(t2 - t1) / CLOCKS_PER_SEC;
		printf("%10d : %f\n", i, time);
	}
	
	printf("\n*** Temp Swapping ***\n");
	
	for(i=10000; i<=100000000; i*=10)
	{
		int a = 2;
		int b = 5;
		int j;
		
		t1 = clock();		
		for(j=0; j<i; j++)
		{
			int temp = a;
			a = b;
			b = temp;
		}
		t2 = clock();
		
		time = (double)(t2 - t1) / CLOCKS_PER_SEC;
		printf("%10d : %f\n", i, time);
	}

	printf("\n");
	
	return 0;
}
