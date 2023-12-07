//
//  RoundTripModel.swift
//  FlightSearch
//
//  Created by Sai Poojitha Velivelli on 12/6/23.
//

import Foundation

struct FlightSearchResponse: Decodable {
    let legs: [Leg]
    let trips: [Trip]
    let fares: [Fare]
    let airlines: [Airline]
    let airports: [Airport]
    // Add other fields as needed
}


// To be used for populating the UI
struct DisplayInfoRound {
    let totalAmount: String
    let departureRoute: String
    let returnRoute: String
    let departureAirline: String
    let returnAirline: String
    let stopoversOutbound: String
    let stopoversReturn: String
    let durationOutbound: String
    let durationReturn: String
}
