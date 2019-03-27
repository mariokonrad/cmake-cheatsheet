#ifndef DEMO_APPLICATION_HPP
#define DEMO_APPLICATION_HPP

#include <QObject>

class QApplication;

// This class would basically not be necessary. Its purpose is to
// show a class that is derived from `QObject`, contains `Q_OBJECT`,
// therefore triggers the `AUTOMOC` feature.

class demo_application : public QObject
{
	Q_OBJECT

public:
	demo_application(int argc, char ** argv);
	virtual ~demo_application();

	// QObject disables copy exiplicitly, we disable copy and move,
	// because we are handling QApplication objects which cannot be
	// destroyed multiple times. A case which would be required by
	// a proper move asignment.
	demo_application(const demo_application &) = delete;
	demo_application & operator=(const demo_application &) = delete;
	demo_application(demo_application &&) = delete;
	demo_application & operator=(demo_application &&) = delete;

	void aboutQt();

private:
	QApplication * app = nullptr;
};

#endif
