package com.MyPath.Server.server.repository;

/**
 * Created by james on 17/05/2017.
 */

import java.util.List;

import com.MyPath.Server.server.model.Point;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "points", path = "points")
public interface PointRepository extends PagingAndSortingRepository<Point, Long> {

    List<Point> findByLongitudeBetweenAndLatitudeBetween(@Param("minLongitude") Double minLongitude,
                                                         @Param("maxLongitude") Double maxLongitude,
                                                         @Param("minLatitude") Double minLatitude,
                                                         @Param("maxLatitude") Double maxLatitude);

}
