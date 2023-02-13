// ignore_for_file: public_member_api_docs, sort_constructors_first
class Planogram {
  String id;
  String link;
  Planogram({
    required this.id,
    required this.link,
  });
}

class Plan {
  String? selectedId;
  List<Planogram>? planograms;
  Plan({
    required this.selectedId,
    required this.planograms,
  });
}
