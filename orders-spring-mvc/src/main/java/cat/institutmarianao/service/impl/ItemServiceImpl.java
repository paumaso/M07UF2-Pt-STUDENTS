package cat.institutmarianao.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cat.institutmarianao.domain.Item;
import cat.institutmarianao.repository.ItemRepository;
import cat.institutmarianao.service.ItemService;

@Service
public class ItemServiceImpl implements ItemService{
	@Autowired
	private ItemRepository itemRepository;
	
	@Override
    public Item get(Long reference) {
        return itemRepository.get(reference);
    }

    @Override
    public List<Item> getAll() {
        return itemRepository.getAll();
    }
}
