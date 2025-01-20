package cat.institutmarianao.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.service.ItemService;
import cat.institutmarianao.service.OrderService;

@Controller
@RequestMapping("/admin/orders")
public class AdminController {
	@Autowired
	private ItemService itemService;

	@Autowired
	private OrderService orderService;

	@GetMapping
	public ModelAndView orders() {
		List<Order> adminOrders = orderService.getAll();

		ModelAndView modelview = new ModelAndView("orders");
		modelview.addObject("Orders", adminOrders);
		modelview.addObject("STATES", Order.STATES);
		return modelview;
	}

	@PostMapping("/setDeliveryDate")
	public String setDeliveryDate(@RequestParam("reference") Long reference,
			@RequestParam("deliveryDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date deliveryDate) {

		Order order = orderService.get(reference);

		if (order != null) {
			order.setDeliveryDate(deliveryDate);
			orderService.update(order);
		}

		return "redirect:/admin/orders";
	}

	@PostMapping("/setState")
	public String setState(@RequestParam("reference") Long reference, @RequestParam("state") int state) {

		Order order = orderService.get(reference);

		if (order != null) {
			if (state >= 0 && state < Order.STATES.length) {
				order.setState(state);
				orderService.update(order);
			}
		}

		return "redirect:/admin/orders";
	}
}
