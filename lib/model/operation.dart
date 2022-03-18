class Operation {
  /// 操作名称
  String? operationName;
  /// 操作描述
  String? description;
  /// 操作时间
  String? operationTime;

  Operation({this.operationName, this.description, this.operationTime});

  static Operation fromJson(Map<String, dynamic> json) {
    return Operation(
      operationName: json['operationName'],
      operationTime: json['operationTime'],
      description: json['description']
    );
  }

  @override
  String toString() {
    return 'Operation{operationName: $operationName, description: $description, operationTime: $operationTime}';
  }
}