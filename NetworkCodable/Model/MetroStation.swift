//
//  MetroStation.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import Foundation

struct Info: Decodable{
    var stations: [Station]
}

struct Station: Decodable{
    var name: String
    var id: String
    var lng: String
    var lat: String
}
