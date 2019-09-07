//
//  OperationMenuViewController.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class OperationMenuViewController: BaseDataBasedViewController {


    // MARK: - Outlets

    @IBOutlet weak var userPortrait: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!


    // MARK: - Initialization

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let imagePath = self.appContext?.userData?.imagePath
        let userName = self.appContext?.userData?.userName ?? ""
        let userEmail = self.appContext?.userData?.userEmail ?? ""

        if let imagePath = imagePath where imagePath.characters.count > 0,
            let imageUrl = NSURL(string: imagePath) {
            self.userPortrait.sd_setImageWithURL(imageUrl)
        }

        self.userNameLabel.text = userName
        self.userEmailLabel.text = userEmail
    }

    
    // MARK: - Data Sync
    
    override func shouldSyncData() -> Bool {
        return self.appContext?.securityToken == nil
    }

    override func syncData() {
        let userName = self.appContext?.userData?.userName ?? ""
        let userEmail = self.appContext?.userData?.userEmail ?? ""

        self.showToastWithMessage(withMessage: "Obtendo token ...")
        ApiClient().security.generateToken(userName, email: userEmail, completionBlock: { (userToken: UserToken?) in
            self.appContext?.securityToken = userToken?.token ?? ""
            self.dismissToast()
        }) { (error: NSError) in
            self.dismissToast(withErrorMessage: "Não foi possível obter o token.")
        }
    }


    // MARK: - Actions

    @IBAction func sendMoney() {
        self.performSegueWithIdentifier("toTransferMoneyToContactListViewController", sender: self)
    }

    @IBAction func showTransactionHistory() {
        self.performSegueWithIdentifier("toMoneyTransferHistoryListViewController", sender: self)
    }

}
