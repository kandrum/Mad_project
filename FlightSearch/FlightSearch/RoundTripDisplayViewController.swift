//
//  RoundTripDisplayViewController.swift
//  FlightSearch
//
//  Created by Poojitha on 10/20/23.
//

import UIKit

class RoundTripDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    struct FlightSearchResponse: Decodable {
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
        let tripId: String
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

    struct PaymentFee: Codable {
        let paymentMethodId: Int
        let currencyCode: String
        let amount: Double
        let amountUsd: Double
        let totalAmount: Double
        let totalAmountUsd: Double
        // Add other fields as needed
    }

    struct Price: Codable {
        let totalAmount: Double
        let totalAmountUsd: Double
        // Add other fields as needed
    }
    // To be used for populating the UI
    struct DisplayInfoRound {
        let totalAmount: String
        let departureRoute: String
        let returnRoute: String
        let departureAirline: String
        let returnAirline: String
        let stopoversOutbound: String
        let stopoversReturn: String
        let durationOutbound: String
        let durationReturn: String
    }
    
    var cabinClassRound: String?
    var fromLocationRound: String?
    var toLocationRound: String?
    var departureDateRound: Date?
    var ReturnDateRound: Date?
    
    @IBOutlet weak var roundTripTable: UITableView!
    
    var displayFlightInfoArrayRound: [DisplayInfoRound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFromAPI()
        addGradientLayer()
        roundTripTable.delegate = self
        roundTripTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    private func fetchFromAPI() {
            guard let URL = createRequestURL() else {
                print("Failed to create API request URL.")
                return
            }

            URLSession.shared.dataTask(with: URL) { [weak self] data, response, error in
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
                print(String(data: data, encoding: .utf8) ?? "Invalid JSON data")
    guard let flightInfoArray = self?.parseFlightInfoRound(data: data) else { return }

        DispatchQueue.main.async {
                    self?.displayFlightInfoArrayRound = flightInfoArray
                    self?.roundTripTable.reloadData()
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
        guard let cabinClassRound = cabinClassRound,
              let fromLocationRound = fromLocationRound,
              let toLocationRound = toLocationRound,
              let departureDateRound = departureDateRound,
              let returnDateRound = ReturnDateRound else {
            print("One or more required parameters are missing.")
            return nil
        }
        print("From Location: \(fromLocationRound), To Location: \(toLocationRound)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let departureDateString = dateFormatter.string(from: departureDateRound)
        let returnDateString = dateFormatter.string(from: returnDateRound)

        let urlString = "https://api.flightapi.io/roundtrip/65395e4d01b26894ef8d6f94/\(fromLocationRound)/\(toLocationRound)/\(departureDateString)/\(returnDateString)/1/0/1/\(cabinClassRound)/USD"
        
        print("Request URL: \(urlString)")
        
        return URL(string: urlString)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayFlightInfoArrayRound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roundcell", for: indexPath) as? RoundTripTableViewCell else {
            fatalError("Unable to dequeue RoundTripTableViewCell")
        }

        let flightInfo = displayFlightInfoArrayRound[indexPath.row]

        cell.currencyRound.text = flightInfo.totalAmount
        cell.fristTrip.text = flightInfo.departureRoute
        cell.secondTrip.text = flightInfo.returnRoute
        cell.firstAirlines.text = flightInfo.departureAirline
        cell.secondAirlines.text = flightInfo.returnAirline
        cell.firstStops.text = flightInfo.stopoversOutbound
        cell.secondStops.text = flightInfo.stopoversReturn
        cell.firstTotalDuration.text = flightInfo.durationOutbound
        cell.secondTotalDuration.text = flightInfo.durationReturn

        return cell   
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func parseFlightInfoRound(data: Data) -> [DisplayInfoRound]? {
        let decoder = JSONDecoder()
        
        // Attempt to decode the data into the FlightSearchResponse struct
        guard let searchResponse = try? decoder.decode(FlightSearchResponse.self, from: data) else {
            return nil
        }
        
        // Process the decoded data
        var displayInfoArray = [DisplayInfoRound]()
        
        // Assuming that there is always at least one trip and fare in the response
        let totalAmountUsd = searchResponse.fares.first?.price.totalAmountUsd ?? 0.0
        
        for trip in searchResponse.trips {
            for legId in trip.legIds {
                if let leg = searchResponse.legs.first(where: { $0.id == legId }) {
                    let departureRoute = "\(leg.departureAirportCode) - \(leg.arrivalAirportCode)"
                    let returnRoute = "\(leg.arrivalAirportCode) - \(leg.departureAirportCode)"
                    let departureAirline = leg.segments.first?.airlineCode ?? ""
                    let returnAirline = leg.segments.first?.airlineCode ?? ""
                    let stopoversOutbound = String(leg.stopoversCount)
                    let stopoversReturn = String(leg.stopoversCount)
                    let durationOutbound = leg.duration
                    let durationReturn = leg.duration
                    
                    let displayInfo = DisplayInfoRound(
                        totalAmount: String(format: "$%.2f", totalAmountUsd),
                        departureRoute: departureRoute,
                        returnRoute: returnRoute,
                        departureAirline: departureAirline,
                        returnAirline: returnAirline,
                        stopoversOutbound: stopoversOutbound,
                        stopoversReturn: stopoversReturn,
                        durationOutbound: durationOutbound,
                        durationReturn: durationReturn
                    )
                    
                    displayInfoArray.append(displayInfo)
                }
            }
        }
        
        return displayInfoArray
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
