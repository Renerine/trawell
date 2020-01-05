package com.trawell.repositories;

import java.util.Collection;

import com.trawell.models.Post;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * @author Russomamdo Umberto
 * PostRepository
 */
public interface PostRepository extends CrudRepository<Post, Long> {
    
    @Query("select * from post p where p.id_group = NULL")
    Collection<Post> findByIdGroupIsNull();
    
}