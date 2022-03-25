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

class UpdatePeopleInfoEvent{
  String peopleInfo='';
  UpdatePeopleInfoEvent({
    required this.peopleInfo
});
}

class UpRealname{
  String peopleInforealname='';
  UpRealname({
    required this.peopleInforealname
});
}
class UpPhone{
  String peopleInfophone='';
  UpPhone({
    required this.peopleInfophone
  });
}
class UpArea{
  String peopleInfoarea='';
  UpArea({
    required this.peopleInfoarea
  });
}



