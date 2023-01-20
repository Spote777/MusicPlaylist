//
//  APIClient.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire
import Foundation

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter,
                                                    decoder: JSONDecoder = JSONDecoder(),
                                                    completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    completion(response.result)
                }
            }
    }
    
    static func getSong(completion: @escaping(Result<MusicModel,
                                              AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.songList,
                       decoder: jsonDecoder,
                       completion: completion)
    }
}
