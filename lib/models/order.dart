import 'operation.dart';

class Order {
  /// 工单id
  int id;
  /// 创建者id
  int creatorId;
  /// 工单标题
  String? orderTitle;
  /// 工单创建者名称
  String? creatorName;
  /// 巡检地址
  String? orderAddress;
  /// 工单创建时间
  String? createTime;
  /// 工单创建时间
  String? orderCode;
  /// 工单状态
  String orderState;
  /// 工单创建者的电话号码
  String? phoneNum;
  /// 工单创建者的所属区域
  String? area;
  /// 工单描述
  String? description;

  List<Operation>? operationList;

  Order({
    required this.id,
    required this.creatorId,
    this.orderTitle,
    this.creatorName,
    this.orderAddress,
    this.createTime,
    this.orderCode,
    required this.orderState,
    this.phoneNum,
    this.area,
    this.description,
    this.operationList
  });

  static Order fromJson(Map<String, dynamic> json) {

    List<Operation> operationLogList = [];

    if (json['operationLogList'] != null) {
      json['operationLogList'].forEach((element) {
        operationLogList.add(Operation.fromJson(element));
      });
    }

    return Order(
      id: json['orderId'],
      creatorId: json['creatorId'],
      orderTitle: json['orderTitle'],
      creatorName: json['creatorName'],
      orderAddress: json['orderAddress'],
      createTime: json['gmtCreate'],
      orderCode: json['orderNumber'],
      orderState: json['orderState'],
      phoneNum: json['phone'],
      area: json['area'],
      description: json['orderDescription'],
      operationList: operationLogList
    );
  }

  @override
  String toString() {
    return 'Order{orderTitle: $orderTitle, creatorName: $creatorName, orderAddress: $orderAddress, createTime: $createTime, orderCode: $orderCode, orderState: $orderState, phoneNum: $phoneNum, area: $area, description: $description, operationList: $operationList}';
  }
}