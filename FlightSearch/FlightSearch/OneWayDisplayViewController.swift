//
//  OneWayDisplayViewController.swift
//  FlightSearch
//
//  Created by Tamma, Sri Nikesh Reddy on 10/25/23.
//

import UIKit

class OneWayDisplayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    var cabinClass: String?
    var fromLocation: String?
    var toLocation: String?
    var departureDate: Date?
    
    @IBOutlet weak var onewaydisplaytable: UITableView!
    
    struct FlightInfo {
        let airlineName: String
        let stopoversCount: Int
        let totalDuration: String
        let totalAmountUsd: Double
    }
    var flightInfoArray: [FlightInfo] = []
    
    
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
                self?.flightInfoArray = flightInfoArray
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
        return flightInfoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onewaycell", for: indexPath) as! OneWayDisplayTableViewCell

        let flightInfo = flightInfoArray[indexPath.row]
        cell.currency.text = "\(flightInfo.airlineName)"
        cell.stops.text = "\(flightInfo.stopoversCount) Stopovers"
        cell.totalDuration.text = "Total Duration: \(flightInfo.totalDuration)"
        cell.airways.text = "Total Amount: $\(flightInfo.totalAmountUsd)"

        return cell
    }
    private func parseFlightInfo(data: Data) -> [FlightInfo]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = jsonObject as? [String: Any],
                  let tripsArray = jsonDict["trips"] as? [[String: Any]] else {
                return nil
            }

            var flightInfoArray: [FlightInfo] = []

            for trip in tripsArray {
                if let airlineName = trip["airlineName"] as? String,
                   let legs = trip["legs"] as? [[String: Any]],
                   let faresArray = jsonDict["fares"] as? [[String: Any]],
                   let firstFare = faresArray.first(where: { $0["tripId"] as? String == trip["id"] as? String }),
                   let priceDict = firstFare["price"] as? [String: Any],
                   let totalAmountUsd = priceDict["totalAmountUsd"] as? Double {

                    let stopoversCount = legs.count - 1
                    let totalDuration = calculateTotalDuration(from: legs)

                    let flightInfo = FlightInfo(airlineName: airlineName,
                                                stopoversCount: stopoversCount,
                                                totalDuration: totalDuration,
                                                totalAmountUsd: totalAmountUsd)
                    flightInfoArray.append(flightInfo)
                }
            }

            return flightInfoArray
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }

    private func calculateTotalDuration(from legs: [[String: Any]]) -> String {
        var totalMinutes = 0
        for leg in legs {
            if let durationString = leg["duration"] as? String {
                let components = durationString.split(separator: " ")
                if components.count == 2 {
                    let hours = Int(components[0].dropLast()) ?? 0
                    let minutes = Int(components[1].dropLast()) ?? 0
                    totalMinutes += (hours * 60) + minutes
                }
            }
        }
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
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
