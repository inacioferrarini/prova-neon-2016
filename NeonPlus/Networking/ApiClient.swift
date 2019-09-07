//
//  ApiClient.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import Alamofire

class ApiClient {

    let rootUrl = "http://processoseletivoneon.azurewebsites.net"


    // MARK: - Properties

    lazy var security: SecurityApi = {
        [unowned self] in
        return SecurityApi(self)
    }()

    lazy var transfer: TransferApi = {
        [unowned self] in
        return TransferApi(self)
    }()

}
