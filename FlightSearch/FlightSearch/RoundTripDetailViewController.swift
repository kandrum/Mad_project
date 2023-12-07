//
//  RoundTripDetailViewController.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import UIKit

class RoundTripDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailroundtripcell", for: indexPath) as? RoundTripTableViewCell else {
            fatalError("Unable to dequeue RoundTripTableViewCell")
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
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
