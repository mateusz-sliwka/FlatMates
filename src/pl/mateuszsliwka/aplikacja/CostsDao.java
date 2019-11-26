package pl.mateuszsliwka.aplikacja;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class CostsDao {
	private static SessionFactory factory;

	public CostsDao() {
		try {
			factory = new Configuration().configure().buildSessionFactory();
		} catch (Throwable ex) {
			System.err.println("Failed to create sessionFactory object." + ex);
			throw new ExceptionInInitializerError(ex);
		}
	}

	public void update(int id, Cost cost) {
		Session session = factory.openSession();
		Transaction tx = null;
		tx = session.beginTransaction();
		Cost cost2 = selectOne(id);
		if (cost2 != null) {
			cost2.setName(cost.getName());
			cost2.setPrice(cost.getPrice());
			session.update(cost2);
			tx.commit();
		}
	}

	public Cost selectOne(int id) {
		Session session = factory.openSession();
		Transaction tx = null;
	
		Cost cost = null;
		try {
			tx = session.beginTransaction();
			cost = (Cost) session.get(Cost.class, id);
			tx.commit();

		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cost;
	}

	public void remove(int id) {
		Session session = factory.openSession();
		Transaction tx = null;
		tx = session.beginTransaction();
		Cost cost2 = selectOne(id);
		if (cost2 != null) {
			session.remove(cost2);
			tx.commit();
		}

	}

	public void create(Cost cost) {
		Session session = factory.openSession();
		Transaction tx = null;
		tx = session.beginTransaction();
		session.save(cost);
		tx.commit();
	}

	public double countFlatmateCosts(int flatmate_id) {

		Session session = factory.openSession();
		Transaction tx = null;

		double allcosts = 0;
		try {
			tx = session.beginTransaction();
			List<Cost> costs = session.createQuery("from Cost where flatmate_id=:flatmate_id")
					.setParameter("flatmate_id", flatmate_id).list();
			for (Cost c : costs)
				allcosts += c.getPrice();

		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return allcosts;
	}

	public double countCosts() {
		Session session = factory.openSession();
		Transaction tx = null;
		double allcosts = 0;
		try {
			tx = session.beginTransaction();
			List<Cost> costs = session.createQuery("from Cost").list();
			for (Cost c : costs)
				allcosts += c.getPrice();

		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return allcosts;

	}

	public List<Cost> selectAll() {

		Session session = factory.openSession();
		Transaction tx = null;
		List<Cost> costs = null;

		double allcosts = 0;
		try {
			tx = session.beginTransaction();
			costs = session.createQuery("from Cost").list();

		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return costs;
	}

	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
