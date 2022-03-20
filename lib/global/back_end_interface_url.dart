const String serverIp = '121.40.130.17';
const String serverPort = '9090';
final String getAllOrders = generateURL('/PatrolOrder/selectAll');
final String getOrderById = generateURL('/PatrolOrder/findByOrderId');
final String updateOrderState = generateURL('/PatrolOrder/updateOrderState');
final String addOperationLog = generateURL('/OperationLog/add');
final String logIn =  generateURL('/account/userlogin');
final String addOrderEvaluate =  generateURL('/evaluate/addOrderEvaluate');
final String getEvaluateByOrderId =  generateURL('/evaluate/getEvaluateByOrderId');
final String findOrderCardDetail = generateURL('/PatrolOrder/findOrderCardDetail');

String generateURL(String path) {
  return 'http://' + serverIp + ':' + serverPort + path;
}