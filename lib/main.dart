import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickboxing_app/classes.dart';

import 'custom_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'NDG Kickboxing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<dynamic> sessionsAndLabelsList = [];
List<String> monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
String userNameTest = "justin_user";

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    sessionsAndLabelsList.addAll(sessionsList);
    for (var i = 0; i < sessionsAndLabelsList.length; i++) {
      if (sessionsAndLabelsList[i] is SessionData) {
        String monthName = DateFormat('MMMM').format(sessionsAndLabelsList[i].date);
        if (sessionsAndLabelsList.contains(monthName) == false) {
          sessionsAndLabelsList.insert(i, monthName);
        }
      }
    }
    sessionsAndLabelsList.insert(0, SizedBox(height: 10));
  }

  List<SessionData> sessionsList = [
    SessionData(
      title: 'Muay Thai',
      date: DateTime.utc(2024, 11, 3),
      venue: "CSS Gym",
      address: '225-5555 Av. Westminster, Côte Saint-Luc, QC H4W 2J2',
      instructor: 'Justin',
    ),
    SessionData(
      title: 'Karate',
      date: DateTime.utc(2024, 12, 10),
      venue: "CSS Gym",
      address: '225-5555 Av. Westminster, Côte Saint-Luc, QC H4W 2J2',
      instructor: 'Adrien',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: sessionsAndLabelsList.length,
        itemBuilder: (context, index) {
          if (sessionsAndLabelsList[index] is SessionData) {
            return sessionInfoCard(
                context: context,
                user: userNameTest,
                data: sessionsAndLabelsList[index],
                onCheckboxChanged: (value) {
                  setState(() {
                    updateAttendingStatus(sessionsAndLabelsList[index]);
                  });
                });
          } else if (sessionsAndLabelsList[index] is String) {
            return Align(
                child: Text(
                  sessionsAndLabelsList[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                )
            ); //todo - turn this into a good label
          } else {
            return sessionsAndLabelsList[index];
          }
        },
      )),
    );
  }
}

void updateAttendingStatus(SessionData session){
  if (session.attendanceList.contains(userNameTest)) {
    session.attendanceList.remove(userNameTest);
  } else {
    session.attendanceList.add(userNameTest);
  }
}