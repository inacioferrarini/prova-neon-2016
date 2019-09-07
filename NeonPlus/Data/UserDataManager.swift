//
//  UserDataManager.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class UserDataManager: NSObject {

    func load() -> [Contact] {
        var contacts = [Contact]()
        guard let userDataFilePath = self.userDataFilePath() else { return contacts }
        guard let jsonData = self.jsonData(fromFilePath: userDataFilePath) else { return contacts }
        guard let jsonArray = self.jsonDictionary(fromData: jsonData) else { return contacts }
        let transformer = AnyObjectToContactArrayTransformer()
        contacts = transformer.transform(jsonArray)
        return contacts
    }

    func userDataFilePath() -> String? {
        return NSBundle.mainBundle().pathForResource("UserData", ofType: "json")
    }

    func jsonData(fromFilePath filePath: String) -> NSData? {
        do {
            return try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        } catch {
            return nil
        }
    }

    func jsonDictionary(fromData data: NSData) -> NSArray? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray
        } catch {
            return nil
        }
    }

}
