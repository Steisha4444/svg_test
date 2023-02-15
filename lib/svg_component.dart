// class SvgComponent {
//   int id;
//   bool isSelected;
//   String name;
//   String fillColor;
//   String path;
//   String selectedColor = '0xFFC00000';
//   String activeColor = '';
//   SvgComponent({
//     required this.id,
//     required this.isSelected,
//     required this.name,
//     required this.fillColor,
//     required this.path,
//   });
// }

class SvgComponent {
  int? id = 0;
  bool? isSelected = false;
  String? name;
  String? x = '0.0';
  String? y = '0.0';
  String? transform;
  String? fillColor;
  String? path;
  String? selectedColor = '0xFFC00000';
  String? activeColor = '';
  SvgComponent({
    this.id,
    this.isSelected,
    this.x = '0.0',
    this.y = '0.0',
    this.transform,
    this.name,
    this.fillColor,
    this.path,
  });
}
