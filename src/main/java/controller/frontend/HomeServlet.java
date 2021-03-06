package controller.frontend;

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


@WebServlet("")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public HomeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BookDAO bookDAO = new BookDAO();

        List<Book> listNewBooks = bookDAO.listNewBooks();
        List<Book> listBestSellingBooks = bookDAO.listBestSellingBooks();
        List<Book> listMostFavouredBooks = bookDAO.listMostFavouredBooks();


        request.setAttribute("listNewBooks", listNewBooks);
        request.setAttribute("listBestSellingBooks", listBestSellingBooks);
        request.setAttribute("listMostFavouredBooks", listMostFavouredBooks);

        String homepage = "frontend/index.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(homepage);
        dispatcher.forward(request, response);
    }

}
