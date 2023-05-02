//
//  MapViewController.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 15.04.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        initLocationManager()
        pinning()
    }
    
    private func pinning() {
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(pinLocation(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 1
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    
    // touchedPoint    CGPoint    (x = 252.33332824707031, y = 279)
    // touchedPoint    CGPoint    (x = 29, y = 308.66665649414063)
    // touchedPoint    CGPoint    (x = 83.333328247070313, y = 598)
    /*
     touchedCoordinates    CLLocationCoordinate2D
         latitude    CLLocationDegrees    37.577551434230919
         longitude    CLLocationDegrees    36.912010863059699
     
        
     */
    @objc private func pinLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            self.mapView.addAnnotation(annotation)
        }
    }
    
    private func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if segue.identifier == "goToDetails" {
            let vc = segue.destination
            if vc.presentingViewController?.isBeingPresented ?? false {
                self.present(vc, animated: true)
            } else {
                print("you probably crashed here!")
            }
        }
    }
}

//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        addDummyPins()
    }
    
    private func addDummyPins() {
        let dummyPins = [CGPoint(x: 252.33332824707031, y: 279),
                         CGPoint(x: 29, y: 308.66665649414063),
                         CGPoint(x: 83.333328247070313, y: 598)]
        dummyPins.forEach { point in
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
        }
    }
}


//MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let marasCoordinates = (37.5764759, 36.9112263)
        let location = CLLocationCoordinate2D(latitude: marasCoordinates.0, longitude: marasCoordinates.1)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
    }
}
