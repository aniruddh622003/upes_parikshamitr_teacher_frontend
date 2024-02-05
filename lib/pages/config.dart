Map seatingPlan = {
  "message": "Seating Plan",
  "data": {
    "room_no": 4002,
    "total_students": 3,
    "eligible_students": 1,
    "debarred_students": 1,
    "f_hold_students": 1,
    "highest_seat_no": "G5",
    "seating_plan": [
      {
        "sap_id": "500086707",
        "roll_no": "R2142201678",
        "student_name": "Aniruddh Dev Upadhyay",
        "course": "B.Tech CSE AIML 3rd Yr",
        "subject": "Compiler Design",
        "subject_code": "CSEG 2020",
        "seat_no": "A1",
        "eligible": "YES",
        "exam_type": "Supplementary Examination"
      },
      {
        "sap_id": "500086849",
        "roll_no": "R2142201726",
        "student_name": "Khushi Gupta",
        "course": "B.Tech CSE AIML 2nd Yr",
        "subject": "Neural Networks",
        "subject_code": "CSAI 2001",
        "seat_no": "A2",
        "eligible": "DEBARRED",
        "exam_type": "Supplementary Examination"
      },
      {
        "sap_id": "500086123",
        "roll_no": "R2142202233",
        "student_name": "Aarav Sharma",
        "course": "B.Tech CSE AIML 4th Yr",
        "subject": "Big Data",
        "subject_code": "CSAI 2101",
        "seat_no": "G5",
        "eligible": "F_HOLD",
        "exam_type": "Supplementary Examination"
      }
    ]
  }
};

Map studentDetails = {
  "sap_id": "500086123",
  "roll_no": "R2142202233",
  "student_name": "Aarav Sharma",
  "course": "B.Tech CSE AIML 4th Yr",
  "subject": "Big Data",
  "subject_code": "CSAI 2101",
  "seat_no": "G5",
  "eligible": "F_HOLD",
  "exam_type": "Supplementary Examination"
};

List<Map> pendingSupplies = [
  {"name": "B Sheets", "required": 15, "received": 5},
  {"name": "Threads", "required": 10, "received": 5},
  {"name": "A Sheets", "required": 10, "received": 5},
];

List<Map> requiredSupplies = [
  {"name": "B Sheets", "required": 100},
  // {"name": "Threads", "required": 100},
  // {"name": "A Sheets", "required": 50},
  // {"name": "Neural Network Question Papers", "required": 30},
  // {"name": "Big Data Question Papers", "required": 20},
  // {"name": "Pink Slips", "required": 10},
];

String serverUrl = "http://35.154.53.88:3000";
