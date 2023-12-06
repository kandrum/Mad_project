//
//  Model.swift
//  FlightSearch
//
//  Created by Velivelli, Sai Poojitha on 11/27/23.
//

import Foundation
import UIKit

struct DisplayFlightInfo {
    let airlineName: String
    let stopoversCount: Int
    let totalDuration: String
    let totalAmountUsd: Double
    let departureAirport: String
    let departureTime : String
    let layoverAirport : String
    let arrivalAirport: String
    let arrivalTime: String
    let layoverDuration: String
}

struct FlightInfo: Codable {
    let legs: [Leg]
    let trips: [Trip]
    let fares: [Fare]
    let airlines: [Airline]
    let airports: [Airport]
    // Add other fields as needed
}

struct Leg: Codable {
    let id: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let departureAirportCode: String
    let arrivalAirportCode: String
    let airlineCodes: [String]
    let stopoverAirportCodes: [String]
    let allianceCodes: [String]
    let stopoversCount: Int
    let stopoverDuration: String
    let segments: [Segment]
    // Add other fields as needed
}

struct Segment: Codable {
    let durationMinutes: Int
    let stopoverDurationMinutes: Int
    let departureAirportCode: String
    let arrivalAirportCode: String
    let airlineCode: String
    let cabin: String
    let designatorCode: String
    // Add other fields as needed
}

struct Trip: Codable {
    let id: String
    let code: String
    let legIds: [String]
    // Add other fields as needed
}

struct Fare: Codable {
    let paymentFees: [PaymentFee]
    let id: String
    let price: Price
    let tripId: String            // Add other fields as needed
}

struct Airline: Codable {
    let name: String
    let code: String
    // Add other fields as needed
}

struct Airport: Codable {
    let name: String
    let code: String
    let cityCode: String
    // Add other fields as needed
}

struct City: Codable {
    let code: String
    let name: String
    // Add other fields as needed
}

struct PaymentFee: Codable {
    let paymentMethodId: Int
    let currencyCode: String
    let amount: Double
    let amountUsd: Double
    let totalAmount: Double
    let totalAmountUsd: Double
    // Add other fields as needed
}

struct Price: Codable {
    let totalAmount: Double
    let totalAmountUsd: Double
    // Add other fields as needed
}
