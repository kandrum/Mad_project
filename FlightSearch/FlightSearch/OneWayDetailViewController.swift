//
//  OneWayDetailViewController.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import UIKit

class OneWayDetailViewController: UIViewController {
     
    var selectedFlightInfo: DisplayFlightInfo?
    
    
    @IBOutlet weak var airwayFirstFlight: UILabel!
    
    @IBOutlet weak var totalDuration: UILabel!
    
    @IBOutlet weak var departureAirport: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flightInfo = selectedFlightInfo{
            if selectedFlightInfo!.stopoversCount > 1 {
                airwayFirstFlight.text = selectedFlightInfo?.airlineName
                totalDuration.text = selectedFlightInfo?.totalDuration
                departureAirport.text = selectedFlightInfo?.departureAirport
                
            }
            //startAirport.text = selectedFlightInfo.
        }
        // Do any additional setup after loading the view.
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
