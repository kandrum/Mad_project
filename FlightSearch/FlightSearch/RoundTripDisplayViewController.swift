//
//  RoundTripDisplayViewController.swift
//  FlightSearch
//
//  Created by Poojitha on 10/20/23.
//

import UIKit

class RoundTripDisplayViewController: UIViewController {
    
    var cabinClassRound: String?
    var fromLocationRound: String?
    var toLocationRound: String?
    var departureDateRound: Date?
    var ReturnDateRound: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        // Do any additional setup after loading the view.
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

        let urlString = "https://api.flightapi.io/roundtrip/65395e4d01b26894ef8d6f94/\(fromLocationRound)/\(toLocationRound)/\(departureDateString)/\(returnDateString)/1/0/1/\(cabinClassRound)/USD"
        
        return URL(string: urlString)
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
