import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickboxing_app/classes.dart';

Widget sessionInfoCard({required BuildContext context, required String user, required SessionData data, required Function onCheckboxChanged}) {
  String status = "Open"; //todo
  bool isAttending = data.isBeingAttendedByUser(user);
  final ValueChanged<bool> onAttendingChanged;

  // Progress bar:
  double attendanceFraction = data.actualAttendees / data.maxAttendees;  // Calculate the attendance fraction (0.0 to 1.0)
  double minMarkerPosition = data.minAttendees / data.maxAttendees; // Calculate the position for the minimum attendance marker (0.0 to 1.0)

  final bool hasEnoughParticipants = attendanceFraction > minMarkerPosition;

  if (hasEnoughParticipants) {
    status = "Confirmed";
  } else {
    status = "needs ${data.minAttendees - data.actualAttendees} more";
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat("E. MMM. d");
    return formatter.format(date);
  }

  return Padding(
    padding: const EdgeInsets.all(10),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.title, style: const TextStyle(fontSize: 25)),
              Text(formatDate(data.date), style: const TextStyle(fontSize: 25, color: Colors.grey)),
            ],
          ),
          //Text(address, style: const TextStyle(color: Colors.grey)),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Divider(thickness: 2),
          ), //add padding
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Venue: ${data.venue}"),
                  Text("Instructor: ${data.instructor}"),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: hasEnoughParticipants ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendance: ${data.actualAttendees}/${data.maxAttendees}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                // Empty bar background
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Filled attendance bar
                FractionallySizedBox(
                  widthFactor: attendanceFraction,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: hasEnoughParticipants ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                // Minimum attendance marker
                Positioned(
                  left: minMarkerPosition * MediaQuery.of(context).size.width,
                  child: Container(
                    width: 2,
                    height: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Attending:'),
              Theme(
                data: ThemeData(
                  checkboxTheme: CheckboxThemeData(
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                child: Checkbox(
                  value: isAttending,
                  onChanged: (newValue) {
                    onCheckboxChanged(newValue);
                  },
                  activeColor: Colors.brown.shade400,
                ),
              ),
            ],
          ),
        ]),
      ),
    ),
  );
}