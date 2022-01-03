import Foundation
import Vapor
struct AccessToken: Content {
    
    var username: String
    var applicationName: String
    var tokenType: TokenType
    var accessToken: String
    var expiresIn: TimeInterval
    var state: State
    
    
    enum TokenType: String, Content {
        case Bearer = "Bearer"
    }
	enum State: String, Content {
		case Approved = "approved"
		case Expired = "expired"
	}
}
