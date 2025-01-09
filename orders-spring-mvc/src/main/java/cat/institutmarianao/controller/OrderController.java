package cat.institutmarianao.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.domain.Item;
import cat.institutmarianao.domain.Order;
import cat.institutmarianao.domain.User;
import cat.institutmarianao.repository.ItemRepository;
import cat.institutmarianao.repository.OrderRepository;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

//TODO - Configure Spring element and add mappings
@Controller
@RequestMapping("/users/orders")
@SessionAttributes("order")
public class OrderController {
	@Autowired
	private ItemRepository itemRepository;
	@Autowired
	private OrderRepository orderRepository;

	@ModelAttribute("order")
	public Order setupOrder() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User client = (User) authentication.getPrincipal();

		Order order = new Order();
		order.setClient(client);
		return order;
	}

	@GetMapping
	public ModelAndView orders(@ModelAttribute("order") Order order) {
		User client = order.getClient();
		List<Order> userOrders = client.getOrders();
		System.out.println("Number of orders for client: " + (userOrders != null ? userOrders.size() : "null"));

	    if (userOrders != null) {
	        userOrders.forEach(o -> System.out.println("Order reference: " + o.getReference()));
	    } else {
	        System.out.println("No orders found for the client.");
	    }
	    
		ModelAndView modelview = new ModelAndView("orders");
		modelview.addObject("userOrders", userOrders);
		modelview.addObject("STATES", Order.STATES);
		return modelview;
	}

	@GetMapping("/newOrder")
	public ModelAndView newOrder(HttpSession session) {
	    Order order = (Order) session.getAttribute("order");

	    if (order == null) {
	        order = new Order();
	        session.setAttribute("order", order);
	    }

	    List<Item> allItems = itemRepository.getAll();

	    ModelAndView modelView = new ModelAndView("newOrder");

	    modelView.addObject("availableItems", allItems);
	    modelView.addObject("order", order);

	    return modelView;
	}

	@GetMapping("/newOrder/clearItems")
	public String newOrderClearItems(@SessionAttribute("order") Order order) {

		order.getItems().clear();

		return "redirect:/users/orders/newOrder";
	}

	@GetMapping("/newOrder/increaseItem")
	public String newOrderIncreaseItem(@SessionAttribute("order") Order order,
			 @RequestParam("reference") Long reference) {

		Item item = itemRepository.get(reference);
		if (item != null) {
			Map<Item, Integer> items = order.getItems();

			if (items.containsKey(item)) {
				items.put(item, items.get(item) + 1);
			} else {
				items.put(item, 1);
			}
		}
		return "redirect:/users/orders/newOrder";
	}

	@GetMapping("/newOrder/decreaseItem")
	public String newOrderDecreaseItem(@SessionAttribute("order") Order order,
	                                   @RequestParam("reference") Long reference) {
	    Item item = itemRepository.get(reference);
	    if (item != null) {
	        Map<Item, Integer> items = order.getItems();

	        Integer currentQuantity = items.get(item);
	        if (currentQuantity != null && currentQuantity > 1) {
	            items.put(item, currentQuantity - 1);
	        } else {
	            items.remove(item); 
	        }
	    }
	    return "redirect:/users/orders/newOrder";
	}

	@GetMapping("/newOrder/finishOrder")
	public String finishOrder() {
		// Nothing to do. We have order attibute in session, so the view can take it
		// from there
		return "finishOrder";
	}

	@PostMapping("/newOrder/finishOrder")
	public String finishOrder(@Valid @ModelAttribute("order") Order order, BindingResult bindingResult,
			SessionStatus sessionStatus) {

		if (bindingResult.hasErrors()) {
	        System.out.println("Validation errors: " + bindingResult.getAllErrors());
	        return "redirect:/users/orders";
	    }

	    System.out.println("Order before saving: " + order);

	    order.setStartDate(new Date());
	    System.out.println("Order start date set to: " + order.getStartDate());

	    orderRepository.save(order);
	    System.out.println("Order saved with reference: " + order.getReference());

	    sessionStatus.setComplete();
	    System.out.println("Session status completed.");

	    return "redirect:/users/orders";
	}
}
