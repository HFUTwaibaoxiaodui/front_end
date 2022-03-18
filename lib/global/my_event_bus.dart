import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class RefreshOrderDetailEvent {}
class InitOrderListEvent {}
class UpdateOrderNum{
  int num;
  UpdateOrderNum({required this.num});
}



