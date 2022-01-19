//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 02/01/2022.
//

import Foundation
import Vapor

struct Station: Content {
    
    public init(_ locationResponse: AVWXApi.LocationResponse) {
        city = locationResponse.station.city ?? ""
        country = locationResponse.station.country
        elevation = locationResponse.station.elevationFt
        iata = locationResponse.station.iata ?? ""
        icao = locationResponse.station.icao
        latitude = locationResponse.station.latitude
        longitude = locationResponse.station.longitude
        name = locationResponse.station.name
        reporting = locationResponse.station.reporting
        runways = locationResponse.station.runways
    }
    
    var city: String
    var country: String
    var elevation: Int
    var iata: String
    var icao: String
    var latitude: Double
    var longitude: Double
    var name: String
    var reporting: Bool
    var runways: [AVWXApi.Station.Runway]?
}

extension AVWXApi {
    struct LocationResponse: Content {
        var station: Station
        var coordinateDistance: Double
    }

    struct Station: Content {
        var city: String?
        var country: String
        var elevationFt: Int
        var elevationM: Int
        var iata: String?
        var icao: String
        var latitude: Double
        var longitude: Double
        var name: String
        var reporting: Bool
        var runways: [Runway]?
        var state: String
        var type: String
        
        struct Runway: Content {
            
            enum SurfaceType: String, Content {
                case asphalt = "asphalt", concrete = "concrete", gravel = "gravel", turf = "turf"
            }
            
            var lengthFt: Int
            var widthFt: Int
            var surface: SurfaceType?
            var lights: Bool
            var ident1: String
            var ident2: String
            var bearing1: Double?
            var bearing2: Double?
        }
    }
}
