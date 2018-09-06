package com.codetutr.controller;

import com.byteslounge.spring.tx.model.User;
import com.byteslounge.spring.tx.user.UserManager;
import com.codetutr.domain.Person;
import com.codetutr.service.PersonService;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import org.apache.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataIntegrityViolationException;
//import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Controller
@Transactional
@RequestMapping("api")
public class PersonController {

    static final Logger log = Logger.getLogger(PersonController.class);
	PersonService personService;

	@Autowired
	public PersonController(PersonService personService) {
		this.personService = personService;
	}

    @RequestMapping("person/user/{ssn}")
    @ResponseBody
    @Cacheable(value="Patients", key="#ssn")
    public User getPatient(@PathVariable String ssn) {
        log.debug("debug message");
        log.info("info message");
        log.warn("warn message");
        log.error("error message");
        log.fatal("fatal message");
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        UserManager userManager = (UserManager) ctx.getBean("userManagerImpl");

        User user = new User();
        user.setSocialSecurityNumber(ssn);

        user = userManager.getUser(ssn);
        if (user == null){
            System.out.println("did not find home.jsp = " + ssn);
            user = new User();
            user.setSocialSecurityNumber(ssn);

            return user;
        }
        return user;
    }

    @CacheEvict(value="Patients",allEntries=true)
    @RequestMapping(value="delete")
    @ResponseBody
    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public String deletePatient(User user) {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        UserManager userManager = (UserManager) ctx.getBean("userManagerImpl");

        try{
            userManager.deleteUser(user);
        }
        catch(Exception e){
            e.printStackTrace();
            return user.getSocialSecurityNumber();

        }

        System.out.println("User deleted!");

        return "Deleted patient: " + user.getFirstName() + " " + user.getLastName() + " " +user.getSocialSecurityNumber();
    }


    @RequestMapping(value="user", method=RequestMethod.POST)
    @ResponseBody
    public String postPatient(User user)  {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        UserManager userManager = (UserManager) ctx.getBean("userManagerImpl");

        try{
        userManager.insertUser(user);
        }
        
        catch (DataIntegrityViolationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            return "Patient Already Exists: " + user.getFirstName() + " " + user.getLastName() + " " + user.getSocialSecurityNumber();
        }
        catch (MySQLIntegrityConstraintViolationException e) {
              e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            return "Patient Already Exists: " + user.getFirstName() + " " + user.getLastName() + " " + user.getSocialSecurityNumber();
        }
         catch (ConstraintViolationException e) {
             e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
             return "Patient Already Exists: " + user.getFirstName() + " " + user.getLastName() + " " + user.getSocialSecurityNumber();
         }
        catch (Exception e) {
            return "Patient Already Exists: " + user.getFirstName() + " " + user.getLastName();
        }

        System.out.println("User inserted!");

        return "Saved patient: " + user.getFirstName() + " " + user.getLastName();
    }

    @CacheEvict(value="Patients",allEntries=true)
    @RequestMapping(value="person", method=RequestMethod.POST)
    @ResponseBody
    public String savePerson(Person person) {
        personService.save(person);
        return "Saved person: " + person.toString();
    }

    @RequestMapping("person/random")
    @ResponseBody
    public Person randomPerson() {
        return personService.getRandom();
    }

    @RequestMapping("person/{id}")
    @ResponseBody
    public Person getById(@PathVariable Long id) {
        return personService.getById(id);
    }

    @RequestMapping(value="person", params="id")
    @ResponseBody
    public Person getByIdFromParam(@RequestParam("id") Long id) {
        return personService.getById(id);
    }
}
