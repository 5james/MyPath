//
//  GMSMutablePathWithTimestamp.swift
//  MyPath
//
//  Created by James on 16/05/2017.
//  Copyright © 2017 James. All rights reserved.
//

import GoogleMaps
import GooglePlaces

class GMSMutablePathWithTimestamps: GMSMutablePath {
    var timestamps: [Date] = []
    
    func add(_ coord: CLLocationCoordinate2D, timestamp: Date) {
        super.add(coord)
        timestamps.append(timestamp)
    }
    
    override func removeAllCoordinates() {
        super.removeAllCoordinates()
        timestamps.removeAll()
    }
}
