package king.flyz.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.fabric.xmlrpc.base.Array;

import king.flyz.pojo.Orders;
import king.flyz.pojo.Purse;
import king.flyz.pojo.User;
import king.flyz.service.ExpertService;
import king.flyz.service.OrdersService;
import king.flyz.service.PurseService;

//�й���������ѯ����ѯԤԼ��Controller
@Controller
@RequestMapping("/chat")
public class ChatController {
	@Resource
	private OrdersService ordersService;
	@Resource
	private ExpertService expertService;
	@Resource
	private PurseService purseService;
	@RequestMapping("/main")
	public String chatVisit(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		return "chat";
	}
	//��ԤԼר��ҳ����ԤԼ������ѯʦ
	@RequestMapping("/getOrdersByID")
	public void getOrdersByID(int id,String myInfo,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		User user = (User)session.getAttribute("myUser");
		int customer_id = user.getId();
		List<Orders> list = ordersService.getOrderByUserID(customer_id);
		System.out.println(list);
		//����û����ڲ�������Ч������������״̬��0��1�Ķ��������ڣ�ʱ������µģ������׳��쳣
		if(list.isEmpty()) {
			Orders orders = new Orders();
			orders.setCustomer_id(customer_id);
			orders.setExpert_id(id);
			orders.setStatus(0);
			orders.setHouse_id((int)((Math.random()*9+1)*10000));
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			orders.setCreateAt(dateFormat.format(date));
			//�����۸�
			String price = expertService.getExpertPrice(id);
			orders.setPrice(price);
			orders.setMyInfo(myInfo);
			System.out.println(myInfo);
			ordersService.addOrders(orders);
		}
		else {
			throw new Exception();
		}
	}
	@RequestMapping("/orderList")
	@ResponseBody
	public List<Orders> orderList(HttpServletRequest request, HttpServletResponse response,HttpSession session){
		User user = (User)session.getAttribute("myUser");
		List<Orders> list = new ArrayList<Orders>();
		if(user.getStatus()==0||user.getStatus()==2) {
			list = ordersService.getOrderListWithUser(user.getId());
		}
		else {
			list = ordersService.getOrderListWithUser2(user.getId());
		}
		return list;
	}
	@RequestMapping("/orderAllList")
	@ResponseBody
	public List<Orders> orderAllList(HttpServletRequest request, HttpServletResponse response,HttpSession session){
		return ordersService.getAllOrder();
	}
	@RequestMapping("/order/passOrder")
	public void passOrder(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = new Orders();
		orders.setId(id);
		orders.setStatus(2);
		ordersService.updateOrderById(orders);
		//��ʱ��ʾ������ѯ�����Ѿ���ɣ����û���Ǯ���۷ѣ����Ҹ���ѯʦ��Ǯ
		//���û�Ǯ����Ǯ����ѯʦǮ����Ǯ
		orders = ordersService.getOrderByID(id);
		Purse userPurse = purseService.getPurseByUserId(orders.getCustomer_id());
		Purse expertPurse = purseService.getPurseByUserId(orders.getExpert_id());
		//������ν��׵Ľ���Ƕ���
		int price = Integer.parseInt(orders.getPrice());
		int userPrice = Integer.parseInt(userPurse.getMoney())-price;
		int expertPrice = Integer.parseInt(expertPurse.getMoney())+price;
		userPurse.setMoney(String.valueOf(userPrice));
		expertPurse.setMoney(String.valueOf(expertPrice));
		purseService.updateIOPurse(userPurse);
		purseService.updateIOPurse(expertPurse);
	}
	@RequestMapping("/order/cancelOrder")
	public void cancelOrder(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = new Orders();
		orders.setId(id);
		orders.setStatus(3);
		ordersService.updateOrderById(orders);
	}
	@RequestMapping("/order/acceptOrder")
	public void acceptOrder(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = new Orders();
		orders.setId(id);
		orders.setStatus(1);
		ordersService.updateOrderById(orders);
	}
	@RequestMapping("/order/refuseOrder")
	public void refuseOrder(int id,String myInfo,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = new Orders();
		orders.setId(id);
		orders.setStatus(3);
		//��Ҫ��ѯʦ������Ϣ
		orders.setMyInfo(myInfo);
		ordersService.updateOrderById(orders);
	}
	@RequestMapping("/order/changeOrder")
	public void changeOrder(int id,String myInfo,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = ordersService.getOrderByID(id);
		//��Ҫ�޸���Ϣ
		orders.setMyInfo(myInfo);
		ordersService.updateOrderById(orders);
	}
	@RequestMapping("/getHIDByCID")
	@ResponseBody
	public int getHIDByCID(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		int HID = ordersService.getHIDByCID(id);
		return HID;
	}
	@RequestMapping("/getHIDByEID")
	@ResponseBody
	public List<Integer> getHIDByEID(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		List<Integer> EID = ordersService.getHIDByEID(id);
		return EID;
	}
}
