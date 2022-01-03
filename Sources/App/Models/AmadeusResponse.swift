//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 25/12/2021.
//

import Foundation
import Vapor

enum AmadeusResponse {
    struct Data<T: Content>: Content {
        var data: T
    }
}
struct Airport: Content {
    
    public init(from amadeusAirport: AmadeusResponse.Airport) {
        self.name = amadeusAirport.name
        self.detailedName = amadeusAirport.detailedName
        self.longitude = amadeusAirport.geoCode.longitude
        self.latitude = amadeusAirport.geoCode.latitude
    }
    
    var name: String
    var detailedName: String
    var longitude: Double
    var latitude: Double
}

extension AmadeusResponse {
    
    
    struct Airport: Content {
        var name: String
        var detailedName: String
        var distance: Distance
        var geoCode: GeoCode
        
        struct Distance: Content {
            var value: Int
            var unit: Unit
            
            enum Unit: String, Content {
                case kilometers = "KM"
            }
        }
        
        struct GeoCode: Content {
            var latitude: Double
            var longitude: Double
        }
    }
}

