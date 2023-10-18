//
//  FlightDetailViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class FlightDetailViewController: UIView {
    
    @IBOutlet weak var From: UITextField!
    @IBOutlet weak var Return: UIDatePicker!
    @IBOutlet weak var Depature: UIDatePicker!
    @IBOutlet weak var To: UITextField!
    
    class func instanceFromNib() -> FlightDetailViewController{
        return UINib(nibName: "FlightDetailViewControllers", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FlightDetailViewController
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func addFlightFields() {
        let fromField = UITextField()
        fromField.placeholder = "From"
        // Set the frame for the 'fromField'
        
        let toField = UITextField()
        toField.placeholder = "To"
        // Set the frame for the 'toField'
        
        let departurePicker = UIDatePicker()
        // Set the frame for the 'departurePicker'
        
        let returnPicker = UIDatePicker()
        // Set the frame for the 'returnPicker'
        
        // Add the fields to the view
        addSubview(fromField)
        addSubview(toField)
        addSubview(departurePicker)
        addSubview(returnPicker)
    }
}
