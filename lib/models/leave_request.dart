// models/leave_request.dart
class LeaveRequest {
  final String facultyName;
  final double numberOfDays;
  final String leaveType;
  final String leaveReason;
  final String from;
  final String to;
  final String appliedDate;

  LeaveRequest({
    required this.facultyName,
    required this.numberOfDays,
    required this.leaveType,
    required this.leaveReason,
    required this.from,
    required this.to,
    required this.appliedDate,
  });
}
