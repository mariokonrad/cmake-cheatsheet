#include <simple/echo.hpp>
#include "echo_private.hpp"

namespace simple {
std::string echo(const std::string & text)
{
	return text + detail::separator + text;
}
}
