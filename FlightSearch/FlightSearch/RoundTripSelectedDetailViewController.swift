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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        
        airlines.text = selectFlight?.airlineName
        totalDuration.text = selectFlight?.totalDuration
       
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
