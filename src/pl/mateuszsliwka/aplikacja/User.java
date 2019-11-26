package pl.mateuszsliwka.aplikacja;

public class User {
	int id;
	String firstname;
	String lastname;
	String password;
	String login;

	public User(int id, String firstname, String lastname, String password, String login) {
		super();
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.password = password;
		this.login = login;
	}

	public User(String firstname, String lastname, String password, String login) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.password = password;
		this.login = login;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public User(int id, String firstname, String lastname, String password) {
		super();
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.password = password;
	}

	public User(String firstname, String lastname, String password) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.password = password;
	}

	public User() {
		super();
	}

}
