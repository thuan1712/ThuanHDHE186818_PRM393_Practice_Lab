Stream<int> transformNumbers(Stream<int> source) {
  return source
      .map((number) => number * number)
      .where((squared) => squared % 2 == 0);
}
