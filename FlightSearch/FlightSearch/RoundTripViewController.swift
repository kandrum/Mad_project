
//
//  RoundTripViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class RoundTripViewController: UIViewController, UITextFieldDelegate,AirportSelectionDelegate {

    
    @IBOutlet weak var roundTripFrom: UITextField!
    
    @IBOutlet weak var roundTripTo: UITextField!
    @IBOutlet weak var roundTripDepartureDate: UIDatePicker!
    @IBOutlet weak var roundTripSearchButton: UIButton!
    
    @IBOutlet weak var roundTripReturnDate: UIDatePicker!
    
    var selectedAirport:UITextField?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        roundTripTo.resignFirstResponder()
        roundTripFrom.resignFirstResponder()
    }

    func airportSelected(_ airport: AirportViewController.Airport, forType: FlightType) {
        selectedAirport?.text = airport.name

    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "AirportSuggestionSegue" {
            if let airportVC = segue.destination as? AirportViewController {
                airportVC.delegate = self
                airportVC.flightType = selectedAirport == roundTripFrom ? .from : .to
            }
        }    }
    
    @IBAction func typeFromAirport(_ sender: UITextField) {
        selectedAirport = sender
        if(sender == roundTripFrom){
            performSegue(withIdentifier: "AirportSuggestionSegue", sender: roundTripFrom)
        }
    }
    
    @IBAction func typeToAirport(_ sender: UITextField) {
        selectedAirport = sender
        if(sender == roundTripTo){
            performSegue(withIdentifier: "AirportSuggestionSegue", sender: roundTripFrom)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTripFrom.placeholder = "From"
        roundTripTo.placeholder = "To"
        roundTripFrom.delegate=self
        roundTripTo.delegate=self
        roundTripDepartureDate.minimumDate = Date()
        roundTripReturnDate.minimumDate = Date()
        roundTripDepartureDate.addTarget(self, action: #selector(departureDateChanged), for: .valueChanged)
        addGradientLayer()
            // Do any additional setup after loading the view.
    }
    
    @objc func departureDateChanged() {
        let selectedDepartureDate = roundTripDepartureDate.date
        roundTripReturnDate.minimumDate = selectedDepartureDate
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
