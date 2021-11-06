<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Construction Login</title>
</head>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="codigos.DBconnection" %>

<%


if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submit") != null){
	System.out.println("Comienza validacion datos de login");	
	
	
	boolean loginOk = false;
	
	String usr = request.getParameter("usuario");
	String pass = request.getParameter("password");
	
	String sql = "Select * From usuarios where User='" + usr + "' AND Password='" + pass + "'";
	try(Connection conn = DBconnection.createNewDBconnection()){
		System.out.println("Se abre conexion correctamente");
		System.out.println("Se buscara login para credenciales usuario=sebastian1981@gmail.com y password=123456");
		Statement stmt = conn.createStatement();
		ResultSet results = stmt.executeQuery(sql);
		

		 while (results.next()) {
			 loginOk = true;
			 System.out.println("Se encontraron datos:");
			 Integer id = Integer.valueOf(results.getString("Id"));
			 String user = String.valueOf(results.getString("User"));
			 String password = String.valueOf(results.getString("Password"));
			 String nombre = String.valueOf(results.getString("Nombre"));
			 System.out.println("id: " + id);
			 System.out.println("user: " + user);
			 System.out.println("password: " + password);
			 System.out.println("nombre: " + nombre);
		 }
	} catch (SQLException e) {
		e.printStackTrace();
	}
	finally {
		System.out.println("Fin del proceso login");
	}
	
	if (loginOk) {
		System.out.println("LOGIN OK!");
		response.sendRedirect("home.jsp");	
	}
	else {
		System.out.println("credenciales no coinciden!");
		response.sendRedirect("error.jsp");	
	}
	/*
	if (usr.equalsIgnoreCase("seba") && pass.equalsIgnoreCase("123")){
		System.out.println("LOGIN OK!");
		response.sendRedirect("home.jsp");
	}
	else {
		System.out.println("credenciales no coinciden!");
		response.sendRedirect("error.jsp");
	}
	*/
		
}

%>

<body>

<h1>Ingrese sus credenciales</h1>
<form action="" method="post">
	Usuario    : <input type="text" name="usuario" /> <br>
	Contraseña : <input type="password" name="password" /> <br>
	<button type="submit" name="submit">Ingresar</button> 
	<button type="reset" name="reset">Limpiar</button> <br>
</form>
</body>
</html>