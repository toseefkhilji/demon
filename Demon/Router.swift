//
//  Router.swift
//  M Cards
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let DEVELOP_URL: String = ""
    
    static let PRODUCTION_URL: String = "http://tkcore.ddns.net:91/Imagenes.asmx/"
    
    static let DOMAINS: [String] = [
        Router.DEVELOP_URL,
        Router.PRODUCTION_URL
    ]
    
    static let BASE_URL: String = DOMAINS[1]
    
    case getPictures(params: Parameters)
    
    case sendPicture(params: Parameters)
    
    var method: HTTPMethod {
        
        switch self {
        case .getPictures:
            return .post
        case .sendPicture:
            return .post
        }
    }
    
    var path: String {
        
        switch self {
        case .getPictures:
            return "ObtenerImagenes"
        case .sendPicture:
            return "GuardarImagen"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.BASE_URL.asURL()
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getPictures(let params):
            return try JSONEncoding.init(options: .prettyPrinted).encode(urlRequest, with: params)
        case .sendPicture(let params):
            return try JSONEncoding.init(options: .prettyPrinted).encode(urlRequest, with: params)
        }
    }
}
