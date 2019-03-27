#include <library/echo.hpp>

int main(int argc, char ** argv)
{
	if (argc != 2)
		return -1;

	if (library::echo("Hello World") != argv[1])
		return -1;

	return 0;
}
