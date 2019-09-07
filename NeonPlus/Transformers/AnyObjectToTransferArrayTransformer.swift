//
//  AnyObjectToTransferTransformer.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class AnyObjectToTransferArrayTransformer: Transformer {

    func transform(input: AnyObject?) -> [Transfer] {
        var transfers = [Transfer]()
        if let dictionaryArray = input as? [[String : AnyObject]] {
            let mapper = ModelMapperManager.transferObjectMapping()
            if let options = EKMapper.arrayOfObjectsFromExternalRepresentation(dictionaryArray,
                                                                               withMapping: mapper) as? [Transfer] {
                transfers = options
            }
        }
        return transfers
    }

}
