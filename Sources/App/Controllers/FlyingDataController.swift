//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 30/12/2021.
//

import Foundation
import Vapor
import Fluent

struct FlyingDataController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let flyingDataRoutes = routes.grouped("flyingData")
        flyingDataRoutes.get(":code", use: metar)
        
    }
    
    func metar(req: Request) async throws -> METAR {
        guard let airportCode = try? req.parameters.get("code") else { throw Abort(.badRequest)
        }
        
        let metarCallURI = URI(scheme: .https, host: "avwx.rest", path: "api/metar/\(airportCode)")
        
        let response = try await req.client.get(metarCallURI) { clientRequest in
            guard case let .token(t) = Credentials.awvx.type else { throw Abort(.forbidden) }
            let auth = BearerAuthorization(token: t)
            clientRequest.headers.bearerAuthorization = auth
        }
        print(response)
        let data = try response.content.decode(METAR.self)
        return data
    }
}
