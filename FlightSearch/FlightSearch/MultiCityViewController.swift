//
//  MultiCityViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//
import UIKit

class MultiCityViewController: UIViewController {
    
    @IBOutlet weak var FromMulti: UITextField!
    @IBOutlet weak var AddFlight: UIButton!
    @IBOutlet weak var ToMulti: UITextField!
    @IBOutlet weak var ReturnMulti: UIDatePicker!
    @IBOutlet weak var DepatureMulti: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
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
    
    @IBAction func AddFlight(_ sender: Any) {
        addFlightDetailsView()
    }
    private func addFlightDetailsView() {
        let flightDetailsView = FlightDetailViewController.instanceFromNib()
        
        // Adjust the position and size of the flightDetailsView
        
        
        // Set the frame for From, To, Departure, and Return fields
        
        view.addSubview(flightDetailsView)
    }
    
}

