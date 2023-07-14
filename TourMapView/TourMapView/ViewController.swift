//
//  ViewController.swift
//  TourMapView
//
//  Created by Yerlan Tleubayev on 02.07.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
  
    
    @IBOutlet weak var map: MKMapView!
    
    
    var names = ""
    var Cost = ""
    var imageName = ""
    var latitudeSecond: Double = 0.0
    var longitudeSecond: Double = 0.0
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        name.text = names
        detail.text = Cost
        placeImage.image = UIImage(named: imageName)
        
        print(latitudeSecond)
        print(longitudeSecond)
    }

/*
 mapview
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapview"{
            if let secondVC = segue.destination as? MapViewController{
                secondVC.latti = latitudeSecond
                secondVC.long = longitudeSecond
            }
        }
    }
    
}


