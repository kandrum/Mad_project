//
//  OneWayDisplayViewController.swift
//  FlightSearch
//
//  Created by Tamma, Sri Nikesh Reddy on 10/25/23.
//

import UIKit

class OneWayDisplayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    struct FlightInfo: Codable {
        let legs: [Leg]
        let trips: [Trip]
        let fares: [Fare]
        let airlines: [Airline]
        let airports: [Airport]
        // Add other fields as needed
    }

    struct Leg: Codable {
        let id: String
        let departureTime: String
        let arrivalTime: String
        let duration: String
        let departureAirportCode: String
        let arrivalAirportCode: String
        let airlineCodes: [String]
        let stopoverAirportCodes: [String]
        let allianceCodes: [String]
        let stopoversCount: Int
        let segments: [Segment]
        // Add other fields as needed
    }

    struct Segment: Codable {
        let durationMinutes: Int
        let stopoverDurationMinutes: Int
        let departureAirportCode: String
        let arrivalAirportCode: String
        let airlineCode: String
        let cabin: String
        let designatorCode: String
        // Add other fields as needed
    }

    struct Trip: Codable {
        let id: String
        let code: String
        let legIds: [String]
        // Add other fields as needed
    }

    struct Fare: Codable {
        let paymentFees: [PaymentFee]
        let id: String
        let price: Price
        // Add other fields as needed
    }

    struct Airline: Codable {
        let name: String
        let code: String
        // Add other fields as needed
    }

    struct Airport: Codable {
        let name: String
        let code: String
        let cityCode: String
        // Add other fields as needed
    }

    struct City: Codable {
        let code: String
        let name: String
        // Add other fields as needed
    }

    struct PaymentFee: Codable {
        let paymentMethodId: Int
        let currencyCode: String
        let amount: Double
        // Add other fields as needed
    }

    struct Price: Codable {
        let totalAmount: Double
        let totalAmountUsd: Double
        // Add other fields as needed
    }
    struct DisplayFlightInfo {
        let airlineName: String
        let stopoversCount: Int
        let totalDuration: String
        let totalAmountUsd: Double
    }

    var cabinClass: String?
    var fromLocation: String?
    var toLocation: String?
    var departureDate: Date?
    
    @IBOutlet weak var onewaydisplaytable: UITableView!
    
   var displayFlightInfoArray: [DisplayFlightInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromAPI()
        
        onewaydisplaytable.delegate = self
        onewaydisplaytable.dataSource = self
        // Do any additional setup after loading the view.
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
            if let flightInfoArray = self?.parseFlightInfo(data: data) {
                self?.displayFlightInfoArray = flightInfoArray
                DispatchQueue.main.async {
                    self?.onewaydisplaytable.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    // Handle the parsing error, e.g., show an error message to the user
                    self?.handleParsingError()
                }
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
        cell.stops.text = "\(displayFlightInfo.stopoversCount) Stopovers"
        cell.totalDuration.text = "Total Duration: \(displayFlightInfo.totalDuration)"
        cell.airways.text = "Total Amount: $\(displayFlightInfo.airlineName)"

        return cell
    }
    private func parseFlightInfo(data: Data) -> [DisplayFlightInfo]? {
        do {
            let flightInfo = try JSONDecoder().decode(FlightInfo.self, from: data)
            var displayFlightInfoArray: [DisplayFlightInfo] = []

            for trip in flightInfo.trips {
                guard let firstLegId = trip.legIds.first,
                    let leg = flightInfo.legs.first(where: { $0.id == firstLegId }) else {
                        continue
                }

                let firstSegment = leg.segments.first
                let airlineCode = firstSegment?.airlineCode ?? "Unknown"

                let airline = flightInfo.airlines.first(where: { $0.code == airlineCode }) ?? Airline(name: "Unknown", code: "Unknown")

                let totalDurationMinutes = leg.segments.reduce(0) { $0 + ($1.durationMinutes) }
                let hours = totalDurationMinutes / 60
                let minutes = totalDurationMinutes % 60
                let totalDuration = "\(hours)h \(minutes)m"

                let fare = flightInfo.fares.first(where: { $0.id == trip.id })
                let totalAmountUsd = fare?.price.totalAmountUsd ?? 0.0

                // Convert the array of stopover airport codes to a single integer
                let stopoversCount = leg.stopoverAirportCodes.count

                let displayFlightInfo = DisplayFlightInfo(
                    airlineName: airline.name,
                    stopoversCount: leg.stopoverAirportCodes.count,
                    totalDuration: totalDuration,
                    totalAmountUsd: totalAmountUsd
                )

                displayFlightInfoArray.append(displayFlightInfo)
            }

            return displayFlightInfoArray
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
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

}
