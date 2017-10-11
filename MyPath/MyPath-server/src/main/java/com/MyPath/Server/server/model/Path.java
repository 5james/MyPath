package com.MyPath.Server.server.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by james on 17/05/2017.
 */

@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Path {

    @Id
    @Column(name="PATH_ID")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;


    private String name;

    @OneToMany(mappedBy="holder")
    private List<Point> waypoints;

    public void addPoint(Point point) {
        this.waypoints.add(point);
        if (point.getHolder() != this) {
            point.setHolder(this);
        }
    }

    public List<Point> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<Point> waypoints) {
        this.waypoints = waypoints;
        waypoints.forEach(item-> {
            item.setHolder(this);
        });

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
