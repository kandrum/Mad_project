//
//  OneWayViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//
import UIKit

class OneWayViewController: UIViewController {

    
    @IBOutlet weak var oneWayFrom: UITextField!
    @IBOutlet weak var oneWayTo: UITextField!
    
    @IBOutlet weak var oneWayDepartureDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oneWayFrom.placeholder="From"
        oneWayTo.placeholder="To"
        // Add gradient layer
        addGradientLayer()
    }

    private func addGradientLayer() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds

            // Define your custom sky blue color
            let skyBlueColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0)

            gradientLayer.colors = [UIColor.white.cgColor, skyBlueColor.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

            // Remove any existing gradient layers
            view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

            // Add the gradient layer to the view's layer
            view.layer.insertSublayer(gradientLayer, at: 0)
        }}

