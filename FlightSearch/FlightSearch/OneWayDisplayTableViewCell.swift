//
//  OneWayDisplayTableViewCell.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 11/9/23.
//

import UIKit

class OneWayDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var airways: UILabel!
    @IBOutlet weak var stops: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
