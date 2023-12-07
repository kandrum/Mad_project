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
    
    
    @IBOutlet weak var layOver: UILabel!
    
    @IBOutlet weak var layoverAirportArrivalTime: UILabel!
    
    @IBOutlet weak var departureToLayoverDuration: UILabel!
    
    @IBOutlet weak var layoverDuration: UILabel!
    
    @IBOutlet weak var layoverAirportStart: UILabel!
    
    @IBOutlet weak var layOverDepartureTime: UILabel!
    @IBOutlet weak var arrivalAirport: UILabel!
    
    @IBOutlet weak var reachTime: UILabel!
    

    @IBOutlet weak var layerOverLabel: UILabel!
    
    @IBOutlet weak var secondLayoverDuration: UILabel!
    
    @IBOutlet weak var layoverTwoAirport: UILabel!
    
    @IBOutlet weak var layover2AirportDepartureTime: UILabel!
    
    @IBOutlet weak var destionation: UILabel!
    
    @IBOutlet weak var destinationTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        if let flightInfo = selectedFlightInfo{
            if selectedFlightInfo!.stopoversCount == 1 {
                airwayFirstFlight.text = selectedFlightInfo?.airlineName
                totalDuration.text = selectedFlightInfo?.totalDuration
                departureAirport.text = selectedFlightInfo?.departureAirport
                startTime.text = selectedFlightInfo?.departureTime
                reachTime.text = selectedFlightInfo?.arrivalTime
                arrivalAirport.text = selectedFlightInfo?.arrivalAirport
                layoverAirport.text = selectedFlightInfo?.layoverAirport
                layoverAirportStart.text = selectedFlightInfo?.layoverAirport
                layoverDuration.text = selectedFlightInfo?.layoverDuration
                layoverAirportArrivalTime.text = selectedFlightInfo?.layoverAirport1ArrivalTime
                layOverDepartureTime.text = selectedFlightInfo?.layoverAirport1DepartureTime
                
                layerOverLabel.isHidden = true
                secondLayoverDuration.isHidden = true
                layoverTwoAirport.isHidden = true
                layover2AirportDepartureTime.isHidden = true
                destionation.isHidden = true
                destinationTime.isHidden = true
            }
            
            
            if(selectedFlightInfo!.stopoversCount >= 2)
            {
                airwayFirstFlight.text = selectedFlightInfo?.airlineName
                totalDuration.text = selectedFlightInfo?.totalDuration
                departureAirport.text = selectedFlightInfo?.departureAirport
                startTime.text = selectedFlightInfo?.departureTime
                layoverAirport.text = selectedFlightInfo?.layoverAirport
                layoverAirportArrivalTime.text = selectedFlightInfo?.layoverAirport1ArrivalTime
                layoverDuration.text = selectedFlightInfo?.layoverDuration
                
                layoverAirportStart.text = selectedFlightInfo?.layoverAirport
                layOverDepartureTime.text = selectedFlightInfo?.layoverAirport1DepartureTime
                arrivalAirport.text = selectedFlightInfo?.secondlayoverAirport
                layoverTwoAirport.text = selectedFlightInfo?.secondlayoverAirport
                reachTime.text = selectedFlightInfo?.secondLayoverArrivalTime
                secondLayoverDuration.text = selectedFlightInfo?.secondLayoverDuration
                secondLayoverDuration.isHidden = false
                layover2AirportDepartureTime.text = selectedFlightInfo?.secondLayoverDepartureTime
                destionation.text = selectedFlightInfo?.arrivalAirport
                destinationTime.text = selectedFlightInfo?.arrivalTime

            }
            
            if(selectedFlightInfo?.stopoversCount == 0)
            {
                airwayFirstFlight.text = selectedFlightInfo?.airlineName
                totalDuration.text = selectedFlightInfo?.totalDuration
                departureAirport.text = selectedFlightInfo?.departureAirport
                startTime.text = selectedFlightInfo?.departureTime
                layoverAirport.text = selectedFlightInfo?.arrivalAirport
                layoverAirportArrivalTime.text = selectedFlightInfo?.arrivalTime
                layoverDuration.isHidden = true
                layerOverLabel.isHidden = true
                layOver.isHidden = true
                layoverAirportStart.isHidden = true
                layOverDepartureTime.isHidden = true
                arrivalAirport.isHidden = true
                layoverTwoAirport.isHidden = true
                reachTime.isHidden = true
                
                secondLayoverDuration.isHidden = true
                secondLayoverDuration.isHidden = false
                secondLayoverDuration.isHidden = true
                layoverTwoAirport.isHidden = true
                layover2AirportDepartureTime.isHidden = true
                destionation.isHidden = true
                destinationTime.isHidden = true
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
