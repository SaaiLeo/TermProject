//
//  MapPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 13/9/24.
//

import UIKit
import MapKit
import CoreLocation


var SHOP_LOCATION: [ShopLocation] = []

class MapPageViewController: UIViewController, MKMapViewDelegate {
    
    static let identifier = String(describing: MapPageViewController.self)
    let userLocation = CLLocationCoordinate2D(latitude: 13.613239, longitude: 100.835531)
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.frame = view.bounds
        guard let jsonFile = readJSONFile(named: "pokeshopLocation", withExtension: "json") else { return }
        SHOP_LOCATION = jsonFile.ShopLocations
        
        mapView.setRegion(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)), animated: false)
        
        for shop in SHOP_LOCATION {
            addCustomPin(title: shop.name, subtitle: shop.openingHours, lat: shop.LocationLat, long: shop.LocationLong)
        }

    }
    
    private func addCustomPin(title: String, subtitle: String, lat: Double, long: Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        pin.title = title
        pin.subtitle = subtitle
        mapView.addAnnotation(pin)
    }
    
    //Map
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //Create the view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            
//            let button = UIButton(type: .detailDisclosure)
//            button.setTitle("Info", for: .normal)
//            
//            annotationView?.rightCalloutAccessoryView = button
            
        }else {
            annotationView?.annotation = annotation
        }
        
        let icon = UIImage(named: "pokeball")
        annotationView?.image = resizeImage(image: icon!, targetSize: CGSize(width: 35, height: 35))
        
        return annotationView
        
        
    }
    
    // Function to resize an image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine what our new size should be
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect where we will draw our image
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Begin a new image context, optional scale factor of 0 means use the device's main screen scale
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        // Draw the image in the new size
        image.draw(in: rect)
        
        // Get the resized image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // Function to read JSON file from the app bundle
    func readJSONFile(named fileName: String, withExtension fileExtension: String) -> ShopLocations? {
        // Locate the file in the bundle
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                // Read the data from the file
                let data = try Data(contentsOf: fileURL)
                // Decode the data to the AppInfo struct
                let appInfo = try JSONDecoder().decode(ShopLocations.self, from: data)
                return appInfo
            } catch {
                print("Error reading or decoding file: \(error.localizedDescription)")
            }
        } else {
            print("File not found.")
        }
        return nil
    }
}
