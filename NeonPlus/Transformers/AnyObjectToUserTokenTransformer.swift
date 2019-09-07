//
//  AnyObjectToUserTokenTransformer.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class AnyObjectToUserTokenTransformer: Transformer {

    func transform(input: AnyObject?) -> UserToken? {
        var parsedUserToken: UserToken?
        if let string = input as? String {
            let mapper = ModelMapperManager.userTokenObjectMapping()
            let dictionary = ["token" : string]
            if let userToken = EKMapper.objectFromExternalRepresentation(dictionary, withMapping: mapper) as? UserToken {
                parsedUserToken = userToken
            }
        }
        return parsedUserToken
    }

}
