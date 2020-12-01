//
//  MetroStation.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import Foundation

struct Info: Codable{
    var lines: [Line]
}

struct Line: Codable{
    var name: String
    var stations: [Station]
}

struct Station: Codable{
    var id: String
    var name: String
    var lat: Float
    var lng: Float
}
