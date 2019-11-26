<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pl.mateuszsliwka.aplikacja.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Studenckie Mieszkanie v0.1</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet" />
<link rel="shortcut icon" href="/FlatMates/img/rental.ico"
	type="image/x-icon" />
</head>
<div id="wrap">
	<body>
		<%
			if (session.getAttribute("logged-in") != null)
				response.sendRedirect("costs.jsp");
		String action = request.getParameter("action");
		if("logout".equals(action)){
			session.invalidate();
		
		}
		%>
		<nav
			class="navbar navbar-expand-lg navbar-light bg-light static-top mb-5 shadow">
			<div class="container">
				<a class="navbar-brand" href="#">Studenckie Mieszkanie <span
					class="badge badge-secondary">v0.1</span></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarResponsive" aria-controls="navbarResponsive"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item active"><a class="nav-link">Logowanie
								<span class="sr-only">(current)</span>
						</a></li>

					</ul>
				</div>
			</div>
		</nav>
		<div class="container">
			<div class="card border-0 shadow my-5">
				<div class="card-body p-5">
					<h1 class="font-weight-light">Logowanie</h1>
					<hr />
					<%
						if (null != request.getAttribute("errorMessage")) {
					%>
					<div class="alert alert-danger" role="alert">
						<%=request.getAttribute("errorMessage")%>
					</div>
					<%
						} else if ("true".equals(request.getParameter("logout"))) {
					%>
					<div class="alert alert-warning" role="alert">Wylogowano
						poprawnie!</div>
					}		%>


					<form method="post" action="LoginCheck">
						<div class="form-group">
							<label for="login">Nazwa użytkownika</label> <input type="text"
								class="form-control" id="login" name="login"
								placeholder="Podaj login"> <small id="loginHelp"
								class="form-text text-muted">Login to pierwsza literia
								imienia i nazwisko bez polskich znaków <i>(np. msliwka)</i>.
							</small>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Hasło</label> <input
								type="password" class="form-control" id="password"
								name="password" placeholder="Podaj hasło"> <small
								id="passwordHelp" class="form-text text-muted">Podaj
								hasło, które otrzymałeś od zarządcy mieszkania.</small>
						</div>
						<button type="submit" value="login" class="btn btn-primary">Zaloguj</button>
					</form>
				</div>
			</div>
		</div>
	</body>
</div>
<footer class="page-footer font-small blue">

	<div class="footer-copyright text-center py-3">
		© 2019 Copyright: <a href="http://mateuszsliwka.pl" target="_blank">
			MateuszSliwka.pl</a>
	</div>
</footer>
</html>