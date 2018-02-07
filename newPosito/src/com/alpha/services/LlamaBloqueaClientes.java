package com.alpha.services;

import com.alpha.bd.BloqueaClientes;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LlamaBloqueaClientes extends HttpServlet {
	private BloqueaClientes bc;
	public boolean myStop = false;
	private static boolean iniciado = false;

	public void init(){
		if (iniciado) {
			return;
		}
		try{
			System.out.println("Depurando Clientes El Retoñito....");
			iniciado = true;
			bc = new BloqueaClientes();
			bc.depura();
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

