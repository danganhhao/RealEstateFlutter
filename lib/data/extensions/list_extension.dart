extension ListExtension on List? {
  List orEmpty() {
    return (this ?? []);
  }
}