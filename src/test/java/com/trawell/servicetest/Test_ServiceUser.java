package com.trawell.servicetest;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.when;

import com.trawell.models.User;
import com.trawell.repositories.UserRepository;
import com.trawell.services.UserService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Optional;

import org.h2.store.Data;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class Test_ServiceUser {
    @InjectMocks
    UserService dao;
    
    @Mock
    UserRepository repo;

    @Test
    public void TC_1 () {
        User user = new User ();
        user.setName("Giuseppe");
        user.setSurname("Gesubaldo");
        user.setUsername("Vince");
        user.setMail("mariopoane@gmail.com");
        user.setPhone("3664422514");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        User created = new User ();
        created.setId(1L);
        created.setName("Giuseppe");
        created.setSurname("Gesubaldo");
        created.setUsername("Vince");
        created.setMail("mariopoane@gmail.com");
        created.setPhone("3664422514");
        created.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.save(any(User.class))).thenReturn(created);

        assertEquals(Long.valueOf(1L) ,dao.create(user).getId());

    }
    
    @Test
    public void TC_2 () {
        User user = new User ();
        user.setId(1L);
        user.setName("Giuseppe");
        user.setSurname("Gesubaldo");
        user.setUsername("Vince");
        user.setMail("mariopoane@gmail.com");
        user.setPhone("3664422514");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        User created = new User ();
        created.setId(1L);
        created.setName("Giuseppe");
        created.setSurname("Gesubaldo");
        created.setUsername("Vince");
        created.setMail("mariopoane@gmail.com");
        created.setPhone("3664422514");
        created.setPassword("92908C781853A92BE9A963319F18A3C5");

        assertEquals(null ,dao.create(user));

    }

    @Test
    public void TC_3 () {
        User updateUser = new User ();
        updateUser.setId(1L);
        updateUser.setName("Giuseppe");
        updateUser.setSurname("Gesubaldo");
        updateUser.setUsername("Vince");
        updateUser.setMail("mariopoane@gmail.com");
        updateUser.setPhone("3664422514");
        updateUser.setPassword("92908C781853A92BE9A963319F18A3C5");

        User persistedUser = new User();
        updateUser.setId(1L);
        updateUser.setName("Giuseppe");
        updateUser.setSurname("Gesubaldo");
        updateUser.setUsername("Vins");
        updateUser.setMail("mariopoane@gmail.com");
        updateUser.setPhone("3664422514");
        updateUser.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findById(Long.valueOf(1L))).thenReturn(Optional.of(persistedUser));
        when(repo.save(any(User.class))).thenReturn(updateUser);
        assertEquals(updateUser ,dao.update(updateUser));

    }

    @Test
    public void TC_4 () {
    
        User updateUser = new User ();
        updateUser.setId(1L);
        updateUser.setName("Giuseppe");
        updateUser.setSurname("Gesubaldo");
        updateUser.setUsername("Vince");
        updateUser.setMail("mariopoane@gmail.com");
        updateUser.setPhone("3664422514");
        updateUser.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findById(Long.valueOf(1L))).thenReturn(Optional.empty());

        assertEquals(null ,dao.update(updateUser));

    }

    @Test
    public void TC_5 () {
        ArrayList<User> list = new ArrayList<User>();
        User user = new User ();
        user.setId(1L);
        user.setName("Giuseppe");
        user.setSurname("Gesubaldo");
        user.setUsername("Vince");
        user.setMail("mariopoane@gmail.com");
        user.setPhone("3664422514");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");
        list.add(user);

        when(repo.findAll()).thenReturn(list);
        Collection<User> collection = dao.findAll();

        assertEquals(true, collection.size() == 1 && collection.contains(user));   
    }

    @Test
    public void TC_6(){
        User user = new User ();
        user.setId(1L);
        user.setName("Giuseppe");
        user.setSurname("Gesubaldo");
        user.setUsername("Vince");
        user.setMail("mariopoane@gmail.com");
        user.setPhone("3664422514");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findById(1L)).thenReturn(Optional.of(user));
        dao.delete(1l);
        Mockito.verify(repo, times(1)).delete(user);
    }
    @Test
    public void TC_7FindByUsername(){
        User user= new User();
        user.setId(1L);
        user.setName("Fabiano");
        user.setSurname("Russo");
        user.setUsername("tonino33");
        user.setMail("asusrock@gmail.com");
        user.setPhone("3377886669");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findByUsername("tonino33")).thenReturn(user);
        assertEquals(user ,dao.findByUsername("tonino33"));
    }

    @Test
    public void TC_8DoesUsernameExist(){
        User user= new User();
        user.setId(1L);
        user.setName("Fabiano");
        user.setSurname("Russo");
        user.setUsername("tonino33");
        user.setMail("asusrock@gmail.com");
        user.setPhone("3377886669");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findByUsername("tonino33")).thenReturn(user);
        assertEquals(true ,dao.doesUsernameExist("tonino33"));
    }

    @Test
    public void TC_9DoesEmailExist(){
        User user= new User();
        user.setId(1L);
        user.setName("Fabiano");
        user.setSurname("Russo");
        user.setUsername("tonino33");
        user.setMail("asusrock@gmail.com");
        user.setPhone("3377886669");
        user.setPassword("92908C781853A92BE9A963319F18A3C5");

        when(repo.findByMail("asusrock@gmail.com")).thenReturn(user);
        assertEquals(true ,dao.doesEmailExist("asusrock@gmail.com"));
    }
    

}