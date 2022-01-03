//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 02/01/2022.
//

import Foundation

extension AVWXApi {
    struct LocationResponse {
        var station: Station
        var coordinateDistance: Double
    }

    struct Station: Content {
        var city: String
        var country: String
        var elevationFt: Int
        var elevationM: Int
        var iata: String
        var icao: String
        var latitude: Double
        var longitude: Double
        var name: String
        var reporting: Boolean
        var runways: [Runway]
        var state: String
        var type: String
        
        
        struct Runway: Content {
            
            enum SurfaceType: String, Codable {
                case asphalt = "asphalt"
            }
            
            var lengthFt: Int
            var widthFt: Int
            var surface: SurfaceType
            var ligths: Bool
            var ident1: String
            var ident2: String
            var bearing1: Double
            var bearing2: Double
        }
    }
}
