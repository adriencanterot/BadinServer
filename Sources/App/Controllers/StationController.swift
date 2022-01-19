import Vapor



struct StationController: RouteCollection {
    
    struct LocationQueryString: Content {
        var latitude: Double
        var longitude: Double
        
        var pair: String {
            "\(latitude),\(longitude)"
        }
    }
    
	func boot(routes: RoutesBuilder) throws {
        let station = routes.grouped("station")
        station.get("nearest", use: nearest)
	}
    
    func nearest(req: Request) async throws -> [Station]{
        let location = try req.query.decode(LocationQueryString.self)
        
        let url = URI(scheme: .https, host: "avwx.rest", path: "api/station/near/\(location.pair)")
        
        let response = try await req.client.get(url) { req in
            guard case let .token(t) = Credentials.awvx.type else { throw Abort(.badRequest) }
            let auth = BearerAuthorization(token: t)
            req.headers.bearerAuthorization = auth
        }
        
        let data = try response.content.decode([AVWXApi.LocationResponse].self)
        let stations = data.map(Station.init)
        return stations
        
    }
    
//    func nearest(req: Request) async throws -> [Airport] {
//        guard let token = AmadeusApi.shared?.token else { throw AmadeusApi.ApiError.noToken }
//
//        guard let airportQueryString = try? req.query.decode(LocationQueryString.self) else {
//            throw Abort(.badRequest)
//        }
//
//        let stringQuery = "https://test.api.amadeus.com/v1/reference-data/locations/airports"
//
//        var response = await try req.client.get(URI(string: stringQuery)) { clientRequest in
//            try clientRequest.query.encode(
//                ["latitude": String(airportQueryString.latitude),
//                 "longitude": String(airportQueryString.longitude),
//                 "radius": "150"]
//            )
//            let auth = BearerAuthorization(token: token.accessToken)
//            clientRequest.headers.bearerAuthorization = auth
//            print(clientRequest)
//        }
//
//        response.headers.contentType = .json
//        let data = try response.content.decode(AmadeusResponse.Data<[AmadeusResponse.Airport]>.self)
//
//        let airports = data.data.map(Airport.init)
//        return airports
//
//    }
    
}
