//
//  RoundTripDetailViewController.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import UIKit

class RoundTripDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var selectFlight:DisplayInfoRound?
    
    var firstselectedFlight: DisplayFlightInfo?
    
    var secondselectedFlight: DisplayFlightInfo?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailroundtripcell", for: indexPath) as? RoundTripDetailCellTableViewCell else {
            fatalError("Unable to dequeue RoundTripTableViewCell")
        }
        if((indexPath.row) == 0)
        {
            cell.airlines.text = selectFlight?.departureAirline
            cell.totalDuration.text = selectFlight?.durationOutbound
            cell.departureTime.text = selectFlight?.outboundDepartureTime
            cell.arrivalTime.text = selectFlight?.outboundArrivalTime
            cell.departureAirport.text = selectFlight?.outboundDepartureAirport
            cell.arrivalAirport.text = selectFlight?.outboundArrivalAirport
        }
        else
        {
            cell.airlines.text = selectFlight?.returnAirline
            cell.totalDuration.text = selectFlight?.durationReturn
            cell.departureTime.text = selectFlight?.returnDepartureTime
            cell.arrivalTime.text = selectFlight?.returnArrivalTime
            cell.departureAirport.text = selectFlight?.returnDepartureAirport
            cell.arrivalAirport.text = selectFlight?.returnArrivalAirport
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            
            let totalAmountDouble = selectFlight!.totalAmount
            let totalAmount = Double(totalAmountDouble)
            firstselectedFlight = DisplayFlightInfo(airlineName: selectFlight?.departureAirline ?? "",
                stopoversCount: selectFlight?.stopoversOutbound ?? "1",
                totalDuration: selectFlight?.durationOutbound ?? "12h",
                                                    totalAmountUsd:  totalAmount ?? 1782.45,
                                                    departureAirport: selectFlight?.outboundDepartureAirport ?? "Unknown",
                                                    departureTime: selectFlight?.outboundDepartureTime ?? "12:45",
                                                    layoverAirport: selectFlight?.outboundfirstLayoverAirport ?? "Unknown",
                                                    arrivalAirport: selectFlight?.outboundArrivalAirport ?? "Unknown",
                                                    arrivalTime: selectFlight?.outboundArrivalTime ?? "3:46",
                                                    layoverDuration: selectFlight?.outboundfirstLayoverDuration ?? "4h",
                                                    layoverAirport1ArrivalTime: selectFlight?.outboundfirstLayoverArrivalTime ?? "3:45",
                                                    layoverAirport1DepartureTime: selectFlight?.outboundfirstLayoverDepartureTime ?? "11:45",
                                                    secondlayoverAirport: selectFlight?.outboundsecondLayoverAirport ?? "Unknown",
                                                    secondLayoverDuration: selectFlight?.outboundsecondLayoverDuration ?? "3h 13m",
                                                    secondLayoverArrivalTime: selectFlight?.outboundsecondLayoverArrivalTime ?? "1:23",
                                                    secondLayoverDepartureTime: selectFlight?.outboundsecondLayoverDepartureTime ?? "4:34"
             )
            
        }
        else
        {
            let totalAmountDouble = selectFlight!.totalAmount
            let totalAmount = Double(totalAmountDouble)
            firstselectedFlight = DisplayFlightInfo(airlineName: selectFlight?.returnAirline ?? "",
                stopoversCount: selectFlight?.stopoversReturn ?? "1",
                totalDuration: selectFlight?.durationReturn ?? "12h",
                totalAmountUsd:  totalAmount ?? 2343.89,
                                                    departureAirport: selectFlight?.returnDepartureAirport ?? "Unknown",
                                                    departureTime: selectFlight?.returnDepartureTime ?? "12:45",
                                                    layoverAirport: selectFlight?.returnfirstLayoverAirport ?? "Unknown",
                                                    arrivalAirport: selectFlight?.returnArrivalAirport ?? "Unknown",
                                                    arrivalTime: selectFlight?.returnArrivalTime ?? "3:46",
                                                    layoverDuration: selectFlight?.returnfirstLayoverDuration ?? "4h",
                                                    layoverAirport1ArrivalTime: selectFlight?.returnfirstLayoverArrivalTime ?? "5:45",
                                                    layoverAirport1DepartureTime: selectFlight?.returnfirstlayoverDepartureTime ?? "1:34",
                                                    secondlayoverAirport: selectFlight?.returnsecondLayoverAirport ?? "Unknown",
                                                    secondLayoverDuration: selectFlight?.returnSecondLayoverDuration ?? "2h 12m",
                                                    secondLayoverArrivalTime: selectFlight?.returnSecondLayoverArrivalTime ?? "2:34",
                                                    secondLayoverDepartureTime: selectFlight?.returnSecondlayoverDepartureTime ?? "4:23"
             )
        }
        performSegue(withIdentifier: "selectedroudtripdetailsegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectedroudtripdetailsegue"){
            if let roundTripSelectDetailsVC = segue.destination as? RoundTripSelectedDetailViewController  {
                roundTripSelectDetailsVC.selectFlight = firstselectedFlight
                //roundTripSelectDetailsVC.selectFlight = firstselectedFlight
                
            }
        }
    }
    
    
    
    @IBOutlet weak var roundTripTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTripTable.delegate = self
        roundTripTable.dataSource = self
        addGradientLayer()
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
    
    
}
