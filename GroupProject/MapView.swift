//
//  MapView.swift
//  GroupProject
//
//  Created by Alexander Mason on 11/21/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//

import Foundation
import MapKit

class MapView: MKMapView, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!
    let locationArray = DataStore.sharedInstance.markets
    var mapItemList: [MKMapItem] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        
        initialSetupForView()
//        setupLocationManager()
        self.convertMarketsToMapItem()
        self.addAnnotationsToMap()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialSetupForView() {
        print("called")
        setupLocationManager()
        
    }
    
    func convertMarketsToMapItem() {
        print("convert item called")
        for location in locationArray {
            let longitude = Double(location.longitude!)
            let latitude = Double(location.latitude!)
            let placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(latitude!, longitude!))
            mapItemList.append(MKMapItem(placemark: placemark))
        }
    }
    
    
    func addAnnotationsToMap() {
        print("add annotations called")
        var annotations: [MKAnnotation] = []
        for location in mapItemList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.placemark.coordinate
            
            annotations.append(annotation)
        }
        let region = MKCoordinateRegion(center: annotations[0].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        self.setRegion(region, animated: true)
        self.addAnnotations(annotations)
    }
    
    

    
}

extension MapView: CLLocationManagerDelegate {
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        centerMapOnCurrentLocation(location: location)
    }
    
    func centerMapOnCurrentLocation(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        self.setRegion(region, animated: true)
    }
    
    
}






