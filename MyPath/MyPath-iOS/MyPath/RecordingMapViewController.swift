//
//  ViewController.swift
//  MyPath
//
//  Created by James on 14/05/2017.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class RecordingMapViewController: UIViewController {
    
    // Buttons of Top Panel Control
    let startButton = UIButton()
    let stopButton = UIButton()
    let restartButton = UIButton()
    
    // Map
    var mapView: GMSMapView!
    
    // Location Manager
    var locationManager = CLLocationManager()
    
    // Settings to camera
    var zoomLevel: Float = 15.0
    var viewAngle: Double = 0.0
    
    // Path tracked by user
    let path = GMSMutablePathWithTimestamps()
    var polyline = GMSPolyline()
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 52.218994, longitude: 21.011824)
    
    // Flag which determines if currently user is recording path
    var isRecording: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation bar
        self.title = "Map"
        self.tabBarItem = UITabBarItem(title: "Record", image: UIImage(named: "pin"), selectedImage: UIImage(named: "pin"))
        self.navigationItem.rightBarButtonItems = [
            //TODO: Right arrow
            UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(RecordingMapViewController.pressDetailsButton(sender:)))
        ]

        self.navigationItem.rightBarButtonItem?.title = "Details"
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 7
        locationManager.delegate = self
        
//        locationManager.
        
        // Setting up polyline
        polyline.strokeColor = .red
    }
    
    
    override func loadView() {
        super.loadView()
        
        // Create topControlPanel - top of HomeViewController, where buttons to control path will be
        let topControlPanel: UIView = UIView()
        topControlPanel.backgroundColor = UIColor(colorLiteralRed: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
        topControlPanel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(topControlPanel)
        
        // Constraints for topControlPanel
        var contraintsTopControlPanel = [NSLayoutConstraint]()
        let ctcp1 = topControlPanel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let ctcp2 = topControlPanel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor)
        let ctcp3 = topControlPanel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let ctcp4 = topControlPanel.heightAnchor.constraint(equalToConstant: 64)
        
        contraintsTopControlPanel.append(ctcp1)
        contraintsTopControlPanel.append(ctcp2)
        contraintsTopControlPanel.append(ctcp3)
        contraintsTopControlPanel.append(ctcp4)
        NSLayoutConstraint.activate(contraintsTopControlPanel)
        
        // Adding topCOntrolPanel to main view
        view.addSubview(topControlPanel)
        
        // Setting buttons of control panel
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.7, blue: 0.1, alpha: 0.8)
        startButton.layer.cornerRadius = 5
        startButton.setTitleColor(UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
        startButton.setTitleColor(UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControlState.highlighted)
        startButton.titleLabel?.layer.shadowColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        startButton.titleLabel?.layer.shadowRadius = 4
        startButton.titleLabel?.layer.shadowOpacity = 0.9
        startButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        startButton.setTitle("Start", for: UIControlState.normal)
        startButton.layer.borderWidth = 0.4
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.addTarget(self, action: #selector(RecordingMapViewController.pressStartButton(sender:)), for: UIControlEvents.touchUpInside)
        
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.backgroundColor = UIColor(displayP3Red: 0.7, green: 0.1, blue: 0.1, alpha: 0.8)
        stopButton.layer.cornerRadius = 5
        stopButton.setTitleColor(UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
        stopButton.setTitleColor(UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControlState.highlighted)
        stopButton.titleLabel?.layer.shadowRadius = 4
        stopButton.titleLabel?.layer.shadowOpacity = 0.9
        stopButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        stopButton.setTitle("Stop", for: UIControlState.normal)
        stopButton.layer.borderWidth = 0.4
        stopButton.layer.borderColor = UIColor.black.cgColor
        stopButton.addTarget(self, action: #selector(RecordingMapViewController.pressStopButton(sender:)), for: UIControlEvents.touchUpInside)
        stopButton.isEnabled = false
        
        
        // Adding stackview inside topControlPanel for buttons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        
        // Adding stackview as subview of topCOntrolpanel
        topControlPanel.addSubview(stackView)
        
        // Constraints for stackview
        var constraintsStackView = [NSLayoutConstraint]()
        let csv1 = stackView.leadingAnchor.constraint(equalTo: topControlPanel.layoutMarginsGuide.leadingAnchor)
        let csv2 = stackView.topAnchor.constraint(equalTo: topControlPanel.layoutMarginsGuide.topAnchor)
        let csv3 = stackView.trailingAnchor.constraint(equalTo: topControlPanel.layoutMarginsGuide.trailingAnchor)
        let csv4 = stackView.bottomAnchor.constraint(equalTo: topControlPanel.layoutMarginsGuide.bottomAnchor)
        
        constraintsStackView.append(csv1)
        constraintsStackView.append(csv2)
        constraintsStackView.append(csv3)
        constraintsStackView.append(csv4)
        NSLayoutConstraint.activate(constraintsStackView)
        
        // Adding buttons to stackview
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(stopButton)
        //stackView.addArrangedSubview(restartButton)
        
        // End of Top Control Panel
        
        // Creating Map
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.isMyLocationEnabled = false
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        
        // Constraints for map
        var constraintsMap = [NSLayoutConstraint]()
        let cm1 = mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let cm2 = mapView.topAnchor.constraint(equalTo: topControlPanel.bottomAnchor)
        let cm3 = mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let cm4 = mapView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)
        
        constraintsMap.append(cm1)
        constraintsMap.append(cm2)
        constraintsMap.append(cm3)
        constraintsMap.append(cm4)
        NSLayoutConstraint.activate(constraintsMap)
        
    }
    
    func pressStartButton(sender: UIButton!) {
        // Active Stop Button
        stopButton.isEnabled = true
        
        // Check if already recording
        if (isRecording == false) {
            // Change isRecording status to true
            isRecording = true
            
            // Start Location
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            
            // Change startButton to Pause
            startButton.setTitle("Pause", for: .normal)
            startButton.backgroundColor = UIColor(displayP3Red: 0.74, green: 0.72, blue: 0.42, alpha: 0.8)
            

        }
        else {
            // Change isRecording status to false
            isRecording = false
            
            // Stop Location
            locationManager.stopUpdatingLocation()
            
            mapView.isMyLocationEnabled = false
            
            // Change startButton to Resume
            startButton.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.7, blue: 0.1, alpha: 0.8)
            startButton.setTitle("Resume", for: UIControlState.normal)
        }
    }
    
    func pressStopButton(sender: UIButton!) {
        // Change isRecording status to false
        isRecording = false
        
        // Flush previous Data on polyline, path, etc.
        path.removeAllCoordinates()
        polyline.path = path
        mapView.clear()
        
        mapView.isMyLocationEnabled = false
        
        
        // Stop Location
        locationManager.stopUpdatingLocation()
        
        // Change startButton to Start
        startButton.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.7, blue: 0.1, alpha: 0.8)
        startButton.setTitle("Start", for: UIControlState.normal)
        
        // Disable stopButton
        stopButton.isEnabled = false
    }
    
    func pressDetailsButton(sender: UIButton!) {
        let vc = RecordingDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// Delegates to handle events for the map gestures.
extension RecordingMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        zoomLevel = position.zoom
    }
}

