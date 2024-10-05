class ReservationServiceType {
  const ReservationServiceType({
    required this.id,
    required this.name,
  });

  final int id;
  final Name name;
}

class Name {
  Name({
    required this.ar,
    required this.en,
  });

  final String ar;
  final String en;
}

