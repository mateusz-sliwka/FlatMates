package pl.mateuszsliwka.aplikacja;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class UsersDao {
	private static SessionFactory factory;

	public UsersDao() {
		try {
			factory = new Configuration().configure().buildSessionFactory();
		} catch (Throwable ex) {
			System.err.println("Failed to create sessionFactory object." + ex);
			throw new ExceptionInInitializerError(ex);
		}
	}

	public User selectOne(int id) {
		Session session = factory.openSession();
		Transaction tx = null;
		User user = null;

		try {
			tx = session.beginTransaction();
			user = (User) session.get(User.class, id);
			tx.commit();

		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return user;
	}

	public boolean loginUser(String login, String password) {
		Session session = factory.openSession();
		Transaction tx = null;
		User user = null;
		try {
			tx = session.beginTransaction();
			List<User> users = session.createQuery("from User where login=:login and password=:password")
					.setParameter("login", login).setParameter("password", password).list();
			if (users.size() == 1)
				return true;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}

	public int getIdByLogin(String login) {
		Session session = factory.openSession();
		Transaction tx = null;
		User user = null;
		try {
			tx = session.beginTransaction();
			List<Integer> users = session.createQuery("Select id from User where login=:login")
					.setParameter("login", login).list();
			if (users.size() == 1)
				return users.get(0);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return -1;
	}
}
