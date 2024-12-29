class Exercise {
  final String id;
  final String name;
  final String description;
  final String imageUrl; // Optional
  final int duration; // Duration in seconds (if applicable)
  final int reps; // Number of repetitions
  final int sets; // Number of sets

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl = '',
    this.duration = 0,
    this.reps = 0,
    this.sets = 0,
  });
}
