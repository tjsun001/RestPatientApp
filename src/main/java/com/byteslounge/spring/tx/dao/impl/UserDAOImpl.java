package com.byteslounge.spring.tx.dao.impl;


import com.byteslounge.spring.tx.dao.UserDAO;
import com.byteslounge.spring.tx.model.User;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	public void deleteUser(String socialSecurityNumber) throws Exception{
		sessionFactory.getCurrentSession().delete(socialSecurityNumber, User.class);
	}
    @CacheEvict(value="Users",allEntries=true)
    public void deleteUser(User user) throws Exception{
		sessionFactory.getCurrentSession().delete(user);
	}
    @CacheEvict(value="Users",allEntries=true)
    public void insertUser(User user) throws MySQLIntegrityConstraintViolationException {
		sessionFactory.getCurrentSession().save(user);
	}

	public User getUserById(int userId) {
		return (User) sessionFactory.getCurrentSession().get(User.class, userId);
	}
	
	@Cacheable(value="Users", key="#socialSecurityNumber")
    @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	public User getUser(String socialSecurityNumber) {
		Query query = sessionFactory.getCurrentSession().createQuery("from User where socialSecurityNumber = :socialSecurityNumber").setCacheable(true);
		query.setParameter("socialSecurityNumber", socialSecurityNumber);
        if (query.list().isEmpty()){
            return null;
        } else{
		return (User) query.list().get(0);
        }
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUsers() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		return criteria.list();
	}

}
