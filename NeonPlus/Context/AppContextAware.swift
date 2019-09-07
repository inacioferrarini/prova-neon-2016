//
//  AppContextAware.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

protocol AppContextAware {

    var appContext: AppContext? { get set }

}

extension AppContextAware where Self: UIViewController {
    
}
