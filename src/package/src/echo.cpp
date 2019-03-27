#include <simple/echo.hpp>

namespace simple {
std::string echo(const std::string & text)
{
	return text + ", " + text;
}
}
