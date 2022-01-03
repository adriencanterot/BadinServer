//
//  File.swift
//  
//
//  Created by Adrien Cantérot on 23/12/2021.
//

import Foundation
import Vapor

final class AmadeusApi {
    
    enum ApiError: Error {
        case noToken
    }
    
    static var shared: AmadeusApi?
    
    private let credentials: Credentials
    private let client: Client
    
    public init(for client: Client) {
        self.credentials = .amadeus
        self.client = client
    }
    
    var token: AccessToken?
    
    func requestToken() throws {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/x-www-form-urlencoded")
        let response = client.post(credentials.baseURI, headers: headers) { request in
            guard case let .keySecret(key, secret) = credentials.type else { throw Abort(.badRequest) }
            try request.content.encode( "grant_type=client_credentials&client_id=\(key)&client_secret=\(secret)")
            request.headers.contentType = .urlEncodedForm
        }.flatMapThrowing { resp -> AccessToken in
            let token = try resp.content.decode(AccessToken.self)
            return token
            
        }.whenComplete { result in
            switch result {
            case .success(let accessToken):
                self.token = accessToken
                print(self.token)
            case .failure(let error):
                //handle error later
                print(error)
            }
        }
    }
}
