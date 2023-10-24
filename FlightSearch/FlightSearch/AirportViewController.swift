//
//  AirportViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/23/23.
//

import UIKit

class AirportViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    var airports: [Airport] = []
    struct Airport: Codable {
        let airport_name: String
    }

    struct AirportResponse: Codable {
        let data: [Airport]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        fetchAirports()
        addGradientLayer()

        // Do any additional setup after loading the view.
    }
    private func addGradientLayer() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds

            // Define your custom sky blue color
            let skyBlueColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0)

            gradientLayer.colors = [UIColor.white.cgColor, skyBlueColor.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

            // Remove any existing gradient layers
            view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

            // Add the gradient layer to the view's layer
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    func fetchAirports() {
        let urlString = "http://api.aviationstack.com/v1/airports?access_key=9fe77c03e6e9b6e5c9424f7cb3050aff"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching data:", error)
                return
            }

            if let data = data {
                do {
                    let airportResponse = try JSONDecoder().decode(AirportResponse.self, from: data)
                    self.airports = airportResponse.data
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                } catch {
                    print("Error decoding data:", error)
                }
            }
            
        }.resume()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let airport = airports[indexPath.row]
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AirportNameTableViewCell
            cell.airportName.text = airport.airport_name
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
