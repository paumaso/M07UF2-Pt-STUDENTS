package cat.institutmarianao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//TODO - Configure Spring element and add mappings
@Controller
@RequestMapping("/admin")
public class AdminController {

	@GetMapping("/orders")
	public ModelAndView orders() {

		// TODO - get all user orders
		// TODO - Prepare the orders.jsp view and send user orders and Order.STATES as
		// STATES
		// TODO - parameter
		return null;
	}
	
	@PostMapping("/orders/setDeliveryDate")
	public String setDeliveryDate(/* TODO - Get reference parameter */
	/* TODO - Get deliveryDate parameter */) {

		// TODO - Get the order related to the reference passed as parameter
		// TODO - Set the order delivery date with the deliveryDate value
		// TODO - Update the order
		return "redirect:/admin/orders";
	}
	
	@PostMapping("/orders/setState")
	public String setState(/* TODO - Get reference parameter */
	/* TODO - Get state parameter */) {

		// TODO - Get the order related to the reference passed as parameter
		// TODO - Set the order state with the state value
		// TODO - Update the order
		return "redirect:/admin/orders";
	}
}
