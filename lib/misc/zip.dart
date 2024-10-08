List<(A, B)> zip2<A,B>(Iterable<A> a, Iterable<B> b) {
  if (a.length <= b.length) {
    return [
      for (var (index, item) in a.indexed)
        (item, b.elementAt(index))
    ];
  } else {
    return [
      for (var (index, item) in b.indexed)
        (a.elementAt(index), item)
    ];
  }
}

List<(A, B, C)> zip3<A,B,C>(Iterable<A> a, Iterable<B> b, Iterable<C> c) {
  if (a.length <= b.length && a.length <= c.length) {
    return [
      for (var (index, item) in a.indexed)
        (item, b.elementAt(index), c.elementAt(index))
    ];
  } else if (b.length <= a.length && b.length <= c.length) {
    return [
      for (var (index, item) in b.indexed)
        (a.elementAt(index), item, c.elementAt(index))
    ];
  } else {
    return [
      for (var (index, item) in c.indexed)
        (a.elementAt(index), b.elementAt(index), item)
    ];
  }
}