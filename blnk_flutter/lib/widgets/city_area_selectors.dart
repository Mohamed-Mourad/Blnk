import 'package:flutter/material.dart';

class CityAreaSelectors extends StatefulWidget {
  const CityAreaSelectors({super.key});

  @override
  _CityAreaSelectorsState createState() => _CityAreaSelectorsState();
}

class _CityAreaSelectorsState extends State<CityAreaSelectors> {
  String? selectedCity;
  String? selectedArea;

  final Map<String, List<String>> cityAreas = {
    'Cairo': ['Nasr City', 'Maadi', 'Heliopolis'],
    'Giza': ['6th of October', 'Dokki', 'Mohandesin'],
    'Alexandria': ['Stanley', 'Smouha', 'Sidi Gaber'],
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedCity,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),

              labelText: "City",
            ),
            items: cityAreas.keys
                .map((city) => DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;
                selectedArea = null; // Reset area when city changes
              });
            },
            validator: (value) => value == null ? 'City is required' : null,
          ),
        ),
        const SizedBox(width: 10.0),

        // Area Dropdown
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedArea,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),

              labelText: "Area",
            ),
            items: selectedCity == null
                ? []
                : cityAreas[selectedCity!]!
                .map((area) => DropdownMenuItem<String>(
              value: area,
              child: Text(area),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedArea = value;
              });
            },
            validator: (value) => value == null ? 'Area is required' : null,
          ),
        ),
      ],
    );
  }
}
