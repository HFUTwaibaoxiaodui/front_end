const String serverIp = '192.168.43.31';
const String serverPort = '9090';
const String defaultImagePath = 'http://121.40.130.17:7777/images/cat.jpeg';

final String getAllOrders = generateURL('/PatrolOrder/selectAll');
final String getOrderById = generateURL('/PatrolOrder/findByOrderId');
final String updateOrderState = generateURL('/PatrolOrder/updateOrderState');
final String addOperationLog = generateURL('/OperationLog/add');
final String logIn =  generateURL('/account/userlogin');
final String addOrderEvaluate =  generateURL('/evaluate/addOrderEvaluate');
final String getEvaluateByOrderId =  generateURL('/evaluate/getEvaluateByOrderId');
final String findOrderCardDetail = generateURL('/PatrolOrder/findOrderCardDetail');
final String selectAccountById = generateURL('/account/selectInformationbyid');
final String submitException = generateURL('/exception/submitException');
final String getExceptionMessageById = generateURL('/exception/getExceptionMessageById');
final String updateExceptionSolveState = generateURL('/exception/updateExceptionSolveState');
final String findOrderCardDetailCount = generateURL('/PatrolOrder/findOrderCardDetailCount');

String generateURL(String path) {
  return 'http://' + serverIp + ':' + serverPort + path;
}