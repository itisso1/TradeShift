# TradeShift
Code assignmnt

Solution to the triangle type assignment. 

I have created a calss called Triangle (Triangle.pm) that will validate the input (the 3 sides passed by user) and return the type of triangle or inform the user that the input is invalid. The class should be easy enough to extend to return e.g. area. Potentially one can also create a base class called Shape, from which concrete shapes will inherit, so you can add Square, Circle, etc.

In the /t folder there is a unit test case that checks the validation mechanism and that the Triangle class actually returns the type of triangle.

Finally there is a basic script (Triangle.pl) that will take input form user (command line), create a triangle object and call the trinagle_type function to get the type of triangle.
