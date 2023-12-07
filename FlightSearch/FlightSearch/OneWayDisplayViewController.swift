//
//  OneWayDisplayViewController.swift
//  FlightSearch
//
//  Created by Tamma, Sri Nikesh Reddy on 10/25/23.
//

import UIKit

class OneWayDisplayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var selectedFlightInfo: DisplayFlightInfo?
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
        
        let urlString = "https://api.flightapi.io/onewaytrip/6570facdc6eb315e7eecc451/\(fromLocation)/\(toLocation)/\(departureDateString)/1/0/0/\(cabinClass)/USD"
        
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
                var arrivalTime = leg.arrivalTime
                let totalDurationMinutes = leg.segments.reduce(0) { $0 + $1.durationMinutes }
                let hours = totalDurationMinutes / 60
                let minutes = totalDurationMinutes % 60
                let totalDuration = "\(hours)h \(minutes)m"
                let departureAirport = flightInfo.airports.first(where: { $0.code == leg.departureAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
                let arrivalAirport = flightInfo.airports.first(where: { $0.code == leg.arrivalAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
                let layoverAirportCode = leg.stopoverAirportCodes.first ?? "Unknown"
                let layoverAirport = flightInfo.airports.first(where: { $0.code == layoverAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
        
                let layoverTime =  leg.segments[0].stopoverDurationMinutes
            let layoverAirport1ArrivalTime = extractTime(from:leg.segments[0].arrivalDateTime)
                var layoverAirport1DepartureTime = ""
                
                var secondStopAirport : Airport? = nil
                var secondLayoverDuration = ""
                var secondLayoverArrivalTime = ""
                var secondLayoverDepartureTime = ""
                if leg.segments.count >= 2 {
                    let secondStop = leg.segments[1]  // Index 1 corresponds to the second stop
             
                    let secondStopAirportCode = secondStop.arrivalAirportCode
                    secondLayoverDuration = convertMinutesToHoursAndMinutes(minutes: secondStop.stopoverDurationMinutes)
                    secondStopAirport = flightInfo.airports.first(where: { $0.code == secondStopAirportCode }) ?? Airport(name: "Unknown", code: "Unknown", cityCode: "Unknown")
                    secondLayoverArrivalTime = extractTime(from: leg.segments[0].arrivalDateTime) ?? "12:56"
                    secondLayoverDepartureTime = extractTime(from: secondStop.departureDateTime) ?? "6:34"
                    layoverAirport1DepartureTime = extractTime(from: leg.segments[1].arrivalDateTime) ?? "8:34"
                    print("Second Stop Airport Code: \(arrivalAirport.name)")

                }
                
                if(leg.stopoversCount == 1)
                {
                    arrivalTime = leg.arrivalTime
                }
                
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
                        layoverAirport: layoverAirport.name,
                        arrivalAirport: arrivalAirport.name,
                        arrivalTime: arrivalTime,
                        layoverDuration: convertMinutesToHoursAndMinutes(minutes: layoverTime),
                        layoverAirport1ArrivalTime: layoverAirport1ArrivalTime ?? "",
                        layoverAirport1DepartureTime: layoverAirport1DepartureTime ?? "", secondlayoverAirport: secondStopAirport?.name ?? "",
                        secondLayoverDuration: secondLayoverDuration,
                        secondLayoverArrivalTime: secondLayoverArrivalTime,
                        secondLayoverDepartureTime: secondLayoverDepartureTime
                        
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
    
    func convertMinutesToHoursAndMinutes(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        return "\(hours)h \(remainingMinutes)m"
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


func extractTime(from dateTimeString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    if let dateTime = dateFormatter.date(from: dateTimeString) {
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: dateTime)
        return time
    } else {
        print("Error parsing date")
        return nil
    }
}
    
