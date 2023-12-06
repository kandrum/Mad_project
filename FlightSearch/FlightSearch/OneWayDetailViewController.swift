//
//  OneWayDetailViewController.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import UIKit

class OneWayDetailViewController: UIViewController {
     
    var selectedFlightInfo: DisplayFlightInfo?
    
    
    @IBOutlet weak var airwayFirstFlight: UILabel!
    
    @IBOutlet weak var totalDuration: UILabel!
    
    @IBOutlet weak var departureAirport: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    
    
    @IBOutlet weak var layoverAirport: UILabel!
    
    
    @IBOutlet weak var layoverAirportArrivalTime: UILabel!
    
    @IBOutlet weak var departureToLayoverDuration: UILabel!
    
    @IBOutlet weak var layoverDuration: UILabel!
    
    @IBOutlet weak var layoverAirportStart: UILabel!
    
    @IBOutlet weak var layOverDepartureTime: UILabel!
    @IBOutlet weak var arrivalAirport: UILabel!
    
    @IBOutlet weak var reachTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        if let flightInfo = selectedFlightInfo{
            if selectedFlightInfo!.stopoversCount > 1 {
                airwayFirstFlight.text = selectedFlightInfo?.airlineName
                totalDuration.text = selectedFlightInfo?.totalDuration
                departureAirport.text = selectedFlightInfo?.departureAirport
                startTime.text = selectedFlightInfo?.departureTime
                
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    private func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let skyBlueColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0)
        
        gradientLayer.colors = [UIColor.white.cgColor, skyBlueColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
