//
//  AnyObjectToBoolTransformer.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class AnyObjectToBoolTransformer: Transformer {

    func transform(input: AnyObject?) -> Bool? {
        var parsedBool: Bool?
        if let input = input as? String {
            parsedBool = NSString(string: input).boolValue
        }
        return parsedBool
    }

}
