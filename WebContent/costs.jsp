<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pl.mateuszsliwka.aplikacja.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Studenckie Mieszkanie v0.1</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet" />
<link rel="shortcut icon" href="/FlatMates//img/rental.ico"
	type="image/x-icon" />
</head>
<body>
	<%
		int flatmate_id = -1;
		CostsDao dao = new CostsDao();
		UsersDao usersDao = new UsersDao();
		boolean redirection = false;
		String destination = null;
		if (session.getAttribute("login") == null) {
			redirection = true;
			destination = "index.jsp";
		} else
			flatmate_id = usersDao.getIdByLogin((String) session.getAttribute("login"));
		System.out.println(flatmate_id);
		if (flatmate_id == -1) {
			redirection = true;
			destination = "index.jsp";
		} else
			session.setAttribute("logged-in", "true");
		System.out.println(redirection);
		if (redirection) {
			RequestDispatcher dd = request.getRequestDispatcher(destination);
			dd.forward(request, response);
		}
	%>
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light static-top mb-5 shadow">
		<div class="container">
			<a class="navbar-brand" href="costs.jsp">Studenckie Mieszkanie <span
				class="badge badge-secondary">v0.1</span></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link"
						href="costs.jsp?action=logout">Wyloguj się <span
							class="sr-only">(current)</span>
					</a></li>

				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="card border-0 shadow my-5">
			<div class="card-body p-5">
				<h1 class="font-weight-light">Wydatki na mieszkanie</h1>
				</hr>
				<%
					String action = request.getParameter("action");
					String name = request.getParameter("name");
					String price = request.getParameter("price");
					String id = request.getParameter("id");
					User current_flatmate = usersDao.selectOne(flatmate_id);
					Cost app = new Cost();
					double yourcosts = dao.countFlatmateCosts(flatmate_id);
					double allcosts = dao.countCosts();
					if ("logout".equals(action)) {
						session.invalidate();

						response.sendRedirect("index.jsp?logout=true");
					}
					if ("create".equals(action)) {

						try {
							System.out.println(Double.parseDouble(price));
							double price2 = Double.parseDouble(price);

							app = new Cost(name, price2, flatmate_id);
							dao.create(app);
							app = new Cost();
							yourcosts = dao.countFlatmateCosts(flatmate_id);
							allcosts = dao.countCosts();
							request.setAttribute("infoBox", "Dodano koszt!");
						} catch (NumberFormatException e) {
							request.setAttribute("infoBox", "Podano nieprawidłową nazwe lub cene!");
						}

					} else if ("remove".equals(action)) {
						dao.remove(Integer.parseInt(id));
						yourcosts = dao.countFlatmateCosts(flatmate_id);
						request.setAttribute("infoBox", "Usunięto koszt!");
						allcosts = dao.countCosts();
					} else if ("select".equals(action)) {
						app = dao.selectOne(Integer.parseInt(id));
						yourcosts = dao.countFlatmateCosts(flatmate_id);
						allcosts = dao.countCosts();

					} else if ("update".equals(action)) {
						try {
							double price2 = Double.parseDouble(price);
							app = new Cost(name, price2, flatmate_id);
							dao.update(Integer.parseInt(id), app);
							app = new Cost();
							request.setAttribute("infoBox", "Zaktualizowano koszt!");
							yourcosts = dao.countFlatmateCosts(flatmate_id);
							allcosts = dao.countCosts();
						} catch (NumberFormatException e) {
							request.setAttribute("infoBox", "Podano nieprawidłową cenę!");
						}

					}
					List<Cost> costs = dao.selectAll();
				%>
				<hr>
				Cześć <strong><%=current_flatmate.getFirstname()%></strong>!<br>
				Twoje wydatki na mieszkanie to: <strong><%=yourcosts%>zł</strong><br>
				Stanowi to: <strong><%=Math.round(yourcosts / allcosts * 100)%>%</strong>
				wszystkich kosztów (<%=allcosts%>zł) <br> <br>
				<%
					if (null != request.getAttribute("infoBox")) {
				%>
				<div class="alert alert-warning" role="alert">
					<%=request.getAttribute("infoBox")%>
					<%
						request.setAttribute("infoBox", null);
					%>
				</div>
				<%
					}
				%>
				<h3>Tabela wydatków</h3>
				<form action="costs.jsp">
					<input type="hidden" name="id" value="<%=app.getId()%>" />
					<table class="table">

						<tr>
							<td><input name="name" class="form-control"
								placeholder="Nazwa wydatku" value="<%=app.getName()%>" /></td>
							<%
								if (app.getPrice() == 0.0) {
							%>
							<td><input name="price" class="form-control"
								placeholder="<%=app.getPrice()%>" /></td>
							<%
								} else {
							%>
							<td><input name="price" class="form-control"
								value="<%=app.getPrice()%>" /></td>
							<%
								}
							%>
							<td></td>
							<td><button class="btn btn-success" name="action"
									value="create">Dodaj</button></td>
							<td><button class="btn btn-primary" name="action"
									value="update">Aktualizuj</button></td>
						</tr>
						<%
							double razem = 0;
							for (Cost app2 : costs) {
								razem += app2.getPrice();
						%>
						<tr>
							<td><%=app2.getName()%></td>
							<td><%=app2.getPrice()%>zł</td>
							<td><%=usersDao.selectOne(app2.getFlatmate_id()).getFirstname()%></td>
							<td>
								<%
									if (app2.getFlatmate_id() == current_flatmate.getId()) {
								%><a class="btn btn-danger"
								href="costs.jsp?action=remove&id=<%=app2.getId()%>">Usuń</a> <%
 	} else {
 %><a class="btn btn-danger disabled"
								href="costs.jsp?action=remove&id=<%=app2.getId()%>">Usuń</a> <%
 	}
 %>
							</td>



							<td>
								<%
									if (app2.getFlatmate_id() == current_flatmate.getId()) {
								%><a class="btn btn-warning"
								href="costs.jsp?action=select&id=<%=app2.getId()%>">Wybierz</a>
								<%
									} else {
								%><a class="btn btn-warning disabled"
								href="costs.jsp?action=select&id=<%=app2.getId()%>">Wybierz</a>
								<%
									}
								%>
							</td>

						</tr>
						<%
							}
						%>
						<tr>
							<td><strong>Razem</strong></td>
							<td><strong><%=razem%>zł</strong></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>

<footer class="page-footer font-small blue">

	<div class="footer-copyright text-center py-3">
		© 2019 Copyright: <a href="http://mateuszsliwka.pl" target="_blank">
			MateuszSliwka.pl</a>
	</div>
</footer>
</html>