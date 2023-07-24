
package Controlador;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author graphCuenca
 */
public class Controlador extends HttpServlet {
    String listar="vistas/instancia.jsp";
    int r;
    int id;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Controlador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acceso="";
        String action=request.getParameter("accion");
        
        if(action.equalsIgnoreCase("Museos")){
           String nom=request.getParameter("id");
           request.getSession().setAttribute("nom", nom);
           request.getRequestDispatcher("recurso.jsp").forward(request, response);
        }
        
        if(action.equalsIgnoreCase("Iglesias")){
           String nom=request.getParameter("id");
           request.getSession().setAttribute("nom", nom);
           request.getRequestDispatcher("recurso.jsp").forward(request, response);
        }
         if(action.equalsIgnoreCase("Monumentos")){
           String nom=request.getParameter("id");
           request.getSession().setAttribute("nom", nom);
           request.getRequestDispatcher("recurso.jsp").forward(request, response);
        }
        if(action.equalsIgnoreCase("Ir")){
            String nom=request.getParameter("id");
            request.getSession().setAttribute("nom", nom);
            request.getRequestDispatcher("instancia.jsp").forward(request, response); 
           
        }
        //RequestDispatcher vista=request.getRequestDispatcher(acceso);
      //  vista.forward(request, response);
    
}
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Pequeña descripción";
    }// </editor-fold>
    


}
