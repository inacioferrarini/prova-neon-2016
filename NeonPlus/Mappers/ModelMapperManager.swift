//
//  NetworkingMapperManager.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import EasyMapping

class ModelMapperManager: NSObject {


    // MARK: - Networking

    class func userTokenObjectMapping() -> EKObjectMapping {
        let map = EKObjectMapping(forClass: UserToken.self) { (mapping: EKObjectMapping!) in
            mapping.mapPropertiesFromArray(["token"])
        }
        return map
    }

    class func transferObjectMapping() -> EKObjectMapping {
        let map = EKObjectMapping(forClass: Transfer.self) { (mapping: EKObjectMapping!) in
            mapping.mapPropertiesFromDictionary([
                "Id" : "uid",
                "ClienteId" : "clientUid",
                "Valor" : "value",
                "Token" : "token"])
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            mapping.mapKeyPath("Data", toProperty: "date", withDateFormatter: formatter)
        }
        return map
    }

    class func contactObjectMapping() -> EKObjectMapping {
        let map = EKObjectMapping(forClass: Contact.self) { (mapping: EKObjectMapping!) in
            mapping.mapPropertiesFromDictionary(["id" : "uid"])
            mapping.mapPropertiesFromArray(["name", "phoneNumber", "photoUrl"])
        }
        return map
    }

}
