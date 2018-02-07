package com.alpha.services;

import com.alpha.bd.ManagerInventarios;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LlamaAutoMerma extends HttpServlet {
	private ManagerInventarios mi;
	private static boolean iniciado = false;

	public void init(){
		if (iniciado) {
			return;
		}
		try{
			iniciado = true;
			System.out.println("Verificando Automerma....");
			mi = new ManagerInventarios();
			int resultado = mi.autoMerma();
			String codigoFinal = "Auto Merma realizada Satisfactoriamente..";
			if(resultado == 1){
				codigoFinal = "No es necesaria la automerma para esta fecha";
			}
			else if(resultado == 2){
				codigoFinal = "Fallo el proceso de automerma...";
			}
			System.out.println(codigoFinal);
		}
		catch (Exception e) {
			//System.out.println("Error al iniciar Servlet de inicio de SWCash");
			e.printStackTrace();
		}
	}

	public void destroy() {
		try{
		}
		catch(Exception q){
			q.printStackTrace();
		}
	}

  public  void doGet(HttpServletRequest req, HttpServletResponse res) {
  }

}