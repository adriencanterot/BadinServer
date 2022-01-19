//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 30/12/2021.
//

import Foundation
import Vapor


struct METAR: Content {
    var raw: String
    var altimeter: Altimeter
    var clouds: [Cloud]
    var time: METARDate
    var temperature: Temperature
    var dewpoint: Temperature
    var windGust: WindGust?
    var windDirection: WindDirection?
    var windSpeed: WindSpeed?
        
    struct WindDirection: Content {
        var value: Int?
    }
        
    struct WindGust: Content {
        var value: String
    }
        
    struct WindSpeed: Content {
        var value: Int
    }
        
    struct Altimeter: Content {
        var value: Int
    }
    
    struct Visibility: Content {
        var value: String
    }
    
    struct Cloud: Content {
        var type: CloudType
        var modifier: String?
        var altitude: Int
        
        enum CloudType: String, Content {
            case few = "FEW"
            case scattered = "SCT"
            case broken = "BKN"
            case overcast = "OVC"
        }
    }
    
    struct METARDate: Content {
        var date: String
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
        }
    }
    
    struct Temperature: Content {
        var value: Int
    }
}
