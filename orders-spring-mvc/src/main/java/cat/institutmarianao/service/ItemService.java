package cat.institutmarianao.service;

import java.util.List;

import cat.institutmarianao.domain.Item;

public interface ItemService {
	Item get(Long reference);
    List<Item> getAll();
}
