const String serverIp = '192.168.43.31';
const String serverPort = '9090';
final String getAllOrders = generateURL('/PatrolOrder/selectAll');
final String getOrderById = generateURL('/PatrolOrder/findByOrderId');
final String updateOrderState = generateURL('/PatrolOrder/updateOrderState');
final String addOperationLog = generateURL('/OperationLog/add');
final String logIn =  generateURL('/account/userlogin');
final String addOrderEvaluate =  generateURL('/evaluate/addOrderEvaluate');
final String getEvaluateByOrderId =  generateURL('/evaluate/getEvaluateByOrderId');
final String findOrderCardDetail = generateURL('/PatrolOrder/findOrderCardDetail');
final String selectAccountById = generateURL('/account/selectInformationbyid');

final String addPatrolOrderWorkerEdit = generateURL('/PatrolOrderWorkerEdit/insert');
final String addPatrolOrder = generateURL('/PatrolOrder/insert');
final String uploadImage = generateURL('/api/img/uploadImage');

String generateURL(String path) {
  return 'http://' + serverIp + ':' + serverPort + path;
}