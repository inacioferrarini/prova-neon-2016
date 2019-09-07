//
//  AnyObjectToContactTransformer.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class AnyObjectToContactArrayTransformer: Transformer {

    func transform(input: AnyObject?) -> [Contact] {
        var contacts = [Contact]()
        if let dictionaryArray = input as? [[String : AnyObject]] {
            let mapper = ModelMapperManager.contactObjectMapping()
            if let options = EKMapper.arrayOfObjectsFromExternalRepresentation(dictionaryArray,
                                                                               withMapping: mapper) as? [Contact] {
                contacts = options
            }
        }
        return contacts
    }

}
