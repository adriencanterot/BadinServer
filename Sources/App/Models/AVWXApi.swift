//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 30/12/2021.
//

import Foundation
import Vapor

final class AVWXApi: API {
    
    enum ApiError: Error {
        case noToken
    }
    
    var credentials: Credentials = Credentials(baseURI: URI(string: "https://avwx.rest/api/"), type: .token("YFYNuIeW0vIiNvjgdmAnAIx4RWTBJ6LJpvj0ALt276E"))
    
    
}
