//
//  TransferApi.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class TransferApi: AppBaseApi {

    func sendMoney(transfer: Transfer,
                   completionBlock: ((success: Bool?) -> Void),
                   errorHandlerBlock: ((NSError) -> Void)) {
        let targetUrl = "/SendMoney"
        let transformer = AnyObjectToBoolTransformer()
        let parameters: [String : AnyObject] = TransferToDictionaryTransformer().transform(transfer)
        super.post(targetUrl, responseTransformer: transformer, parameters: parameters, completionBlock: completionBlock, errorHandlerBlock: errorHandlerBlock, retryAttempts: 30)
    }

    func getTransfers(token: UserToken,
                      completionBlock: ((transfers: [Transfer]) -> Void),
                      errorHandlerBlock: ((NSError) -> Void)) {
        let targetUrl = "/GetTransfers?token=:token"
            .stringByReplacingOccurrencesOfString(":token", withString: token.token ?? "")
        let transformer = AnyObjectToTransferArrayTransformer()
        super.get(targetUrl, responseTransformer: transformer, completionBlock: completionBlock, errorHandlerBlock: errorHandlerBlock, retryAttempts: 30)
    }

}
