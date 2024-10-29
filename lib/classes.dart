class SessionData {
  SessionData({
    required this.title,
    required this.date,
    required this.venue,
    required this.address,
    required this.instructor,
  });
  String title;
  DateTime date;
  String venue;
  String address;
  String instructor;

  List<String> attendanceList = [];
  int maxAttendees = 15;
  int minAttendees = 3;

  get actualAttendees => attendanceList.length;

  String getMonth() {
    return date.month.toString();
  }

  bool isBeingAttendedByUser(String user) {
    return attendanceList.contains(user);
  }
}
