import 'package:svg_linter/src/constants.dart';
import 'package:svg_linter/src/svg_problem.dart';

class FileReport {
  final String name;
  final int sizeInKb;
  final int complexity;
  final List<SvgProblem> problemList;

  FileReport(this.name, this.sizeInKb, this.complexity, this.problemList);

  @override
  String toString() {
    final fileReport = StringBuffer();

    fileReport.writeln("    File report: $name");
    fileReport
        .writeln("        Size: $sizeInKb kB, max: $MAX_FILE_SIZE_IN_KB kB");
    fileReport
        .writeln("        Complexity: $complexity, max: $MAX_FILE_COMPLEXITY");
    fileReport.writeln("        Problems detected:");
    for (final problem in problemList) {
      fileReport.writeln("        - ${problem.description()}");
    }

    return fileReport.toString();
  }
}
