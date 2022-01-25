import 'dart:io';

import 'package:svg_linter/src/constants.dart';
import 'package:svg_linter/src/file_report.dart';
import 'package:svg_linter/src/folder_report.dart';
import 'package:svg_linter/src/graphical_elements.dart';
import 'package:svg_linter/src/svg_problem.dart';
import 'package:xml/xml.dart';
import 'package:xml/xml_events.dart';

class SvgChecker {
  final List<String> directories;

  SvgChecker(this.directories);

  Future<List<FolderReport>> run() async {
    final results = <FolderReport>[];
    for (final dir in directories) {
      results.add(FolderReport(dir, await checkFolder(dir)));
    }

    return results;
  }

  Future<List<FileReport>> checkFolder(String directory) async {
    final rootDirectory = Directory(directory);
    final fileReports = <FileReport>[];

    await for (final file in rootDirectory
        .list(recursive: true)
        .where((event) => event.uri.pathSegments.last.endsWith(".svg"))) {
      final svgFile = File.fromUri(file.uri);
      final document = XmlDocument.parse(await svgFile.readAsString());
      final events = parseEvents(await svgFile.readAsString());

      final fileResults = <SvgProblem>[];

      final imageElements = document.findAllElements("image");
      if (imageElements.isNotEmpty) {
        fileResults.add(SvgProblem.imageTag);
      }
      final styleElements = document.findAllElements("style");
      if (styleElements.isNotEmpty) {
        fileResults.add(SvgProblem.styleTag);
      }
      final titleElements = document.findAllElements("title");
      if (titleElements.isNotEmpty) {
        fileResults.add(SvgProblem.titleTag);
      }
      final descElements = document.findAllElements("desc");
      if (descElements.isNotEmpty) {
        fileResults.add(SvgProblem.descTag);
      }

      final iconComplexity = graphicalElements.fold(
          0,
          (previousValue, element) =>
              document.findAllElements(element).length + previousValue);
      if (iconComplexity > MAX_FILE_COMPLEXITY) {
        fileResults.add(SvgProblem.toManyElements);
      }
      final stat = await file.stat();
      final fileSizeInKb = (stat.size / 1024).ceil();

      if (fileSizeInKb > MAX_FILE_SIZE_IN_KB) {
        fileResults.add(SvgProblem.toBig);
      }

      final elementNames = events
          .whereType<XmlStartElementEvent>()
          .cast<XmlStartElementEvent>()
          .map((e) => e.name)
          .toList();
      if (elementNames.contains("defs") && elementNames.indexOf('defs') != 1) {
        fileResults.add(SvgProblem.wrongDefsOrder);
      }

      if (fileResults.isNotEmpty) {
        fileReports.add(
            FileReport(file.path, fileSizeInKb, iconComplexity, fileResults));
      }
    }

    return fileReports;
  }
}
