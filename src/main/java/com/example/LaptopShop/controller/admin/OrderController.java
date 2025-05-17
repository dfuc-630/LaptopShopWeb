package com.example.LaptopShop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.domain.Product;
import com.example.LaptopShop.domain.dto.OrderDTO;
import com.example.LaptopShop.repository.OrderDTORepository;

import jakarta.transaction.Transactional;

@Controller
public class OrderController {
    @Autowired
    private OrderDTORepository orderDTORepository;

    @GetMapping("/admin/order")
    public String getDashBoard(Model model) {
        List<OrderDTO> orders = orderDTORepository.findAll();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(@PathVariable("id") long id, Model model) {
        OrderDTO order = orderDTORepository.getById(id);
        model.addAttribute("order", order);
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String delelteOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new OrderDTO());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    @Transactional
    public String postDeleteOrder(Model model, @ModelAttribute("newOrder") OrderDTO orderDTO) {
        this.orderDTORepository.deleteOrderDTOById(orderDTO.getId());
        return "redirect:/admin/order";
    }
}
