//
//  RoundTripSelectedDetailViewController.swift
//  FlightSearch
//
//  Created by Sai Poojitha Velivelli on 12/7/23.
//

import UIKit

class RoundTripSelectedDetailViewController: UIViewController {

    //var selectFlight:DisplayFlightInfo?
    var selectFlight: DisplayFlightInfo?
    
    
    @IBOutlet weak var airlines: UILabel!
    
    @IBOutlet weak var totalDuration: UILabel!
    
    @IBOutlet weak var startAirport: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var firstlayoverAirport: UILabel!
    

    @IBOutlet weak var firstLayoverArrivalTime: UILabel!
    
    
    
    @IBOutlet weak var firstLayoverDuration: UILabel!
    
    
    @IBOutlet weak var firstLayoverlabel: UILabel!
    @IBOutlet weak var firstLayoverport: UILabel!
    
    
    @IBOutlet weak var firstLayoverDepartureTime: UILabel!
    
    @IBOutlet weak var secondLayoverAiport: UILabel!
    
    @IBOutlet weak var secondLayoverArrivalTime: UILabel!
    
    
    @IBOutlet weak var secondLayoverLabel: UILabel!
    
    
    @IBOutlet weak var secondLayoverDuration: UILabel!
    
    
    @IBOutlet weak var secondLayoverport: UILabel!
    
    
    @IBOutlet weak var secondLayoverDepartureTime: UILabel!
    
    @IBOutlet weak var destinationAirport: UILabel!
    
    @IBOutlet weak var arrivalTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        
        airlines.text = selectFlight?.airlineName
        totalDuration.text = selectFlight?.totalDuration
        startAirport.text = selectFlight?.departureAirport
        startTime.text = selectFlight?.departureTime
        firstLayoverDuration.text = selectFlight?.layoverDuration
        firstlayoverAirport.text = selectFlight?.layoverAirport
        firstLayoverArrivalTime.text = selectFlight?.layoverAirport1ArrivalTime
        firstLayoverport.text = selectFlight?.layoverAirport
        
        destinationAirport.text = selectFlight?.arrivalAirport
        arrivalTime.text = selectFlight?.arrivalTime

       
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
