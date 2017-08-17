//
//  DataRequest.swift
//  M Cards
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DataRequest {
    
    func responseObject<T: ResponseObjectSerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        
        let responseSerializer = DataResponseSerializer <T> { (request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<T> in
            
            if let d = data {
                print(NSString(data: d, encoding: String.Encoding.utf8.rawValue) ?? "no nada")
            }
            
            guard error == nil else {
                if let errorData = data {
                    let jsonError: JSON = JSON(errorData)
                    if let message = jsonError[ApiError.KEY_MESSAGE].string {
                        let apiError: ApiError = ApiError(message: message)
                        return .failure(BackendError.apiResponseError(apiError: apiError))
                    } else {
                        return .failure(BackendError.requestFailureError(error: error!))
                    }
                }
                return .failure(BackendError.network(error: error!))
            }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response, let representation = jsonObject as? [String: Any?] else {
                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(T(response: response, representation: JSON(representation)))
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
