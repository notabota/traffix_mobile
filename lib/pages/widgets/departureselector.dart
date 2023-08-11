import 'package:flutter/material.dart';
class DepartureSelector extends StatefulWidget {
  const DepartureSelector({
    Key? key,
  }) : super(key: key);

  @override
  DepartureSelectorState createState() => DepartureSelectorState();
}

class DepartureSelectorState extends State<DepartureSelector> {
  int? _selected = 0;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: Theme.of(context).textTheme.button?.apply(color: Colors.white),
      iconEnabledColor: Colors.white,
      underline: Container(),
      value: _selected,
      onChanged: (int? i) {
        _selected = i;
      },
      items: const [
        DropdownMenuItem(
          value: 0,
          child: Text("Now"),
        )
      ],
    );
  }
}
