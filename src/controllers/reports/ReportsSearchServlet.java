package controllers.reports;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import models.Report;
import utils.DBUtil;

/**
 * Servlet implementation class ReportsSearchServlet
 */
@WebServlet("/reports/search")
public class ReportsSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportsSearchServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        int page;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        }catch(Exception e){
            page = 1;
        }

        Employee emp = (Employee)request.getSession().getAttribute("login_employee");
        Integer admin_flag = emp.getAdmin_flag();

        Integer category = Integer.parseInt(request.getParameter("category"));

        try{
            List<Report> reports = em.createNamedQuery("getReportsSearch", Report.class)
                                     .setParameter("category", category)
                                     .setParameter("admin_flag", admin_flag)
                                     .setFirstResult(15 * (page - 1))
                                     .setMaxResults(15)
                                     .getResultList();
            long reports_count = (long)em.createNamedQuery("getReportsSearchCount", Long.class)
                                           .setParameter("category", category)
                                           .setParameter("admin_flag", admin_flag)
                                           .getSingleResult();

            em.close();

            request.setAttribute("reports", reports);
            request.setAttribute("reports_count", reports_count);
            request.setAttribute("page", page);

            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/reports/search.jsp");
            rd.forward(request, response);
        }catch(NoResultException e){}
    }

}
