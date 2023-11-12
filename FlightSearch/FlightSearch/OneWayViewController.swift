//
//  OneWayViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//
import UIKit

class OneWayViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, AirportSelectionDelegate {
    
    @IBOutlet weak var cabin: UITextField!
    @IBOutlet weak var oneWayFrom: UITextField!
    @IBOutlet weak var oneWayTo: UITextField!
    @IBOutlet weak var oneWayDepartureDate: UIDatePicker!
    
    var selectedAirport: UITextField?
    let cabinPicker = UIPickerView()
    let cabinOptions = ["Economy", "Business", "First", "Premium Economy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneWayFrom.placeholder = "From"
        oneWayTo.placeholder = "To"
        cabin.placeholder = "cabinclass"
        oneWayDepartureDate.minimumDate = Date()
        oneWayFrom.delegate = self
        oneWayTo.delegate = self
        cabin.delegate = self
        
        // Setup the picker view for cabin class
        cabinPicker.delegate = self
        cabinPicker.dataSource = self
        cabin.inputView = cabinPicker

        // Add toolbar with Done button to cabin picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        cabin.inputAccessoryView = toolBar
        
        // Add gradient layer
        addGradientLayer()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.placeholder == "From" || textField.placeholder == "To"{
            selectedAirport = textField
            performSegue(withIdentifier: "oneWayAiportSegue", sender: self)
            return false // Prevents keyboard from appearing
        }
        return true
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    // Implement UIPickerView DataSource and Delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cabinOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cabinOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cabin.text = cabinOptions[row]
    }
    @IBAction func searchBtn(_ sender: Any) {
        let fromTextOneWay = oneWayFrom.text
        let toTextOneWay = oneWayTo.text
        if fromTextOneWay != nil && toTextOneWay != nil && fromTextOneWay == toTextOneWay
        {
            let alert = UIAlertController(title: "Error", message: "You can't travel  betweem same Origin and Destination points.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "oneWayToDisplay", sender: self)
        }
    }
    
    
    func airportSelected(_ airport: AirportViewController.Airport, forType: FlightType) {
        selectedAirport?.text = airport.iata
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue: \(segue.identifier ?? "Unknown")")
        if segue.identifier == "oneWayAiportSegue" {
            if let airportVC = segue.destination as? AirportViewController {
                airportVC.delegate = self
                airportVC.flightType = selectedAirport == oneWayFrom ? .from : .to
            }
        }
        else if segue.identifier == "oneWayToDisplay" {
               if let displayVC = segue.destination as? OneWayDisplayViewController {
                   displayVC.cabinClass = cabin.text
                   displayVC.fromLocation = oneWayFrom.text
                   displayVC.toLocation = oneWayTo.text
                   displayVC.departureDate = oneWayDepartureDate.date
               }
           }
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
}

