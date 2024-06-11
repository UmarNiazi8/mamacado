class Baby {
  final String name;
  final String meaning;
  final String gender;

  Baby({
    required this.name,
    required this.meaning,
    required this.gender,
  });
}

final List<Baby> babyNames = [
  Baby(
    name: 'Emma',
    meaning: 'whole or complete',
    gender: 'Female',
  ),
  Baby(
    name: 'Liam',
    meaning: 'strong-willed warrior and protector',
    gender: 'Male',
  ),
  Baby(
    name: 'Olivia',
    meaning: 'olive tree',
    gender: 'Female',
  ),
  Baby(
    name: 'Noah',
    meaning: 'rest or comfort',
    gender: 'Male',
  ),
  Baby(
      name: 'Aamir',
      meaning: 'Populous, Full, Prosperous, Amply Settled',
      gender: 'male'),
  // Add more names as needed
];
