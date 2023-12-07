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
    let outboundDepartureTime: String
    let outboundArrivalTime: String
    let returnDepartureTime: String
    let returnArrivalTime:String
    let outboundDepartureAirport: String
    let outboundArrivalAirport:String
    let returnDepartureAirport: String
    let returnArrivalAirport:String
    let outboundfirstLayoverDuration:String
    let outboundfirstLayoverAirport:String
    let outboundfirstLayoverArrivalTime: String
    let outboundfirstLayoverDepartureTime: String
    let outboundsecondLayoverDuration:String
    let outboundsecondLayoverAirport: String
    let outboundsecondLayoverArrivalTime: String
    let outboundsecondLayoverDepartureTime: String
    let returnfirstLayoverDuration:String
    let returnfirstLayoverAirport: String
    let returnfirstLayoverArrivalTime:String
    let returnfirstlayoverDepartureTime:String
    let returnsecondLayoverAirport: String
    let returnSecondLayoverDuration:String
    let returnSecondLayoverArrivalTime:String
    let returnSecondlayoverDepartureTime:String
}
