//
//  AirportsTableViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/23/23.
//

import UIKit

class AirportsTableViewController: UITableViewController {
    var airports: [Airport] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        fetchAirports()
        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    struct AirportResponse: Codable {
        let data: [Airport]
    }

    struct Airport: Codable {
        let airport_name: String
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
                        print(String(data: data, encoding: .utf8) ?? "Data could not be printed");                        self.airports = airportResponse.data
                        print(self.airports)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.layoutIfNeeded()
                        }
                    } catch {
                        print("Error decoding data:", error)
                    }
                }
                
            }.resume()
        }
    // MARK: - Table view data source
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return airports.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath) as! AirportsTableViewCell
        cell.AirportName.text = airports[indexPath.row].airport_name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
