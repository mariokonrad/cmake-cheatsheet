#include <zlib.h>

#include <boost/program_options.hpp>

#include <fstream>
#include <iostream>
#include <iomanip>
#include <string>

int main(int argc, char ** argv)
{
	std::string input_file;

	namespace po = boost::program_options;
	po::options_description desc("Options");
	desc.add_options()
		("help,h", "shows help information")
		("version,v", "version information")
		("file,f", po::value(&input_file), "input file")
		;
	po::options_description options;
	options.add(desc);

	const auto parsed = po::command_line_parser(argc, argv).options(options).run();
	po::variables_map vm;
	po::store(parsed, vm);
	po::notify(vm);

	if (vm.count("version")) {
		std::cout << "Version 0.0.0\n";
		return 0;
	} else if (vm.count("help")) {
		std::cout << options;
		return -1;
	} else if (vm.count("file")) {
		auto checksum = crc32(0L, Z_NULL, 0);

		std::ifstream ifs(input_file);
		while (ifs) {
			char buffer[1024];
			const auto rc = ifs.readsome(buffer, sizeof(buffer));
			if (rc <= 0)
				break;
			checksum = crc32(checksum, reinterpret_cast<unsigned char *>(buffer), rc);
		}
		ifs.close();

		std::cout << "checksum: 0x" << std::hex << std::setw(8)
			<< std::setfill('0') << checksum << '\n';
	}
}
