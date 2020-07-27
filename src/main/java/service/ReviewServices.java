package service;

import dao.BookDAO;
import dao.ReviewDAO;
import entity.Book;
import entity.Customer;
import entity.Review;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ReviewServices {

    private ReviewDAO reviewDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;


    public ReviewServices(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        reviewDAO = new ReviewDAO();
    }
    public void listAllReview() throws ServletException, IOException {
        listAllReview(null);
    }

    public void listAllReview(String message) throws ServletException, IOException {
        List<Review> listReviews = reviewDAO.listAll();
        request.setAttribute("listReviews", listReviews);
        request.setAttribute("message", message);

        String reviewPage = "review_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(reviewPage);
        dispatcher.forward(request, response);
    }

    public void editReview() throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Review review = reviewDAO.get(reviewId);

        request.setAttribute("review", review);

        String editPage = "review_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
        dispatcher.forward(request, response);
    }

    public void updateReview() throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        String comment = request.getParameter("comment");
        String headline = request.getParameter("headline");

        Review review = reviewDAO.get(reviewId);

        review.setComment(comment);
        review.setHeadline(headline);

        reviewDAO.update(review);

        String message="The review has been updated successfully!";
        listAllReview(message);
    }

    public void deleteReview() throws ServletException, IOException {
        Integer reviewId = Integer.parseInt(request.getParameter("id"));
        reviewDAO.delete(reviewId);

        String message="The review has been deleted successfully!";
        listAllReview(message);

    }
    public void showReviewForm() throws ServletException, IOException {

        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.get(bookId);

        HttpSession session = request.getSession();
        session.setAttribute("book", book);
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        Review existReview = reviewDAO.findByCustomerAndBook(customer.getCustomerId(), bookId);

        String targetPage = "frontend/review_form.jsp";

        if(existReview != null) {
            request.setAttribute("review",existReview);
            targetPage = "frontend/review_info.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(targetPage);
        dispatcher.forward(request, response);

    }
    public void submitReview() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        Integer rating = Integer.parseInt(request.getParameter("rating"));
        String headline = request.getParameter("headline");
        String comment = request.getParameter("comment");

        Review newReview = new Review();
        newReview.setHeadline(headline);
        newReview.setComment(comment);
        newReview.setRating(rating);

        Book book = new Book();
        book.setBookId(bookId);
        newReview.setBook(book);

        Customer customer = (Customer)request.getSession().getAttribute("loggedCustomer");
        newReview.setCustomer(customer);

        reviewDAO.create(newReview);

        String messagePage = "frontend/review_done.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(messagePage);
        dispatcher.forward(request, response);
    }
}