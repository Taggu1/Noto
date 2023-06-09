import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

final mapWeekDayNumToString = {
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday",
};

class SelectDaysWidget extends StatefulWidget {
  final List<int> selectedReapeatedDays;
  final void Function(int repeatedDay, bool add) addDay;
  final void Function(bool add) selectAll;
  final String title;
  const SelectDaysWidget(
      {super.key,
      required this.addDay,
      required this.selectedReapeatedDays,
      required this.selectAll,
      this.title = "Select Repeated days"});

  @override
  State<SelectDaysWidget> createState() => _SelectDaysWidgetState();
}

class _SelectDaysWidgetState extends State<SelectDaysWidget> {
  List<int> _selectedReapeatedDays = [];

  @override
  void initState() {
    super.initState();
    _selectedReapeatedDays = widget.selectedReapeatedDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ChoiceChip(
              label: const Text("All days"),
              selected:
                  _selectedReapeatedDays == mapWeekDayNumToString.keys.toList(),
              onSelected: (add) {
                widget.selectAll(add);
                Function eq = const ListEquality().equals;

                if (!eq(_selectedReapeatedDays,
                    mapWeekDayNumToString.keys.toList())) {
                  _selectedReapeatedDays = mapWeekDayNumToString.keys.toList();
                } else {
                  _selectedReapeatedDays = [];
                }
                setState(() {});
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: mapWeekDayNumToString.keys
                      .map(
                        (index) => ChoiceChip(
                          label: Text(mapWeekDayNumToString[index] ?? ""),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(index == 1 ? 12 : 0),
                              topLeft: Radius.circular(index == 1 ? 12 : 0),
                              bottomRight: Radius.circular(index == 7 ? 12 : 0),
                              topRight: Radius.circular(index == 7 ? 12 : 0),
                            ),
                          ),
                          selected: _selectedReapeatedDays.contains(index),
                          onSelected: (add) {
                            if (add ||
                                !_selectedReapeatedDays.contains(index)) {
                              _selectedReapeatedDays.add(index);
                            } else {
                              _selectedReapeatedDays.remove(index);
                            }
                            setState(() {});
                            widget.addDay(index, add);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
