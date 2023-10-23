//
//  AirportsTableViewCell.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/23/23.
//

import UIKit

class AirportsTableViewCell: UITableViewCell {

    @IBOutlet weak var AirportName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
