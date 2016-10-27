#include"mesh_objects.h"
#include <iostream>
#include <vector>

int main()
{
	Point a(1,1,0,0);
	Point b(2,2,0,1);
	Point c(3,3,1,0);
	
	a.print(std::cout);
	b.print(std::cout);
	c.print(std::cout);
	
	std::cout<<b.getId()<<std::endl;
	b.print(std::cout);	
	
	std::vector<Point> points;
	points.push_back(c);
	points.push_back(b);
	points.push_back(a);

	Triangle<3,2,2> t(1,points);
	
	std::cout<<"I punti sono"<<std::endl;
	for (int i=0; i<3; ++i)
		points[i].print(std::cout);
	std::cout<<std::endl;
	
	t.print(std::cout);;
	
return 0;
}