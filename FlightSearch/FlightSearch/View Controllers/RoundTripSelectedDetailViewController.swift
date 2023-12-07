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
        let stopsCountString = selectFlight!.stopoversCount
        let stopsCount = Int(stopsCountString)
        if( stopsCount ?? 2 >= 2)
        {
            airlines.text = selectFlight?.airlineName
            totalDuration.text = selectFlight?.totalDuration
            startAirport.text = selectFlight?.departureAirport
            startTime.text = selectFlight?.departureTime
            firstLayoverDuration.text = selectFlight?.layoverDuration
            firstlayoverAirport.text = selectFlight?.layoverAirport
            firstLayoverArrivalTime.text = selectFlight?.layoverAirport1ArrivalTime
            firstLayoverport.text = selectFlight?.layoverAirport
            firstLayoverDepartureTime.text = selectFlight?.layoverAirport1DepartureTime
            secondLayoverport.text = selectFlight?.secondlayoverAirport
            secondLayoverDuration.text = selectFlight?.secondLayoverDuration
            secondLayoverAiport.text = selectFlight?.secondlayoverAirport
            secondLayoverDepartureTime.text = selectFlight?.secondLayoverDepartureTime
            secondLayoverArrivalTime.text = selectFlight?.secondLayoverArrivalTime
            destinationAirport.text = selectFlight?.arrivalAirport
            arrivalTime.text = selectFlight?.arrivalTime
        }
        
        if( stopsCount == 1)
        {
            airlines.text = selectFlight?.airlineName
            totalDuration.text = selectFlight?.totalDuration
            startAirport.text = selectFlight?.departureAirport
            startTime.text = selectFlight?.departureTime
            firstLayoverDuration.text = selectFlight?.layoverDuration
            firstlayoverAirport.text = selectFlight?.layoverAirport
            firstLayoverArrivalTime.text = selectFlight?.layoverAirport1ArrivalTime
            firstLayoverport.text = selectFlight?.layoverAirport
            firstLayoverDepartureTime.text = selectFlight?.layoverAirport1DepartureTime
            
            destinationAirport.text = selectFlight?.arrivalAirport
            secondLayoverAiport.text = selectFlight?.arrivalAirport
            secondLayoverArrivalTime.text = selectFlight?.arrivalTime
            
            secondLayoverLabel.isHidden = true
            secondLayoverDuration.isHidden = true
            secondLayoverport.isHidden = true
           
            
            secondLayoverDepartureTime.isHidden=true
            
            destinationAirport.isHidden = true
            arrivalTime.isHidden = true

        }
        
        if( stopsCount == 0)
        {
            airlines.text = selectFlight?.airlineName
            totalDuration.text = selectFlight?.totalDuration
            startAirport.text = selectFlight?.departureAirport
            startTime.text = selectFlight?.departureTime
            firstlayoverAirport.text = selectFlight?.arrivalAirport
            firstLayoverArrivalTime.text = selectFlight?.arrivalTime
            
            firstLayoverlabel.isHidden = true
            firstLayoverDuration.isHidden = true
            firstLayoverport.isHidden = true
            firstLayoverDepartureTime.isHidden = true
            secondLayoverAiport.isHidden=true
            secondLayoverDepartureTime.isHidden=true
            
            secondLayoverLabel.isHidden = true
            secondLayoverDuration.isHidden = true
            secondLayoverport.isHidden = true
           
            
            secondLayoverArrivalTime.isHidden=true
            
            destinationAirport.isHidden = true
            arrivalTime.isHidden = true
        }
        

       
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
