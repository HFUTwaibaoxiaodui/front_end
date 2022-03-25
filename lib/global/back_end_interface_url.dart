const String serverIp = '192.168.43.31';
const String serverPort = '9090';
const String defaultImagePath = 'http://121.40.130.17:7777/images/cat.jpeg';

final String getAllOrders = generateURL('/PatrolOrder/selectAll');
final String getOrderById = generateURL('/PatrolOrder/findByOrderId');
final String updateOrderState = generateURL('/PatrolOrder/updateOrderState');
final String addOperationLog = generateURL('/OperationLog/add');
final String logIn =  generateURL('/account/userlogin');
final String signin = generateURL('/account/usersignin');
final String addOrderEvaluate =  generateURL('/evaluate/addOrderEvaluate');
final String getEvaluateByOrderId =  generateURL('/evaluate/getEvaluateByOrderId');
final String findOrderCardDetail = generateURL('/PatrolOrder/findOrderCardDetail');
final String selectAccountById = generateURL('/account/selectInformationbyid');
final String submitException = generateURL('/exception/submitException');
final String getExceptionMessageById = generateURL('/exception/getExceptionMessageById');
final String updateExceptionSolveState = generateURL('/exception/updateExceptionSolveState');
final String findOrderCardDetailCount = generateURL('/PatrolOrder/findOrderCardDetailCount');
final String sendMessage = generateURL('/JPush/sendMessage');
final String updateInformation = generateURL('/account/updateinformation');
final String uploadImage = generateURL('/api/img/uploadImage');
final String updateWorker = generateURL('/PatrolOrder/updateWorker');

final String addPatrolOrderWorkerEdit = generateURL('/PatrolOrderWorkerEdit/insert');
final String addPatrolOrder = generateURL('/PatrolOrder/insert');
final String findByOrderId = generateURL('/PatrolOrderWorkerEdit/findByOrderId');

final String sortOrder = generateURL('/PatrolOrder/sortOrder');

final String getmonthlyData =generateURL('/PatrolOrder/calculateMonthOrderData');
final String giveothers = generateURL('/PatrolOrder/giveOthers');
final String notification = generateURL('/NoticeDetail/findByReceiverId');
String generateURL(String path) {
  return 'http://' + serverIp + ':' + serverPort + path;
}