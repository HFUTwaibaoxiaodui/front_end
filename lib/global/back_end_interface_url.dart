const String serverIp = '192.168.1.102';
const String serverPort = '9090';
final String getAllOrders = generateURL('/PatrolOrder/selectAll');
final String getOrderById = generateURL('/PatrolOrder/findByOrderId');
final String updateOrderState = generateURL('/PatrolOrder/updateOrderState');
final String addOperationLog = generateURL('/OperationLog/add');

String generateURL(String path) {
  return 'http://' + serverIp + ':' + serverPort + path;
}