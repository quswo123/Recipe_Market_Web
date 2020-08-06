package com.recipe.control;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.recipe.exception.FindException;
import com.recipe.service.RecipeService;
import com.recipe.vo.RecipeInfo;

public class RecipeInfoController implements Controller{
	private static RecipeInfoController instance;
	private static final long serialVersionUID = 1L;
       
    public RecipeInfoController() {}
    
    public static RecipeInfoController getInstance() {
    	if(instance == null) instance = new RecipeInfoController();
    	return instance;
    }

	public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int recipeCode = Integer.parseInt(request.getParameter("recipeCode"));
		
		RecipeService service = new RecipeService();
		try {
			RecipeInfo ri = service.findByCode(recipeCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(ri.getRecipeProcess())));
			String ingNprocess = "";
			String readVal;
			while((readVal = br.readLine()) != null) ingNprocess += readVal + "\n";
			br.close();
			
			String[] splitted = ingNprocess.split("\n");
			String ingredients = splitted[0];
			String[] process = Arrays.copyOfRange(splitted, 2, splitted.length);

			request.setAttribute("recipeInfo", ri);
			request.setAttribute("ingredients", ingredients);
			request.setAttribute("process", process);
			
			return "/recipeInfo.jsp";
//			RequestDispatcher rd = request.getRequestDispatcher("/recipeInfo.jsp");
//			rd.forward(request, response);
		} catch (FindException e) {
			e.printStackTrace();
			return "/fail.jsp";
//			RequestDispatcher rd = request.getRequestDispatcher("/fail.jsp");
//			rd.forward(request, response);
		}
	}

}