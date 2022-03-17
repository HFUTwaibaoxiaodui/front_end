import 'package:frontend/widgets/operation.dart';

class Order {
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
}