package service;

import controller.frontend.shoppingcart.ShoppingCart;
import dao.OrderDAO;
import entity.Book;
import entity.BookOrder;
import entity.Customer;
import entity.OrderDetail;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class OrderServices {

    private OrderDAO orderDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;


    public OrderServices(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        this.orderDAO = new OrderDAO();
    }

    public void listAllOrder() throws ServletException, IOException {
        listAllOrder(null);
    }

    public void listAllOrder(String message) throws ServletException, IOException {
        List<BookOrder> listOrder = orderDAO.listAll();

        if(message != null) {
            request.setAttribute("message", message);
        }
        request.setAttribute("listOrder", listOrder);

        String orderPage = "order_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(orderPage);
        dispatcher.forward(request, response);
    }

    public void viewOrderDetailForAdmin() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("id"));

        BookOrder order = orderDAO.get(orderId);

        request.setAttribute("order", order);

        String detailPage = "order_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);

    }

    public void showCheckoutForm() throws ServletException, IOException {
        String checkoutlPage = "frontend/checkout.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(checkoutlPage);
        dispatcher.forward(request, response);
    }

    public void placeOrder() throws ServletException, IOException {
        String recipientName = request.getParameter("recipientName");
        String recipientPhone = request.getParameter("recipientPhone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zipcode = request.getParameter("zipcode");
        String country = request.getParameter("country");
        String paymentMethod = request.getParameter("paymentMethod");
        String shippingAddress = address + ", " + city + ", " + zipcode + ", " + country;


        BookOrder order = new BookOrder();
        order.setRecipientName(recipientName);
        order.setRecipientPhone(recipientPhone);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);

        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("loggedCustomer");
        order.setCustomer(customer);

        ShoppingCart shoppingCart = (ShoppingCart)session.getAttribute("cart");

        Map<Book, Integer> items = shoppingCart.getItems();
        Set<OrderDetail> orderDetails = new HashSet<>();

        Iterator<Book> iterator = items.keySet().iterator();

        while(iterator.hasNext()) {
            Book book = iterator.next();
            Integer quantity = items.get(book);
            float subtotal = quantity * book.getPrice();

            OrderDetail orderDetail = new OrderDetail();

            orderDetail.setBook(book);
            orderDetail.setBookOrder(order);
            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);

            orderDetails.add(orderDetail);
        }
        order.setOrderDetails(orderDetails);
        order.setTotal(shoppingCart.getTotalAmount());

        orderDAO.create(order);

        shoppingCart.clear();

        String message = "Thank you, your order has been received!" + " Our manager will contact you in a few hours!";
        request.setAttribute("message", message);
        String messagePage = "frontend/message.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(messagePage);
        dispatcher.forward(request, response);
    }

    public void listOrderByCustomer() throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("loggedCustomer");
        List<BookOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());

        request.setAttribute("listOrders", listOrders);

        String historyPage = "frontend/order_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
        dispatcher.forward(request, response);
    }

    public void showOrderDetailForCustomer() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("loggedCustomer");

        BookOrder order = orderDAO.get(orderId, customer.getCustomerId());

        request.setAttribute("order", order);

        String detailPage = "frontend/order_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);

    }

    public void showEditOrderForm() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("id"));


        HttpSession session = request.getSession();
        Object isPendingBook = session.getAttribute("NewBookPendingToAddToOrder");

        if(isPendingBook == null) {
            BookOrder order = orderDAO.get(orderId);
            session.setAttribute("order", order);
        } else {
            session.removeAttribute("NewBookPendingToAddToOrder");
        }

        String editPage = "order_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
        dispatcher.forward(request, response);
    }

    public void updateOrder() throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        String recipientName = request.getParameter("recipientName");
        String recipientPhone = request.getParameter("recipientPhone");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String orderStatus = request.getParameter("orderStatus");

        order.setRecipientName(recipientName);
        order.setRecipientPhone(recipientPhone);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(orderStatus);

        String[] arrayBookId = request.getParameterValues("bookId");
        String[] arrayPrice = request.getParameterValues("price");
        String[] arrayQuantity = new String[arrayBookId.length];

        for(int i =1; i<= arrayQuantity.length; i++) {
            arrayQuantity[i-1] = request.getParameter("quantity" + 1);
        }

        Set<OrderDetail> orderDetails = order.getOrderDetails();
        orderDetails.clear();

        float totalAmount = 0.0f;

        for(int i =0; i < arrayBookId.length; i++) {
            int bookId = Integer.parseInt(arrayBookId[i]);
            int quantity = Integer.parseInt(arrayQuantity[i]);
            float price = Float.parseFloat(arrayPrice[i]);

            float subtotal = price * quantity;

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setBook(new Book(bookId));

            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);
            orderDetail.setBookOrder(order);

            orderDetails.add(orderDetail);

            totalAmount += subtotal;

        }

        order.setTotal(totalAmount);
        orderDAO.update(order);

        String message = "The order " + order.getOrderId() + " has been updated successfully!";

        listAllOrder(message);

    }

    public void deleteOrder() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("id"));

        orderDAO.delete(orderId);
        String message = "The order " + orderId + " has been deleted successfully!";
        listAllOrder(message);

    }

}
