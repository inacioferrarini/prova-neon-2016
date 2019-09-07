//
//  NSObjectExtension.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import Foundation

import Foundation

public extension NSObject {

    public class func simpleClassName() -> String {
        let fullClassName: String = NSStringFromClass(object_getClass(self))
        let classNameComponents = fullClassName.characters.split {$0 == "."}.map(String.init)
        return classNameComponents.last!
    }

    public func instanceSimpleClassName() -> String {
        let fullClassName: String = NSStringFromClass(object_getClass(self))
        let classNameComponents = fullClassName.characters.split {$0 == "."}.map(String.init)
        return classNameComponents.last!
    }

}
