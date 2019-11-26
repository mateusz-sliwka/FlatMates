package pl.mateuszsliwka.aplikacja;

public class Cost {
	private int id = -1;
	private String name = "";
	private double price = 0.0;
	private int flatmate_id = -1;

	public Cost(String name, double price, int flatmate_id) {
		super();
		this.name = name;
		this.price = price;
		this.flatmate_id = flatmate_id;
	}

	public Cost(int id, String name, double price, int flatmate_id) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.flatmate_id = flatmate_id;
	}

	public int getFlatmate_id() {
		return flatmate_id;
	}

	public void setFlatmate_id(int flatmate_id) {
		this.flatmate_id = flatmate_id;
	}

	public Cost() {
		super();
	}

	public Cost(String name, double price) {
		super();
		this.name = name;
		this.price = price;
	}

	public Cost(int id, String name, double price) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

}
