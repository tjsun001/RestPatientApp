package com.byteslounge.spring.tx.user.impl;

import com.byteslounge.spring.tx.dao.UserDAO;
import com.byteslounge.spring.tx.model.User;
import com.byteslounge.spring.tx.user.UserManager;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserManagerImpl implements UserManager {

	@Autowired
	private UserDAO userDAO;
	
	@Transactional
	public void insertUser(User user) throws MySQLIntegrityConstraintViolationException {
		userDAO.insertUser(user);
	}

    @Transactional
	public void deleteUser(String socialSecurityNumber)  throws Exception {
		userDAO.deleteUser(socialSecurityNumber);
	}
@Transactional
	public void deleteUser(User user)  throws Exception {
		userDAO.deleteUser(user);
	}

	@Transactional
	public User getUserById(int userId) {
		return userDAO.getUserById(userId);
	}
	
	@Transactional
	public User getUser(String ssn) {
		return userDAO.getUser(ssn);
	}

	@Transactional
	public List<User> getUsers() {
		return userDAO.getUsers();
	}

}
