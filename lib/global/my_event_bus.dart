import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class RefreshOrderDetailEvent {}
class InitOrderListEvent {}
class UpdateTabViewEvent {
  String state;
  UpdateTabViewEvent({required this.state});
}

class UpdateOrderNumEvent {
  int num;
  UpdateOrderNumEvent({required this.num});
}

class UpdateExceptionHandlePage{}

class RefreshDifferentStateOrderCount{}


