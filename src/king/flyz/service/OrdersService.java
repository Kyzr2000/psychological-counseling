package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Orders;

public interface OrdersService {
	public List<Orders> getOrderByUserID(int customer_id);
	public List<Orders> getOrderListByUserID(int customer_id);
	public List<Orders> getOrderListWithUser(int customer_id);
	public List<Orders> getOrderListWithUser2(int expert_id);
	public Orders getOrderByID(int id);
	public int addOrders(Orders orders);
	public int updateOrderById(Orders orders);
	public int getHIDByCID(int customer_id);
	public List<Integer> getHIDByEID(int expert_id);
	public List<Orders> getAllOrder();
}
