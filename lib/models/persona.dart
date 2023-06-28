class Persona {
  final int id;
  final String name;
  final String phone;

  const Persona({
    required this.name,
    required this.id,
    required this.phone,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      name: json['name'],
      phone: json['phone'],
      id: json['id'],
    );
  }
}
