package com.trawell.services;

import java.util.Collection;

import com.trawell.models.Complaint;


/**
 * IUserService
 */

public interface IComplaintService {
    Collection<Complaint> findAll();
    Complaint findOne(Long id);
    Complaint create(Complaint complaint);
    Complaint update(Complaint User);
    void delete(Long id);
    
}