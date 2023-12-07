//
//  RoundTripDetailViewController.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import UIKit

class RoundTripDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var selectFlight:DisplayInfoRound?
    
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
        let selectedFlightRoundTrip = [indexPath.row]
        performSegue(withIdentifier: "selectedroudtripdetailsegue", sender: self)
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
