sealed class SvgProblem {
  String description();
}

sealed class TagProblem extends SvgProblem {
  final String tag;

  TagProblem(this.tag);

  @override
  String description() => "<$tag> tag is not allowed";
}

class ImageTag extends TagProblem {
  ImageTag() : super('image');
}

class StyleTag extends TagProblem {
  StyleTag() : super('style');
}

class TitleTag extends TagProblem {
  TitleTag() : super('title');
}

class DescTag extends TagProblem {
  DescTag() : super('desc');
}

class ComplexityProblem extends SvgProblem {
  @override
  String description() => 'SVG file is to complex, reduce number of elements';
}

class SizeProblem extends SvgProblem {
  @override
  String description() => 'SVG file is to big, reduce its size';
}

class DefsOrder extends SvgProblem {
  @override
  String description() =>
      '<defs> section should be placed before other elements (on top the file)';
}
