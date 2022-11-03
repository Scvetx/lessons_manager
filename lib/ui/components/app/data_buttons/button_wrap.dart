/* wrapper class for a button with data
*/

class ButtonWrap {
  final String key;
  final String label;
  final Object? data;
  late final Function onSelect;
  late bool selected;
  ButtonWrap(
      {required this.key,
      required this.label,
      this.data,
      required Function onSelect,
      this.selected = false}) {
    this.onSelect = () {
      selected = selected ? false : true;
      onSelect(this);
    };
  }
}
