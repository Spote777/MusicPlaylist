//
//  APIRouter.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    case songList
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .songList:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .songList:
            return "/playlistdata.json"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .songList:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
