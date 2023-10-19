//
//  MultiCityViewController.swift
//  FlightSearch
//
//  Created by Kandru, Mounika Preethi on 10/17/23.
//

import UIKit

class MultiCityViewController: UIViewController {
    
    @IBOutlet weak var FromMulti: UITextField!
    @IBOutlet weak var AddFlight: UIButton!
    @IBOutlet weak var ToMulti: UITextField!
    @IBOutlet weak var ReturnMulti: UIDatePicker!
    @IBOutlet weak var DepatureMulti: UIDatePicker!

    var yOffset: CGFloat = 300 // Starting point for dynamic elements, adjust accordingly
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        
        // Initialize and setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        view.addSubview(scrollView)
        
        // Add initial UI elements to the scrollView
        scrollView.addSubview(FromMulti)
        scrollView.addSubview(AddFlight)
        scrollView.addSubview(ToMulti)
        scrollView.addSubview(ReturnMulti)
        scrollView.addSubview(DepatureMulti)
        
        FromMulti.placeholder = "From"
        ToMulti.placeholder = "To"
        // Bring AddFlight button to front to ensure it's clickable
        scrollView.bringSubviewToFront(AddFlight)
        
        // Ensuring AddFlight button calls the function
        AddFlight.addTarget(self, action: #selector(AddFlight(_:)), for: .touchUpInside)
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
    
    @objc @IBAction func AddFlight(_ sender: Any) {
        let fromTextField = UITextField(frame: CGRect(x: 20, y: yOffset, width: scrollView.frame.width - 150, height: 40))
        fromTextField.placeholder = "From"
        fromTextField.borderStyle = .roundedRect
        scrollView.addSubview(fromTextField)

        yOffset += 50
            
        let toTextField = UITextField(frame: CGRect(x: 20, y: yOffset, width: scrollView.frame.width - 150, height: 40))
        scrollView.addSubview(toTextField)
            
        yOffset += 50
        toTextField.placeholder = "To"
        toTextField.borderStyle = .roundedRect
        
        let departureDatePickerWidth = scrollView.frame.width / 2
        let departureDatePicker = UIDatePicker(frame: CGRect(x: -80, y: yOffset, width: departureDatePickerWidth, height: 200))
        departureDatePicker.datePickerMode = .date
        scrollView.addSubview(departureDatePicker)
        
        // Return Date Picker
        let returnDatePickerXPosition = scrollView.frame.width / 3
        let returnDatePicker = UIDatePicker(frame: CGRect(x: returnDatePickerXPosition, y: yOffset, width: scrollView.frame.width / 2, height: 200))
        returnDatePicker.datePickerMode = .date
       
        scrollView.addSubview(returnDatePicker)
        
        yOffset += 100
        
        // Adjust the contentSize dynamically
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: yOffset + 50)
    }
    
}
