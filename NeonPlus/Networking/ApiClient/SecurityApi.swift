//
//  SecurityApi.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class SecurityApi: AppBaseApi {

    func generateToken(name: String,
                       email: String,
                       completionBlock: ((UserToken?) -> Void),
                       errorHandlerBlock: ((NSError) -> Void)) {
        let targetUrl = "/GenerateToken?nome=:nome&email=:email"
            .stringByReplacingOccurrencesOfString(":nome", withString: name.addURLPercentEncodedChars())
        .stringByReplacingOccurrencesOfString(":email", withString: email)
        
        let transformer = AnyObjectToUserTokenTransformer()
        self.get(targetUrl, responseTransformer: transformer, completionBlock: completionBlock, errorHandlerBlock: errorHandlerBlock, retryAttempts: 30)
    }

}
