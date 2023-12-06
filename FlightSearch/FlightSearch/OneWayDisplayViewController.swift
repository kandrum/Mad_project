//
//  OneWayDisplayViewController.swift
//  FlightSearch
//
//  Created by Tamma, Sri Nikesh Reddy on 10/25/23.
//

import UIKit

class OneWayDisplayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var selectedFlightInfo: DisplayFlightInfo?
    
//    struct FlightInfo: Codable {
//        let legs: [Leg]
//        let trips: [Trip]
//        let fares: [Fare]
//        let airlines: [Airline]
//        let airports: [Airport]
//        // Add other fields as needed
//    }
//    
//    struct Leg: Codable {
//        let id: String
//        let departureTime: String
//        let arrivalTime: String
//        let duration: String
//        let departureAirportCode: String
//        let arrivalAirportCode: String
//        let airlineCodes: [String]
//        let stopoverAirportCodes: [String]
//        let allianceCodes: [String]
//        let stopoversCount: Int
//        let segments: [Segment]
//        // Add other fields as needed
//    }
//    
//    struct Segment: Codable {
//        let durationMinutes: Int
//        let stopoverDurationMinutes: Int
//        let departureAirportCode: String
//        let arrivalAirportCode: String
//        let airlineCode: String
//        let cabin: String
//        let designatorCode: String
//        // Add other fields as needed
//    }
//    
//    struct Trip: Codable {
//        let id: String
//        let code: String
//        let legIds: [String]
//        // Add other fields as needed
//    }
//    
//    struct Fare: Codable {
//        let paymentFees: [PaymentFee]
//        let id: String
//        let price: Price
//        let tripId: String            // Add other fields as needed
//    }
//    
//    struct Airline: Codable {
//        let name: String
//        let code: String
//        // Add other fields as needed
//    }
//    
//    struct Airport: Codable {
//        let name: String
//        let code: String
//        let cityCode: String
//        // Add other fields as needed
//    }
//    
//    struct City: Codable {
//        let code: String
//        let name: String
//        // Add other fields as needed
//    }
//    
//    struct PaymentFee: Codable {
//        let paymentMethodId: Int
//        let currencyCode: String
//        let amount: Double
//        let amountUsd: Double
//        let totalAmount: Double
//        let totalAmountUsd: Double
//        // Add other fields as needed
//    }
//    
//    struct Price: Codable {
//        let totalAmount: Double
//        let totalAmountUsd: Double
//        // Add other fields as needed
//    }
    /* struct DisplayFlightInfo {
     let airlineName: String
     let stopoversCount: Int
     let totalDuration: String
     let totalAmountUsd: Double
     }*/
    
    var cabinClass: String?
    var fromLocation: String?
    var toLocation: String?
    var departureDate: Date?
    
    @IBOutlet weak var labelSortBy: UILabel!
    
    
    @IBOutlet weak var onewaydisplaytable: UITableView!
    
    var displayFlightInfoArray: [DisplayFlightInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromAPI()
        addGradientLayer()
        onewaydisplaytable.delegate = self
        onewaydisplaytable.dataSource = self
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
    
    private func fetchDataFromAPI() {
        guard let requestURL = createRequestURL() else {
            print("Failed to create API request URL.")
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    // Handle the error, e.g., show an alert to the user
                    self?.handleError(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    // Handle the no data case, e.g., show an error message to the user
                    self?.handleNoDataError()
                }
                return
            }
            
            // Parse the JSON data
            guard let flightInfoArray = self?.parseFlightInfo(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.displayFlightInfoArray = flightInfoArray
                self?.onewaydisplaytable.reloadData()
            }
        }.resume()
    }
    
    // Helper methods to handle different errors
    private func handleError(_ error: Error) {
        // Present an alert or update the UI to show the error
        print("Error fetching data: \(error.localizedDescription)")
    }
    
    private func handleNoDataError() {
        // Present an alert or update the UI to indicate no data was received
        print("No data received from the API.")
    }
    
    private func handleParsingError() {
        // Present an alert or update the UI to show that there was a parsing error
        print("Failed to parse flight information.")
    }
    
    private func createRequestURL() -> URL? {
        guard let cabinClass = cabinClass,
              let fromLocation = fromLocation,
              let toLocation = toLocation,
              let departureDate = departureDate else {
            print("One or more required parameters are missing.")
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let departureDateString = dateFormatter.string(from: departureDate)
        
        let urlString = "https://api.flightapi.io/onewaytrip/65395e4d01b26894ef8d6f94/\(fromLocation)/\(toLocation)/\(departureDateString)/1/0/0/\(cabinClass)/USD"
        
        return URL(string: urlString)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayFlightInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onewaycell", for: indexPath) as! OneWayDisplayTableViewCell
        
        let displayFlightInfo = displayFlightInfoArray[indexPath.row]
        cell.currency.text = String(format: "$%.2f", displayFlightInfo.totalAmountUsd)
        cell.stops.text = "\(displayFlightInfo.stopoversCount) Stops"
        cell.totalDuration.text = "\(displayFlightInfo.totalDuration)"
        cell.airlinesName.text = displayFlightInfo.airlineName
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFlightInfo = displayFlightInfoArray[indexPath.row]
        performSegue(withIdentifier: "oneWayDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "oneWayDetailSegue" {
            if let destinationVC = segue.destination as? OneWayDetailViewController {
                destinationVC.selectedFlightInfo = selectedFlightInfo
            }
        }
    }
    
    private func presentNoDetailsAlert() {
        let alert = UIAlertController(title: "No Details Available", message: "There are no flight details available for the selected departure and destination.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // Present an alert when there's an error
    private func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func parseFlightInfo(data: Data) -> [DisplayFlightInfo]? {
        do {
            let flightInfo = try JSONDecoder().decode(FlightInfo.self, from: data)
            
            guard !flightInfo.trips.isEmpty, !flightInfo.fares.isEmpty else {
                DispatchQueue.main.async {
                    self.presentNoDetailsAlert()
                }
                return nil
            }
            
            var displayFlightInfoArray: [DisplayFlightInfo] = []
            
            for trip in flightInfo.trips {
                guard let firstLegId = trip.legIds.first,
                      let leg = flightInfo.legs.first(where: { $0.id == firstLegId }) else {
                    continue
                }
                
                // let firstSegment = leg.segments.first
                let airlineCode = leg.segments.first?.airlineCode ?? "Unknown"
                let airline = flightInfo.airlines.first(where: { $0.code == airlineCode }) ?? Airline(name: "Unknown", code: "Unknown")
                
                let departureTime = leg.departureTime
                let totalDurationMinutes = leg.segments.reduce(0) { $0 + $1.durationMinutes }
                let hours = totalDurationMinutes / 60
                let minutes = totalDurationMinutes % 60
                let totalDuration = "\(hours)h \(minutes)m"
                let departureAirport = flightInfo.airports.first(where: { $0.code == leg.departureAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
                let layoverAirportCode = leg.stopoverAirportCodes.first ?? "Unknown"
                let layoverAirport = flightInfo.airports.first(where: { $0.code == layoverAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
                // Find the fare that matches the trip ID.
                if let fare = flightInfo.fares.first(where: { $0.tripId == trip.id }) {
                    let totalAmountUsd = fare.price.totalAmountUsd
                    let stopoversCount = leg.stopoverAirportCodes.count
                    let displayFlightInfo = DisplayFlightInfo(
                        airlineName: airline.name,
                        stopoversCount: stopoversCount,
                        totalDuration: totalDuration,
                        totalAmountUsd: totalAmountUsd,
                        departureAirport: departureAirport.name, 
                        departureTime: departureTime, 
                        layoverAirport: layoverAirport.name
                    )
                    displayFlightInfoArray.append(displayFlightInfo)
                } else {
                    print("No fare found for trip ID: \(trip.id)")
                }
            }
            
            return displayFlightInfoArray
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
        
    }
    
    @IBAction func filterByCheapest(_ sender: Any) {
        
        displayFlightInfoArray.sort { $0.totalAmountUsd < $1.totalAmountUsd }
        
        onewaydisplaytable.reloadData()
        
    }
    
    @IBAction func filterByLeastStops(_ sender: Any) {
        
        displayFlightInfoArray.sort { $0.stopoversCount < $1.stopoversCount }
        
        onewaydisplaytable.reloadData()
    }
    
    @IBAction func filterByAirlineName(_ sender: Any) {
        
        displayFlightInfoArray.sort { $0.airlineName < $1.airlineName }
        
        onewaydisplaytable.reloadData()
    }
    
    
    @IBAction func filterByShortestDuration(_ sender: Any) {
        
            displayFlightInfoArray.sort { $0.totalDuration < $1.totalDuration }

            onewaydisplaytable.reloadData()
        }

    
}



    
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


