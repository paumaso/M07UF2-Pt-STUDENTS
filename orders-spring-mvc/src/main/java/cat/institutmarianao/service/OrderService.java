package cat.institutmarianao.service;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.domain.User;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface OrderService {
	Order get(Long reference);
	List<Order> getAll();
	List<Order> findByUser(User client);
	void save(Order order);
	Order update(Order order);
}
