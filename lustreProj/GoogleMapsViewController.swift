//
//  Google.swift
//  lustreProj
//
//  Created by Shahad X on 30/05/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class GoogleMapsViewController: UIViewController , CLLocationManagerDelegate {
    
    
       let marker = GMSMarker()
       var lat = 0.0
       var long = 0.0
    @IBOutlet weak var space: UILabel!
    
    var locationManager = CLLocationManager()
       lazy var mapView = GMSMapView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13.0)
       mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 292, width: 414, height: 369), camera: camera)
        
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
       // let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "your location"
       // marker.snippet = "home"
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
     

       
    }
    
    @IBAction func sliderValueChnage(_ sender: UISlider) {
        
         NSLog("slider value = %f", sender.value)
           let radius =  sender.value / 1000
           space.text = String (format: "%.2f KM", radius)
           
        // to save maximum kilometer
        print("max distance is " ,radius )
        UserInfo.MaximumDis = String(radius)
           mapView.clear()
           
         //  let currentLocation = CLLocationCoordinate2DMake(-33.86, 151.20)
           
                  let marker = GMSMarker()
                  marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                  marker.title = "your location"
                 // marker.snippet = "home"
               //   marker.appearAnimation = GMSMarkerAnimation.pop

                  marker.map = mapView
           
           
          let circleCenter = CLLocationCoordinate2D(latitude:  lat, longitude: long)
           
           let circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(sender.value))
           
           circ.fillColor = UIColor( red: 150.0, green: 206.0, blue: 180.0, alpha: 0.4)
           circ.strokeColor =  UIColor( red: 150.0, green: 206.0, blue: 180.0, alpha: 1.0)
           circ.strokeWidth = 3
           circ.map = mapView
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        let userLocation = locations.last
     _ = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)

        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                                          longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 292, width: 414, height: 369), camera: camera)
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
        
    // let marker = GMSMarker()
     lat = userLocation!.coordinate.latitude
     long = userLocation!.coordinate.longitude
        
        
        UserInfo.long = String(long)
        UserInfo.lati = String(lat)
        
     
     
     marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)

                   marker.title = "your location"
                  // marker.snippet = "home"
                 //  marker.appearAnimation = GMSMarkerAnimation.pop
                   marker.map = mapView
         let circleCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
         
         let circ = GMSCircle(position: circleCenter, radius: 1000)
         
         circ.fillColor = UIColor( red: 150.0, green: 206.0, blue: 180.0, alpha: 0.4)
         circ.strokeColor =  UIColor( red: 150.0, green: 206.0, blue: 180.0, alpha: 1.0)
         circ.strokeWidth = 3
         circ.map = mapView

        locationManager.stopUpdatingLocation()
    }
    
    
    


}
    

