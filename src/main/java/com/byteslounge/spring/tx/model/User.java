package com.byteslounge.spring.tx.model;

import javax.persistence.*;

@Entity
@Table(name="User")
public class User {

//	@Id
//	@GeneratedValue(strategy = GenerationType.AUTO)
//	@Column(name="ID", nullable = false)
//	private int ID;
	
//	@Column(name="USERNAME", nullable = false)
//	private String username;
	
	@Column(name="firstName", nullable = false)
    private String firstName;

	@Column(name="lastName", nullable = false)
    private String lastName;

	@Column(name="dateOfBirth", nullable = false)
    private String dateOfBirth;

    @Id
	@Column(name="socialSecurityNumber", nullable = false)
    private String socialSecurityNumber;

	@Column(name="countryOfBirth", nullable = false)
    private String countryOfBirth;

	
//	public int getId() {
//		return ID;
//	}
	
//	public void setId(int id) {
//		this.ID = id;
//	}

//	public String getUsername() {
//		return username;
//	}
	
//	public void setUsername(String username) {
//		this.username = username;
//	}
	
	public String getFirstName() {
		return firstName;
	}
	
	public void setFirstName(String name) {
		this.firstName = name;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String name) {
		this.lastName = name;
	}

    public String getDateOfBirth() {
		return dateOfBirth;
	}

    public void setDateOfBirth(String name) {
        this.dateOfBirth = name;
    }

    public String getSocialSecurityNumber() {
        return socialSecurityNumber;
    }

	public void setSocialSecurityNumber(String ssn) {
		this.socialSecurityNumber = ssn;
	}

    public String getCountryOfBirth() {
        return countryOfBirth;
    }

	public void setCountryOfBirth(String countryOfBirth) {
		this.countryOfBirth = countryOfBirth;
	}
	
}
