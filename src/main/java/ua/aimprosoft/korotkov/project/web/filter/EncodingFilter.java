package ua.aimprosoft.korotkov.project.web.filter;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class EncodingFilter implements Filter{

    private FilterConfig filterConfig = null;

    public void destroy() {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String encoding = request.getCharacterEncoding();
        if (!"UTF-8".equalsIgnoreCase(encoding)) {
            response.setCharacterEncoding("UTF-8");
            request.setCharacterEncoding("UTF-8");
        }
        chain.doFilter(request, response);
    }

    public void init(FilterConfig fConfig) throws ServletException {
        this.filterConfig = fConfig;
    }
}

