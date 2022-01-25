import 'dart:io';

import 'package:args/args.dart';
import 'package:svg_linter/src/svg_checker.dart';

Future<void> main(List<String> args) async {
  final argParser = ArgParser();
  argParser.addMultiOption("directory", abbr: "d");
  final results = argParser.parse(args);
  final directoriesToScan = results['directory'] as List<String>;

  if (directoriesToScan.isEmpty) {
    print("At least one directory should be specified");
    exitCode = 1;
    return;
  }

  final checker = SvgChecker(directoriesToScan);
  final reports = await checker.run();

  if (reports.any((element) => element.fileReports.isNotEmpty)) {
    exitCode = 1;

    for (final report in reports) {
      print(report.toString());
    }

    return;
  }

  print("OK!");
}
