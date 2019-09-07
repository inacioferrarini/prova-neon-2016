//
//  AppBaseApi.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import Alamofire

class AppBaseApi {
    
    
    // MARK: - Properties
    
    let apiClient: ApiClient
    
    
    // MARK: - Initialization
    
    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    
    // MARK: - Helper methods
    
    func get<Type, TransformerType where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type>(
        targetUrl: String,
        responseTransformer: TransformerType,
        completionBlock: ((Type) -> Void),
        errorHandlerBlock: ((NSError) -> Void),
        retryAttempts: Int) {
        
        self.get(targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: nil,
                 completionBlock: completionBlock,
                 errorHandlerBlock: errorHandlerBlock,
                 retryAttempts: retryAttempts)
    }
    
    func get<Type, TransformerType where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type>(
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: ((Type) -> Void),
        errorHandlerBlock: ((NSError) -> Void),
        retryAttempts: Int) {
        
        self.get(self.apiClient.rootUrl,
                 targetUrl: targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: parameters,
                 completionBlock: completionBlock,
                 errorHandlerBlock: errorHandlerBlock,
                 retryAttempts: retryAttempts)
    }
    
    func get<Type, TransformerType where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type>(
        endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: ((Type) -> Void),
        errorHandlerBlock: ((NSError) -> Void),
        retryAttempts: Int) {

        let url = endpointUrl + targetUrl
        Alamofire.request(.GET, url, parameters: parameters, encoding: .JSON, headers: ["Content-Type" : "application/json;charset=UTF-8"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.result.error {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                    if retryAttempts <= 1 {
                        errorHandlerBlock(error)
                    } else {
                        print ("re-post attemp #\(retryAttempts)")
                        self.post(endpointUrl,
                            targetUrl: targetUrl,
                            responseTransformer: responseTransformer,
                            parameters: parameters,
                            completionBlock: completionBlock,
                            errorHandlerBlock: errorHandlerBlock,
                            retryAttempts: retryAttempts - 1)
                    }
                    
                } else {
                    let transformedObject = responseTransformer.transform(response.result.value)
                    completionBlock(transformedObject)
                }
        }
    }
    
    func post<Type, TransformerType where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type>(
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: ((Type) -> Void),
        errorHandlerBlock: ((NSError) -> Void),
        retryAttempts: Int) {
        
        self.post(self.apiClient.rootUrl,
                  targetUrl: targetUrl,
                  responseTransformer: responseTransformer,
                  parameters: parameters,
                  completionBlock: completionBlock,
                  errorHandlerBlock: errorHandlerBlock,
                  retryAttempts: retryAttempts)
    }
    
    func post<Type, TransformerType where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type>(
        endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: ((Type) -> Void),
        errorHandlerBlock: ((NSError) -> Void),
        retryAttempts: Int) {
        
        let url = endpointUrl + targetUrl
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: ["Content-Type" : "application/json;charset=UTF-8"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.result.error {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                    if retryAttempts <= 1 {
                        errorHandlerBlock(error)
                    } else {
                        print ("re-post attemp #\(retryAttempts)")
                        self.post(endpointUrl,
                            targetUrl: targetUrl,
                            responseTransformer: responseTransformer,
                            parameters: parameters,
                            completionBlock: completionBlock,
                            errorHandlerBlock: errorHandlerBlock,
                            retryAttempts: retryAttempts - 1)
                    }
                    
                } else {
                    let transformedObject = responseTransformer.transform(response.result.value)
                    completionBlock(transformedObject)
                }
        }
        
    }

}
