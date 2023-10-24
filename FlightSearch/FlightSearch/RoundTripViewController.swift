//
//  RoundTripViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class RoundTripViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var roundTripFrom: UITextField!
    
    @IBOutlet weak var roundTripTo: UITextField!
    @IBOutlet weak var roundTripDepartureDate: UIDatePicker!
    @IBOutlet weak var roundTripSearchButton: UIButton!
    
    @IBOutlet weak var roundTripReturnDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTripFrom.placeholder = "From"
        roundTripTo.placeholder = "To"
        roundTripFrom.delegate=self
        roundTripTo.delegate=self
        addGradientLayer()
            // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == roundTripFrom || textField == roundTripTo {
            performSegue(withIdentifier: "AirportSuggestionSegue", sender: self)
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
    @IBAction func btnAction(_ sender: Any) {
        performSegue(withIdentifier: "roundTripToDisplay", sender: self)
    }
    /* func fetchAirports() {
     let url = URL(string: "https://flight-radar1.p.rapidapi.com/airports/list")!
     var request = URLRequest(url: url)
     request.httpMethod = "GET"
     request.addValue("64aae1ed6dmsh17bdb422aee544cp1dcfaejsn7e5847da9491", forHTTPHeaderField: "X-RapidAPI-Key")
     request.addValue("flight-radar1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
     
     URLSession.shared.dataTask(with: request) { (data, response, error) in
     if let error = error {
     print("Error fetching data:", error)
     return
     }
     
     if let data = data {
     do {
     // Decode the AirportResponse object
     let response = try JSONDecoder().decode(AirportResponse.self, from: data)
     self.airports = response.rows // Assign the array of airports to your airports array
     DispatchQueue.main.async {
     self.table.reloadData()
     }
     } catch {
     print("Error decoding data:", error)
     }
     }
     }.resume()
     } */
     
     }
