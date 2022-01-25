import 'package:svg_linter/src/file_report.dart';

class FolderReport {
  final String folderName;
  final List<FileReport> fileReports;

  FolderReport(this.folderName, this.fileReports);

  @override
  String toString() {
    final folderReport = StringBuffer();
    folderReport.writeln("Folder report start: $folderName");
    folderReport.writeln("Name: ");
    folderReport.writeAll(fileReports);
    folderReport.writeln("Folder report end: $folderName");
    folderReport.writeln('');
    return folderReport.toString();
  }
}
