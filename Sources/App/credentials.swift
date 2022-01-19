import Vapor

struct Credentials {
    
    let baseURI: URI
    let type: ConnectionType
    
    static let awvx = Credentials(baseURI: URI(string: "avwx.rest/api"),
                                  type: .token(
                                    Environment.get("AVWX_TOKEN") ?? ""))
    
    enum ConnectionType {
        case token(String)
        case keySecret(String, String)
    }
}


	

