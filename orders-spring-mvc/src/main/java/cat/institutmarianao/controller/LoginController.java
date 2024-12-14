package cat.institutmarianao.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

// TODO - Configure Spring element and add mappings
@Controller
@RequestMapping("/orders-spring-mvc")
public class LoginController {
	@GetMapping
	public String check(HttpServletRequest request) throws ServletException, IOException {
		if (request.isUserInRole("ROLE_ADMIN")) {
			return "redirect:/admin/orders";
		}
		return "redirect:/users/orders";
	}

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@GetMapping("/loginfailed")
	public String loginFailed(Model model) {
		model.addAttribute("error", "true");
		return "login";
	}
}
