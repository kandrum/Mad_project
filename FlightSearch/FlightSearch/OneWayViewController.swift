//
//  OneWayViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//
import UIKit

class OneWayViewController: UIViewController, UITextFieldDelegate,AirportSelectionDelegate {

    
    @IBOutlet weak var oneWayFrom: UITextField!
    @IBOutlet weak var oneWayTo: UITextField!
    
    @IBOutlet weak var oneWayDepartureDate: UIDatePicker!
    
    var selectedAirport:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oneWayFrom.placeholder="From"
        oneWayTo.placeholder="To"
        oneWayDepartureDate.minimumDate=Date()
        oneWayFrom.delegate=self
        oneWayTo.delegate=self
        // Add gradient layer
        addGradientLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            oneWayFrom.resignFirstResponder()
            oneWayTo.resignFirstResponder()
        }
    
    @IBAction func searchBtn(_ sender: Any) {
       performSegue(withIdentifier: "oneWayToDisplay", sender: self)
    }
    
    @IBAction func searchFrom(_ sender: UITextField) {
        selectedAirport=sender
        if(sender == oneWayFrom){
                    performSegue(withIdentifier: "oneWayAiportSegue", sender: oneWayFrom)
                }    }
    

    
    @IBAction func searchTo(_ sender: UITextField) {
        selectedAirport=sender
        if(sender == oneWayTo){
                    performSegue(withIdentifier: "oneWayAiportSegue", sender: oneWayTo)
                }
    }
    
    func airportSelected(_ airport: AirportViewController.Airport, forType: FlightType) {
            selectedAirport?.text = airport.name

        }

         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "oneWayAiportSegue" {
                if let airportVC = segue.destination as? AirportViewController {
                    airportVC.delegate = self
                    airportVC.flightType = selectedAirport == oneWayFrom ? .from : .to
                }
            }    }

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

