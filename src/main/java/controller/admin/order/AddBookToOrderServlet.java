package controller.admin.order;

import dao.BookDAO;
import entity.Book;
import entity.BookOrder;
import entity.OrderDetail;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/admin/add_book_to_order")
public class AddBookToOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public AddBookToOrderServlet() {
        super();

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        Integer quantity = Integer.parseInt(request.getParameter("quantity"));

        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.get(bookId);

        HttpSession session = request.getSession();
        BookOrder order = (BookOrder)session.getAttribute("order");

        float subtotal = quantity * book.getPrice();

        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setBook(book);
        orderDetail.setQuantity(quantity);
        orderDetail.setSubtotal(subtotal);

        float newTotal = order.getTotal() + subtotal;
        order.setTotal(newTotal);

        order.getOrderDetails().add(orderDetail);

        request.setAttribute("book", book);
        session.setAttribute("NewBookPendingToAddToOrder", true);

        String resultPage = "add_book_result.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(resultPage);
        dispatcher.forward(request, response);

    }

}
