#include "demo_application.hpp"
#include <QApplication>

demo_application::demo_application(int argc, char ** argv)
	: app(new QApplication(argc, argv))
{
}

demo_application::~demo_application()
{
	delete app;
	app = nullptr;
}

void demo_application::aboutQt()
{
	app->aboutQt();
}
