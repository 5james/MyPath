package com.MyPath.Server.server.model;

/**
 * Created by james on 17/05/2017.
 */
import javax.persistence.*;
import java.util.Date;

@Entity
public class Point {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private Double latitude;
    private Double longitude;
    private Date timestamp;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="HOLDER_ID", nullable = false)
    private Path holder;

    public Path getHolder() {
        return holder;
    }

    public void setHolder(Path holder) {
        this.holder = holder;
        if (!holder.getWaypoints().contains(this)) {
            holder.getWaypoints().add(this);
        }
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
}
