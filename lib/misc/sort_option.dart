typedef SortFunction<T> = int Function(T, T);

class SortOption<T> {
  final String name;
  final SortFunction<T> sortFunction;

  const SortOption({required this.name, required this.sortFunction});
}