// Delegates to handle events for the location manager.
extension RecordingMapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        
        
        if (path.count() != 0)
        {
            // Check if location given in arg is valid
            let locationAge: TimeInterval = -location.timestamp.timeIntervalSinceNow
            if (locationAge > 5.0 || location.horizontalAccuracy < 0) {
                return
            }
            
            // Check if previous location is not too near from last one (in order not to clutter memory)
            let previousLocation2D: CLLocationCoordinate2D = path.coordinate(at: path.count()-1)
            let previousLocation: CLLocation = CLLocation(latitude: previousLocation2D.latitude, longitude: previousLocation2D.longitude)
            let distance: Double = previousLocation.distance(from: location)
            if (distance < 7) {
                return
            }
        }
        print("Location: \(location)")
        
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel,
                                              bearing: location.course,
                                              viewingAngle: viewAngle)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
            mapView.reloadInputViews()
        }
        
        path.add(location.coordinate, timestamp: location.timestamp)
        //check if path have only 1 node (added line above)
        if (polyline.path?.count() == 1) {
            polyline = GMSPolyline(path: path)
            polyline.map = mapView
        }
        else {
            polyline.path = path
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            //UIApplication.shared.open(URL(string: "App-Prefs:root=Privacy")!, options: ["path":"LOCATION_SERVICES"], completionHandler: nil)
            print("Location access was restricted.")
        case .denied:
            
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
}
