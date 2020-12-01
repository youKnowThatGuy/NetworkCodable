//
//  DetailedStationController.swift
//  NetworkCodable
//
//  Created by Клим on 02.12.2020.
//

import UIKit

class DetailedStationController: UIViewController {
     var station: Station! = nil
    
    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var longtitudeLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView(){
        stationNameLabel.text = station.name
        longtitudeLabel.text = "lng: \(station.lng)"
        latitudeLabel.text = "lat: \(station.lat)"
        
    }
    
}
