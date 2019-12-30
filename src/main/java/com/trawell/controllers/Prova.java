package com.trawell.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.trawell.models.Carsharing;
import com.trawell.models.User;
import com.trawell.repositories.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @author Alfieri Davide
 * 
 * carsharing:andranno mappate tutte le funzionalità relative al carsharing
 */

@Controller
public class Prova {

    @Autowired
    UserRepository repo;

    @GetMapping("/prova")
    public String prova(HttpSession session) {
        User user = repo.findByUsername("prova");
        System.out.println(user.getUserAdds().size());
        return "pages/carsharing/listcarsharing";
    }
}