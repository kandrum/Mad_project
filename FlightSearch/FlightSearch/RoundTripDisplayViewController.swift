//
//  RoundTripDisplayViewController.swift
//  FlightSearch
//
//  Created by Poojitha on 10/20/23.
//

import UIKit

class RoundTripDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var selectedFlightInfo: DisplayInfoRound?
    
//    struct FlightSearchResponse: Decodable {
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
//        let tripId: String
//        // Add other fields as needed
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
//    // To be used for populating the UI
//    struct DisplayInfoRound {
//        let totalAmount: String
//        let departureRoute: String
//        let returnRoute: String
//        let departureAirline: String
//        let returnAirline: String
//        let stopoversOutbound: String
//        let stopoversReturn: String
//        let durationOutbound: String
//        let durationReturn: String
//    }
    
    var cabinClassRound: String?
    var fromLocationRound: String?
    var toLocationRound: String?
    var departureDateRound: Date?
    var ReturnDateRound: Date?
    
    @IBOutlet weak var roundTripTable: UITableView!
    
    @IBOutlet weak var labelSortByForRoundTrip: UILabel!
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
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let departureDateString = dateFormatter.string(from: departureDateRound)
        let returnDateString = dateFormatter.string(from: returnDateRound)
        
        let urlString = "https://api.flightapi.io/roundtrip/657140382b921b5e70890adc/\(fromLocationRound)/\(toLocationRound)/\(departureDateString)/\(returnDateString)/1/0/1/\(cabinClassRound)/USD"
        
        
        
        return URL(string: urlString)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFlightInfo = displayFlightInfoArrayRound[indexPath.row]
       performSegue(withIdentifier: "roundTripDetailsSegue", sender: self)
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
        cell.firstStops.text = "\(flightInfo.stopoversOutbound)Stops"
        cell.secondStops.text = "\(flightInfo.stopoversReturn)Stops"
        cell.firstTotalDuration.text = flightInfo.durationOutbound
        cell.secondTotalDuration.text = flightInfo.durationReturn
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func parseFlightInfoRound(data: Data) -> [DisplayInfoRound]? {
        let decoder = JSONDecoder()
        guard let searchResponse = try? decoder.decode(FlightSearchResponse.self, from: data) else {
            return nil
        }
        
        var displayInfoArray = [DisplayInfoRound]()
        
        for trip in searchResponse.trips {
            // Assuming there are always exactly two legIds per trip, one for outbound and one for return
            let outboundLegId = trip.legIds[0]
            let returnLegId = trip.legIds[1]
            
            guard let outboundLeg = searchResponse.legs.first(where: { $0.id == outboundLegId }),
                  let returnLeg = searchResponse.legs.first(where: { $0.id == returnLegId }),
                  let fare = searchResponse.fares.first(where: { $0.tripId == trip.id }) else {
                continue
            }
            
            let totalAmountUsd = fare.price.totalAmountUsd
            let outboundDepartureTime = outboundLeg.departureTime
            let outboundArrivalTime = outboundLeg.arrivalTime
            let returnDepartureTime = returnLeg.departureTime
            let returnArrivalTime = returnLeg.arrivalTime
            
            let firstSegment = outboundLeg.segments.first
            let airlineCode =  outboundLeg.segments.first?.airlineCode ?? "Unknown"
            let outboundAirlineName = searchResponse.airlines.first(where: { $0.code == airlineCode }) ?? Airline(name: "Unknown", code: "Unknown")
            
            
            let secondSegment = returnLeg.segments.first
            let airlineCode1 =  returnLeg.segments.first?.airlineCode ?? "Unknown"
            let returnAirlineName = searchResponse.airlines.first(where: { $0.code == airlineCode1 }) ?? Airline(name: "Unknown", code: "Unknown")
            
            
            let displayInfo = DisplayInfoRound(
                totalAmount: String(format: "$%.2f", totalAmountUsd),
                departureRoute: "\(outboundLeg.departureAirportCode) - \(outboundLeg.arrivalAirportCode)",
                returnRoute: "\(returnLeg.departureAirportCode) - \(returnLeg.arrivalAirportCode)",
                departureAirline: outboundAirlineName.name,
                returnAirline: returnAirlineName.name,
                stopoversOutbound: String(outboundLeg.stopoversCount),
                stopoversReturn: String(returnLeg.stopoversCount),
                durationOutbound: outboundLeg.duration,
                durationReturn: returnLeg.duration,
                outboundDepartureTime: outboundDepartureTime,
                outboundArrivalTime: outboundArrivalTime,
                returnDepartureTime: returnDepartureTime,
                returnArrivalTime: returnArrivalTime
            )
            
            displayInfoArray.append(displayInfo)
        }
        
        return displayInfoArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "roundTripDetailsSegue"){
            if let roundTripDetailsVC = segue.destination as? RoundTripDetailViewController ,let selectedIndexPath = roundTripTable.indexPathForSelectedRow {
                let selectedRoundTrip = displayFlightInfoArrayRound[selectedIndexPath.row]
                roundTripDetailsVC.selectFlight = selectedFlightInfo
                
            }
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
    
    @IBAction func filterByCheapestPrice(_ sender: Any) {
        
        displayFlightInfoArrayRound.sort { Double($0.totalAmount.replacingOccurrences(of: "$", with: "")) ?? 0 < Double($1.totalAmount.replacingOccurrences(of: "$", with: "")) ?? 0 }
        
        roundTripTable.reloadData()
    }
    
    @IBAction func filterByLeastStopsRoundTrip(_ sender: Any) {
        
        displayFlightInfoArrayRound.sort { ($0.stopoversOutbound + $0.stopoversReturn) < ($1.stopoversOutbound + $1.stopoversReturn) }
        
        roundTripTable.reloadData()
        
    }
    
    @IBAction func filterByAirlineNameRoundTrip(_ sender: Any) {
        
            displayFlightInfoArrayRound.sort { ($0.departureAirline, $0.returnAirline) < ($1.departureAirline, $1.returnAirline) }

            roundTripTable.reloadData()
        }

    @IBAction func filterByShortestDuration(_ sender: Any) {
        
       
            displayFlightInfoArrayRound.sort { ($0.durationOutbound + $0.durationReturn) < ($1.durationOutbound + $1.durationReturn) }

            
            roundTripTable.reloadData()
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
