package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.OrdersMapper;
import king.flyz.pojo.Orders;
import king.flyz.service.OrdersService;

@Service("ordersService")
public class OrdersServiceImpl implements OrdersService {
	@Resource
	private OrdersMapper ordersMapper;
	@Override
	public List<Orders> getOrderByUserID(int customer_id) {
		return ordersMapper.getOrderByUserID(customer_id);
	}
	@Override
	public int addOrders(Orders orders) {
		return ordersMapper.addOrders(orders);
	}
	@Override
	public List<Orders> getOrderListByUserID(int customer_id) {
		return ordersMapper.getOrderListByUserID(customer_id);
	}
	@Override
	public List<Orders> getOrderListWithUser(int customer_id) {
		return ordersMapper.getOrderListWithUser(customer_id);
	}
	@Override
	public List<Orders> getOrderListWithUser2(int expert_id) {
		return ordersMapper.getOrderListWithUser2(expert_id);
	}
	@Override
	public Orders getOrderByID(int id) {
		return ordersMapper.getOrderByID(id);
	}
	@Override
	public int updateOrderById(Orders orders) {
		return ordersMapper.updateOrderById(orders);
	}
	@Override
	public int getHIDByCID(int customer_id) {
		return ordersMapper.getHIDByCID(customer_id);
	}
	@Override
	public List<Integer> getHIDByEID(int expert_id) {
		return ordersMapper.getHIDByEID(expert_id);
	}
	@Override
	public List<Orders> getAllOrder() {
		return ordersMapper.getAllOrder();
	}

}
