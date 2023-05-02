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
    private let viewModel = MapViewModel()
    private var dummyPinsAdded = false
    private let annotationId = "annotation"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationId)
        mapView.delegate = self
        initLocationManager()
        pinning()
    }
    
    private func pinning() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(pinLocation(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 1
        mapView.addGestureRecognizer(longPressGesture)
    }

    @objc private func pinLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = "title"
            annotation.subtitle = "subtitle"
            self.mapView.addAnnotation(annotation)
        }
    }
    
    private func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
        
}

//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if !dummyPinsAdded {
            addDummyPins()
            dummyPinsAdded = true
        }
    }
    
    private func addDummyPins() {
        viewModel.dummyPins.forEach { person in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: person.location.coordinate.latitude,
                                                           longitude: person.location.coordinate.longitude)
            annotation.title = person.name
            self.mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .systemBlue
            pinView?.rightCalloutAccessoryView = getCalloutButton()
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    private func getCalloutButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
        button.addTarget(self, action: #selector(goToDetailsVC), for: .touchUpInside)
        
        return button
    }
    
    @objc private func goToDetailsVC() {
        performSegue(withIdentifier: "goToDetails", sender: nil)
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


//MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let marasCoordinates = viewModel.marasCoordinates
        let location = CLLocationCoordinate2D(latitude: marasCoordinates.0, longitude: marasCoordinates.1)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
    }
}
