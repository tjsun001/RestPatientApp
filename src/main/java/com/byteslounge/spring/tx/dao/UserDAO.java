package com.byteslounge.spring.tx.dao;

import com.byteslounge.spring.tx.model.User;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

import java.util.List;

public interface UserDAO {

	void insertUser(User user) throws MySQLIntegrityConstraintViolationException;

    void deleteUser(String socialSecurityNumber) throws Exception;

    void deleteUser(User user) throws Exception;

	User getUserById(int userId);
	
	User getUser(String socialSecurityNumber);
	
	List<User> getUsers();
}
