//
//  MultiCityViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class MultiCityViewController: UIViewController,UITextFieldDelegate,AirportSelectionDelegate {
    func airportSelected(_ airport: AirportViewController.Airport, forType: FlightType) {
        selectedTextField?.text = airport.iata
    }
    var selectedTextField: UITextField?
    
    @IBOutlet weak var FromMulti: UITextField!
    @IBOutlet weak var AddFlight: UIButton!
    @IBOutlet weak var ToMulti: UITextField!
    @IBOutlet weak var DepatureMulti: UIDatePicker!
    var yOffset: CGFloat = 300 // Starting point for dynamic elements, adjust accordingly
    var addFlightClickCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        
        FromMulti.placeholder = "From"
        ToMulti.placeholder = "To"
        
        
        // Ensuring AddFlight button calls the function
        AddFlight.addTarget(self, action: #selector(AddFlightAction(_:)), for: .touchUpInside)
        FromMulti.delegate = self
        ToMulti.delegate = self
        textFieldDidBeginEditing(FromMulti)
    }
    
    @IBAction func SearchAction(_ sender: Any) {
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    /*@IBAction func FromMulti_Action(_ sender: UITextField) {
        FromMulti.resignFirstResponder()
        performSegue(withIdentifier: "segue2", sender: self)
    }*/
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
        if textField.placeholder == "From" || textField.placeholder == "To"{
            textField.resignFirstResponder()  // Dismiss the keyboard
            performSegue(withIdentifier: "segue2", sender: self)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segue2" {
                if let airportVC = segue.destination as? AirportViewController {
                    airportVC.delegate = self
                    airportVC.flightType = selectedTextField == FromMulti ? .from : .to
                }
            }
        }
    
    
    @objc @IBAction func AddFlightAction(_ sender: Any) {
        addFlightClickCount += 1  // Increment the counter
        
        // If it's the third click, show the alert and return
        if addFlightClickCount == 3 {
            let alert = UIAlertController(title: "Error", message: "You can't add more flights.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let fromTextField = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.frame.width - 150, height: 40))
        fromTextField.placeholder = "From"
        fromTextField.borderStyle = .roundedRect
        fromTextField.delegate = self
        view.addSubview(fromTextField)

        yOffset += 50
            
        let toTextField = UITextField(frame: CGRect(x: 20, y: yOffset, width: view.frame.width - 150, height: 40))
        toTextField.placeholder = "To"
        toTextField.borderStyle = .roundedRect
        toTextField.delegate = self
        view.addSubview(toTextField)
            
        yOffset += 50

        let departureDatePickerWidth = view.frame.width / 2
        let departureDatePicker = UIDatePicker(frame: CGRect(x: -80, y: yOffset, width: departureDatePickerWidth, height: 200))
        departureDatePicker.datePickerMode = .date
        view.addSubview(departureDatePicker)
        yOffset += 100
    }
}
