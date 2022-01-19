import Fluent
import FluentPostgresDriver
import Vapor
import Foundation
import AsyncHTTPClient

//configure JSON Decoder

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)
    
    let appJsonDecoder = JSONDecoder()
    appJsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    appJsonDecoder.dateDecodingStrategy = .iso8601
    ContentConfiguration.global.use(decoder: appJsonDecoder, for: .json)

    app.migrations.add(CreateTodo())

    try routes(app)
}
