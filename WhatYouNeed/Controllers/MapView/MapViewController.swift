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
    private var personClicked: Person?
    private var currentUserAnnotation: MKPointAnnotation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.handleCurrentUserFirstTimeLaunching()
        mapView.delegate = self
        observeCurrentUser()
        observeViewModel()
        initLocationManager()
        pinning()
        self.viewModel.fetchPins()
    }
    
    private func observeCurrentUser() {
        CurrentUser.shared.observeBy { currentUser in
            if CurrentUser.isPinned() {
                self.setCurrentUserAnnotationTitle()
            }
        }
    }
    
    private func setCurrentUserAnnotationTitle() {
        if let annotation = self.currentUserAnnotation {
            annotation.title = CurrentUser.shared.value?.name ?? ""
        }
    }
    
    private func observeViewModel() {
        viewModel.pins.observeBy { people in
            // self.removePin()
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.addPins()
            self.setCurrentUserAnnotation()
        }
    }
    
    private func setCurrentUserAnnotation() {
        if let currentUser = viewModel.pins.value?.first(where: { person in
            person.id == CurrentUser.currentUserId
        }) {
            currentUserAnnotation = mapView.annotations.first(where: { annotation in
                annotation.coordinate.latitude == CurrentUser.shared.value?.location?.lat &&
                annotation.coordinate.longitude == CurrentUser.shared.value?.location?.long
            }) as? MKPointAnnotation
        }
    }
    
    private func pinning() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(pinLocation(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 1
        mapView.addGestureRecognizer(longPressGesture)
    }

    @objc private func pinLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            if let ant = self.currentUserAnnotation { self.mapView.removeAnnotation(ant) }
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = CurrentUser.shared.value?.name ?? ""
            annotation.subtitle = ""
            self.mapView.addAnnotation(annotation)
            self.currentUserAnnotation = annotation
            
            if let user = CurrentUser.shared.value?.copyWith(location: Location(lat: touchedCoordinates.latitude,
                                                                            long: touchedCoordinates.longitude)) {
                CurrentUser.set(to: user)
            }
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
    
   /* func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if !dummyPinsAdded {
            addPins()
            dummyPinsAdded = true
        }
    } */
    
    private func addPins() {
        viewModel.pins.value?.forEach { person in
            
                let annotation = MKPointAnnotation()
                guard let lat = person.location?.lat, let long = person.location?.long else {return}
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotation.title = person.name
                self.mapView.addAnnotation(annotation)
            
            
        }
    }
    
    private func removePin() {
        if viewModel.pinToRemove != nil {
            let annotationToRemove = self.mapView.annotations.first(where: { annotation in
                annotation.coordinate.latitude == self.viewModel.pinToRemove?.location?.lat &&
                annotation.coordinate.longitude == self.viewModel.pinToRemove?.location?.long
            })
            if let annotation = annotationToRemove {
                self.mapView.removeAnnotation(annotation)
            }
            viewModel.pinToRemove = nil
        }
        
    }
    
    private func isPinned(_ person: Person) -> Bool {
        return self.mapView.annotations.first { annotation in
            annotation.coordinate.latitude == person.location?.lat &&
            annotation.coordinate.longitude == person.location?.long
        } != nil
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
            pinView?.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        personClicked = viewModel.pins.value?.first { person in
            person.location!.lat == view.annotation?.coordinate.latitude
            && person.location!.long == view.annotation?.coordinate.longitude
        }
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let vc = segue.destination as! DetailsViewController
            vc.person = personClicked
            vc.clearPinClickedHandler = {
                if self.currentUserAnnotation != nil {
                    CurrentUser.set(to: (CurrentUser.shared.value?.copyWith(location: Location(lat: nil, long: nil)))!)
                    print("current user annotation is cleared")
                    // remove current user from ViewModel.pins
                    // remove current user from Firebase.pins
                }
                
            }
            if vc.presentingViewController?.isBeingPresented == true {
                self.present(vc, animated: true)
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
