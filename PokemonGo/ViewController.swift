//
//  ViewController.swift
//  PokemonGo
//
//  Created by rigoberto on 5/12/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var contActualizaciones = 0
    
    @IBAction func centrarTapped(_ sender: Any) {
        if let coord = ubicacion.location?.coordinate{
        let region = MKCoordinateRegion.init (center:
        coord, latitudinalMeters: 1000,
        longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        contActualizaciones += 1
        }
    }
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var ubicacion = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ubicacion.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
            ubicacion.startUpdatingLocation()
            Timer.scheduledTimer (withTimeInterval: 5, repeats: true, block: { (timer) in
                if let coord = self.ubicacion.location?.coordinate{
                    let pin = MKPointAnnotation ()
                    pin.coordinate = coord
                    let randomLat = (Double(arc4random_uniform(200))-100.0)/5000.0
                    let randomLon = (Double(arc4random_uniform(200))-100.0)/5000.0
                    pin.coordinate.latitude += randomLat
                    pin.coordinate.longitude += randomLon
                    self.mapView.addAnnotation(pin)
                }
            })
        }else{
            ubicacion.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations
    locations: [CLLocation]) {
    if contActualizaciones<1{
    let region = MKCoordinateRegion.init(center:
    ubicacion.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion (region, animated: true)
        contActualizaciones += 1
    }else{
    ubicacion.stopUpdatingLocation ( )
    }
    //print( "Ubicacion actualizada")
    }
    
    
    


}

