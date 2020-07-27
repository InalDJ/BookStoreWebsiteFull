package controller.admin.order;

import dao.BookDAO;
import entity.Book;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/add_book_form")
public class ShowAddBookFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public ShowAddBookFormServlet() {
        super();

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        List<Book> listBook = bookDAO.listAll();

        request.setAttribute("listBook", listBook);

        String formPage = "add_book_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(formPage);
        dispatcher.forward(request, response);
    }

}
