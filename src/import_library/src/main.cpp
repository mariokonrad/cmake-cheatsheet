#include <library/echo.hpp>
#include <iostream>

int main(int, char **)
{
	std::cout << library::echo("Hello World") << '\n';
}
