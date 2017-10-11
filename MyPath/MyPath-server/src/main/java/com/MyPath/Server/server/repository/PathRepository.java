package com.MyPath.Server.server.repository;

import com.MyPath.Server.server.model.Path;
import com.MyPath.Server.server.model.Point;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

/**
 * Created by james on 17/05/2017.
 */
@RepositoryRestResource(collectionResourceRel = "paths", path = "paths")
public interface PathRepository extends PagingAndSortingRepository<Path, Long> {

    List<Path> findByName(@Param("name") String name);
}
