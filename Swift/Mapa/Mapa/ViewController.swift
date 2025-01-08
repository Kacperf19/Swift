//
//  ViewController.swift
//  Mapa
//
//  Created by Student Informatyki on 08/01/2025.
//

import Cocoa
import MapKit
import CoreLocation

class ViewController: NSViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000

    @IBOutlet weak var CoordinatesLabel: NSTextField!
    @IBOutlet weak var CoordinateX: NSTextField!
    @IBOutlet weak var CoordinateY: NSTextField!

    
    
    
    
    
    @IBAction func AddPinButton(_ sender: Any) {
       let center = mapView.centerCoordinate

   let lat = Double(CoordinateX.stringValue) ?? center.latitude
        let lon = Double(CoordinateY.stringValue) ?? center.longitude

      let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)

      let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: regionInMeters,
            longitudinalMeters: regionInMeters
        )
        mapView.setRegion(region, animated: true)

     addPin(at: coordinate, withTitle: "Custom Pin")
    }



    @IBAction func ResetPinsButton(_ sender: Any) {
        removeAllPins()
    }
    
    
    
    @IBAction func FindUserLocation(_ sender: Any) {

        if let userLocation = locationManager.location?.coordinate {
         
            let region = MKCoordinateRegion(
                center: userLocation,
                latitudinalMeters: regionInMeters,
                longitudinalMeters: regionInMeters
            )
            mapView.setRegion(region, animated: true)
        } else {
          
            print("User location is not available.")
        }
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        checkLocationServices()

        
    mapView.delegate = self

     updateCenterCoordinatesLabel()
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
       }
    }

    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            print("Location permissions denied. Please enable them in settings.")
        case .restricted:
            print("Location access is restricted.")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("Unknown authorization status.")
        }
    }


    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: regionInMeters,
                longitudinalMeters: regionInMeters
            )
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: regionInMeters,
                longitudinalMeters: regionInMeters
            )
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    func addPin(at coordinate: CLLocationCoordinate2D, withTitle title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    func findLocationByAddress(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first,
                  let location = placemark.location?.coordinate else {
                print("No location found for address.")
                return
            }

            DispatchQueue.main.async {
                self?.addPin(at: location, withTitle: address)
                let region = MKCoordinateRegion(
                    center: location,
                    latitudinalMeters: self?.regionInMeters ?? 1000,
                    longitudinalMeters: self?.regionInMeters ?? 1000
                )
                self?.mapView.setRegion(region, animated: true)
            }
        }
    }

    func removeAllPins() {
        mapView.removeAnnotations(mapView.annotations)
    }

    @IBAction func ReturnToUserLocationButton(_ sender: Any) {
        centerViewOnUserLocation()
    }

 func updateCenterCoordinatesLabel() {
        let center = mapView.centerCoordinate
        CoordinatesLabel.stringValue = String(format: "X: %.6f, Y: %.6f", center.latitude, center.longitude)
    }

  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        updateCenterCoordinatesLabel()
    }
}
