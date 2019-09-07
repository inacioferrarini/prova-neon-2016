//
//  TransferToDictionaryTransformer.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class TransferToDictionaryTransformer: Transformer {

    func transform(input: Transfer) -> [String : AnyObject] {
        var dic = [String : AnyObject]()
        let mapper = ModelMapperManager.transferObjectMapping()
        if let parsedDic = EKSerializer.serializeObject(input, withMapping: mapper) as? [String : AnyObject] {
            dic = parsedDic
        }
        return dic
    }

}
