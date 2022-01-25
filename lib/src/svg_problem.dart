enum SvgProblem {
  imageTag,
  styleTag,
  titleTag,
  descTag,
  toManyElements,
  toBig,
  wrongDefsOrder,
}

String svgProblemAsString(SvgProblem problem) {
  switch (problem) {
    case SvgProblem.imageTag:
      return '<image> tag is not allowed';
    case SvgProblem.styleTag:
      return '<style> tag is not allowed';
    case SvgProblem.titleTag:
      return '<title> tag is not allowed';
    case SvgProblem.descTag:
      return '<desc> tag is not allowed';
    case SvgProblem.toManyElements:
      return 'SVG file is to complex, reduce number of elements';
    case SvgProblem.toBig:
      return 'SVG file is to big, reduce its size';
    case SvgProblem.wrongDefsOrder:
      return '<defs> section should be placed before other elements (on top the file)';
  }

  return "Unknown problem";
}
