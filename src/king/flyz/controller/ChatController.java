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

//有关于心理咨询、咨询预约的Controller
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
	//在预约专家页面点击预约心理咨询师
	@RequestMapping("/getOrdersByID")
	public void getOrdersByID(int id,String myInfo,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		User user = (User)session.getAttribute("myUser");
		int customer_id = user.getId();
		List<Orders> list = ordersService.getOrderByUserID(customer_id);
		System.out.println(list);
		//如果用户现在不存在有效订单（即订单状态是0和1的订单不存在）时，添加新的，否则抛出异常
		if(list.isEmpty()) {
			Orders orders = new Orders();
			orders.setCustomer_id(customer_id);
			orders.setExpert_id(id);
			orders.setStatus(0);
			orders.setHouse_id((int)((Math.random()*9+1)*10000));
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			orders.setCreateAt(dateFormat.format(date));
			//看看价格
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
		//此时表示整个咨询过程已经完成，从用户的钱包扣费，并且给咨询师加钱
		//从用户钱包扣钱，咨询师钱包加钱
		orders = ordersService.getOrderByID(id);
		Purse userPurse = purseService.getPurseByUserId(orders.getCustomer_id());
		Purse expertPurse = purseService.getPurseByUserId(orders.getExpert_id());
		//看看这次交易的金额是多少
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
		//需要咨询师给个信息
		orders.setMyInfo(myInfo);
		ordersService.updateOrderById(orders);
	}
	@RequestMapping("/order/changeOrder")
	public void changeOrder(int id,String myInfo,HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Orders orders = ordersService.getOrderByID(id);
		//需要修改信息
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
