class Note {
  final String id;
  final String title;
  final String description;
  final String university;
  final String course;
  final String exam;
  final String year;
  final String type;
  final int pryce;
  final List<String> immagini;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.university,
    required this.course,
    required this.exam,
    required this.year,
    required this.type,
    required this.pryce,
    required this.immagini,
  });
}
