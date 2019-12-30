package com.trawell.controllers;

import javax.servlet.http.HttpSession;

import com.trawell.models.Agency;
import com.trawell.utilities.Encoder;
import com.trawell.models.User;
import com.trawell.services.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


/**
 * @author Milione Vincent
 * @author Lamberti Vincenzo
 * RestUsersController andranno mappate tutte le funzionalità relative all'utente per la comunicazione REST
 *
 */
@RestController
@RequestMapping(value = "/api")
public class RestUsersController {

    @Autowired
    private UserService userService;

    /**
     * @author Milione Vincent
     * The method sets unchangeable data into the new users data
     * @param newUser contains user's new data
     * @param oldUser contains user's old data
     */
    public void setBean (User newUser, User oldUser) {
        newUser.setId(oldUser.getId());
        newUser.setMail(oldUser.getMail());
        newUser.setIsAdmin(oldUser.getIsAdmin());
        newUser.setBanned(oldUser.getBanned());
        newUser.setIsBanned(oldUser.getIsBanned());
        newUser.setProfilePhoto(oldUser.getProfilePhoto());
        oldUser.getList().size();
        newUser.setList(oldUser.getList());
        newUser.setBio(newUser.getBio() == null ? oldUser.getBio() : newUser.getBio());
    }

    /**
     * @author Lamberti Vincenzo
     * executes an update on all of a user's data
     * @param id user's id on the database
     * @param user new user object containing all the new data
     * @return a JSON object with Http Status 200 if update was successful, 500 otherwise
     */
    @RequestMapping(value = "/users/{id}", method = RequestMethod.POST, consumes = MediaType.ALL_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> updateUser(@PathVariable("id") Long id, @ModelAttribute User user, @RequestParam (name = "oldpassword", required = true) String oldPassword, HttpSession session) {

        User u = (User) session.getAttribute("user");

        User updatedUser = null;
        if (user != null && id == u.getId()) {
            
            Encoder encode = new Encoder((u.getUsername()));
            oldPassword = encode.encoding(oldPassword, u.getUsername().length());

            if (oldPassword.equals(u.getPassword())) {

                user.setPassword(encode.encoding(user.getPassword(), user.getUsername().length()));
                setBean(user, u);
                updatedUser = userService.update(user);
            }
            else
                return new ResponseEntity<User>(HttpStatus.NOT_ACCEPTABLE);
        }
        if(updatedUser == null) {
            return new ResponseEntity<User>(HttpStatus.INTERNAL_SERVER_ERROR);
         }else {
             session.setAttribute("user", updatedUser);
             return new ResponseEntity<User>(updatedUser, HttpStatus.OK);
         }   
    }

    /**
     * @author Lamberti Vincenzo
     * executes an update on all of a user's data
     * @param id user's id on the database
     * @param user new agnecy user object containing all the new data
     * @return a JSON object with Http Status 200 if update was successful, , 500 otherwise
     */
    @RequestMapping(value = "/users/agency/{id}", method = RequestMethod.POST, consumes = MediaType.ALL_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> updateUser(@PathVariable("id") Long id, @ModelAttribute Agency user, @RequestParam (name = "oldpassword", required = true) String oldPassword, HttpSession session) {

        Agency u = (Agency) session.getAttribute("user");

        User updatedUser = null;
        if (user != null && id == u.getId()) {
            
            Encoder encode = new Encoder((u.getUsername()));
            oldPassword = new Encoder(u.getUsername()).encoding(oldPassword, u.getUsername().length());
            
            if (oldPassword.equals(u.getPassword())) {
                user.setPassword(encode.encoding(user.getPassword(), user.getUsername().length()));
                setBean(user, u);
                updatedUser = userService.update(user);
            }
            else
                return new ResponseEntity<User>(HttpStatus.NOT_ACCEPTABLE);
        }
        if(updatedUser == null) {
            return new ResponseEntity<User>(HttpStatus.INTERNAL_SERVER_ERROR);
         }else {
             session.setAttribute("user", updatedUser);
             return new ResponseEntity<User>(updatedUser, HttpStatus.OK);
         }  
    }
}