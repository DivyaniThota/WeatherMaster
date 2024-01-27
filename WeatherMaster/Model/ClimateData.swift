//
//  ClimateData.swift
//  WeatherMaster
//
//  Created by DIVYANI PRASAD THOTA on 26/01/24.
//

import Foundation

struct ClimateData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
