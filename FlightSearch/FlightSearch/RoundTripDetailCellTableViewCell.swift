//
//  RoundTripDetailCellTableViewCell.swift
//  FlightSearch
//
//  Created by Sai Poojitha Velivelli on 12/7/23.
//

import UIKit

class RoundTripDetailCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var airlines:UILabel!
    
    @IBOutlet weak var totalDuration:UILabel!
    
    @IBOutlet weak var departureAirport:UILabel!
    
    @IBOutlet weak var arrivalAirport:UILabel!
    
    @IBOutlet weak var departureTime:UILabel!
    
    @IBOutlet weak var arrivalTime:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
