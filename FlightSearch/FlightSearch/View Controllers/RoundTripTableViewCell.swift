//
//  RoundTripTableViewCell.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 11/18/23.
//

import UIKit

class RoundTripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyRound: UILabel!
    @IBOutlet weak var fristTrip: UILabel!
    @IBOutlet weak var secondTrip: UILabel!
    @IBOutlet weak var firstAirlines: UILabel!
    @IBOutlet weak var secondAirlines: UILabel!
    @IBOutlet weak var firstStops: UILabel!
    @IBOutlet weak var secondStops: UILabel!
    @IBOutlet weak var firstTotalDuration: UILabel!
    @IBOutlet weak var secondTotalDuration:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
