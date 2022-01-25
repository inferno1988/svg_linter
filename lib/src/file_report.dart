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
    fileReport.writeln("        Size: $sizeInKb kB");
    fileReport.writeln("        Complexity: $complexity");
    fileReport.writeln("        Problems detected:");
    for (final problem in problemList) {
      fileReport.writeln("        - ${svgProblemAsString(problem)}");
    }

    return fileReport.toString();
  }
}
