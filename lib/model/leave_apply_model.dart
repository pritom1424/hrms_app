class LeaveApplyModel {
  final int? userId;
  final int? leaveTypeId;
  final String? fromDate;
  final String? toDate;
  final String? numberOfDays;
  final String? leaveReason;
  LeaveApplyModel(this.userId, this.leaveTypeId, this.fromDate, this.toDate,
      this.numberOfDays, this.leaveReason);
  //user_id, leave_type_id, from_date, to_date, number_of_days, leave_reason
  factory LeaveApplyModel.fromJson(Map<String, dynamic> json) =>
      LeaveApplyModel(
        json["user_id"],
        json["leave_type_id"],
        json["from_date"],
        json["to_date"],
        json["number_of_days"],
        json["leave_reason"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "leave_type_id": leaveTypeId,
        "from_date": fromDate,
        "to_date": toDate,
        "number_of_days": numberOfDays,
        "leave_reason": leaveReason,
      };
}
