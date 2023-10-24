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
        let name: String
        let iata: String
        
        enum CodingKeys: String, CodingKey {
                case name
                case iata
            }
    }
    struct AirportResponse: Codable {
        let rows: [Airport]
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
        let url = URL(string: "https://flight-radar1.p.rapidapi.com/airports/list")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("64aae1ed6dmsh17bdb422aee544cp1dcfaejsn7e5847da9491", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("flight-radar1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data:", error)
                return
            }

            if let data = data {
                do {
                    // Decode the AirportResponse object
                    let response = try JSONDecoder().decode(AirportResponse.self, from: data)
                    self.airports = response.rows // Assign the array of airports to your airports array
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
        cell.airportName.text = airport.name
        cell.iata.text = airport.iata
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
