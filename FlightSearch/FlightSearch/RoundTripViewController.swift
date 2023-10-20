//
//  RoundTripViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class RoundTripViewController: UIViewController {

    
    @IBOutlet weak var roundTripFrom: UITextField!
    
    @IBOutlet weak var roundTripTo: UITextField!
    @IBOutlet weak var roundTripDepartureDate: UIDatePicker!
    @IBOutlet weak var roundTripReturnDate: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
            // Do any additional setup after loading the view.
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
        }  
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
