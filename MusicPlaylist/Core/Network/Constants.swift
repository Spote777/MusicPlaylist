//
//  Constants.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://test.iospro.ru"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let timeCode = "code"
        static let username = "username"
        static let follow = "follow"
        static let like = "like"
        static let comment = "comment"
        static let oldPassword = "current_password"
        static let newPassword = "new_password"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let link = "link"
        static let description = "description"
        static let complaintsType = "complaint_type"
        static let text = "text"
        static let post = "post"
        static let author = "author"
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
