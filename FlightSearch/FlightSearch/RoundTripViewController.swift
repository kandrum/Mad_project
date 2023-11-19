
//
//  RoundTripViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class RoundTripViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, AirportSelectionDelegate {

    
    @IBOutlet weak var cabinRound: UITextField!
    @IBOutlet weak var roundTripFrom: UITextField!
    @IBOutlet weak var roundTripTo: UITextField!
    @IBOutlet weak var roundTripDepartureDate: UIDatePicker!
    @IBOutlet weak var roundTripSearchButton: UIButton!
    @IBOutlet weak var roundTripReturnDate: UIDatePicker!
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    var selectedAirport:UITextField?
    let cabinPickerRound = UIPickerView()
    let cabinOptionsRound = ["Economy", "Business", "First", "Premium Economy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTripFrom.placeholder = "From"
        roundTripTo.placeholder = "To"
        cabinRound.placeholder = "cabinclass"
        roundTripFrom.delegate=self
        roundTripTo.delegate=self
        roundTripDepartureDate.minimumDate = Date()
        roundTripReturnDate.minimumDate = Date()
        roundTripDepartureDate.addTarget(self, action: #selector(departureDateChanged), for: .valueChanged)
        
        cabinPickerRound.delegate = self
        cabinPickerRound.dataSource = self
        cabinRound.inputView = cabinPickerRound
        
        let toolBarRound = UIToolbar()
        toolBarRound.sizeToFit()
        let doneButtonRound = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolBarRound.setItems([doneButtonRound], animated: false)
        cabinRound.inputAccessoryView = toolBarRound
        
        addGradientLayer()
            
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == roundTripFrom || textField == roundTripTo {
                selectedAirport = textField
                performSegue(withIdentifier: "AirportSuggestionSegue", sender: self)
                return false // Prevents keyboard from appearing
            }
            return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        roundTripTo.resignFirstResponder()
        roundTripFrom.resignFirstResponder()
    }

    func airportSelected(_ airport: AirportViewController.Airport, forType: FlightType) {
        selectedAirport?.text = airport.iata
        
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue: \(segue.identifier ?? "Unknown")")
        if segue.identifier == "AirportSuggestionSegue" {
            if let airportVC = segue.destination as? AirportViewController {
                airportVC.delegate = self
                airportVC.flightType = selectedAirport ==  roundTripFrom ? .from : .to
            }
        }
        else if segue.identifier == "roundTripToDisplay" {
               if let displayRoundVC = segue.destination as? RoundTripDisplayViewController{
                    displayRoundVC.cabinClassRound = cabinRound.text
                    displayRoundVC.fromLocationRound = roundTripFrom.text
                    displayRoundVC.toLocationRound = roundTripTo.text
                    displayRoundVC.departureDateRound = roundTripDepartureDate.date
                    displayRoundVC.ReturnDateRound = roundTripReturnDate.date
                   
                }
           }
    }
    
    @objc func departureDateChanged() {
        let selectedDepartureDate = roundTripDepartureDate.date
        roundTripReturnDate.minimumDate = selectedDepartureDate
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return cabinOptionsRound.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return cabinOptionsRound[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           cabinRound.text = cabinOptionsRound[row]
    }
    
 func addGradientLayer() {
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
    @IBAction func btnAction(_ sender: Any) {
        let fromTextRoundTrip = roundTripFrom.text
        let toTextRoundTrip = roundTripTo.text
        
       if fromTextRoundTrip != nil && toTextRoundTrip != nil && fromTextRoundTrip == toTextRoundTrip
        {
            let alert = UIAlertController(title: "Error", message: "You can't travel  betweem same Origin and Destination points.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "roundTripToDisplay", sender: self)
        }
    }
    
     
}
