//
//  SendMoneyEmbededViewController.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import UIImageView_Letters
import SwiftHEXColors
import SDWebImage
import TSCurrencyTextField

class SendMoneyEmbededViewController: BaseDataBasedViewController {


    // MARK: - Outlets

    @IBOutlet weak var targetContactImage: UIImageView!
    @IBOutlet weak var targetContactNameLabel: UILabel!
    @IBOutlet weak var targetContactPhoneNumberLabel: UILabel!
    @IBOutlet weak var moneyAmountInputTextField: TSCurrencyTextField!

    @IBOutlet weak var sendTransactionButton: UIButton!
    @IBOutlet weak var operationActivityIndicator: UIActivityIndicatorView!


    // MARK: - Initialization

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.moneyAmountInputTextField.keyboardType = .NumberPad
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencySymbol = "R$ "
        currencyFormatter.currencyDecimalSeparator = ","
        currencyFormatter.currencyGroupingSeparator = "."
        self.moneyAmountInputTextField.currencyNumberFormatter = currencyFormatter

        self.resetUI()
    }

    func resetUI() {
        self.moneyAmountInputTextField.amount = 0
        self.sendTransactionButton.enabled = true
        self.operationActivityIndicator.hidden = true
    }

    // MARK: - Properties

    var contact: Contact? {
        didSet {
            self.updateContact(contact)
        }
    }

    func updateContact(contact: Contact?) {
        guard let contact = contact else { return }

        if let imagePath = contact.photoUrl where imagePath.characters.count > 0,
            let imageUrl = NSURL(string: imagePath) {
            self.targetContactImage.sd_setImageWithURL(imageUrl)
        } else {
            let bgColor = UIColor.whiteColor()
            var textAttributes = [String : AnyObject]()
            var textColor = UIColor.blackColor()
            if let color = UIColor(hexString: "00A6DD") {
                textColor = color
            }
            textAttributes[NSForegroundColorAttributeName] = textColor
            textAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(26)
            self.targetContactImage.setImageWithString(contact.name, color: bgColor, circular: false, textAttributes: textAttributes)
        }
        self.targetContactNameLabel.text = contact.name
        self.targetContactPhoneNumberLabel.text = contact.phoneNumber
    }


    // MARK: - Actions

    @IBAction func dismiss() {
        if let courtainView = self.courtainView {
            courtainView.hidden = true
        }
    }

    @IBAction func sendMoney() {
        self.showCourtainView()
        self.showToastWithMessage(withMessage: "Aguarde ...")
        self.operationActivityIndicator.hidden = false
        self.sendTransactionButton.enabled = false

        ApiClient().transfer.sendMoney(
            self.asTransfer(),
            completionBlock: { (success: Bool?) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.operationActivityIndicator.hidden = true
                    self.dismissToast(withMessage: "Envio Realizado com Sucesso!")
                })
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue(), {
                    self.hideCourtainView()
                    self.dismiss()
                    self.popToRootViewController()
                })
            }) { (error: NSError) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.operationActivityIndicator.hidden = true
                    self.dismissToast(withErrorMessage: "Não foi possível efetuar a operação.")
                    self.sendTransactionButton.enabled = true
                    self.hideCourtainView()
                })
        }
    }

    func popToRootViewController() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}

extension SendMoneyEmbededViewController: TransferGetterProtocol {

    func asTransfer() -> Transfer {
        let transfer = Transfer()
        transfer.uid = 1
        transfer.clientUid = self.contact?.uid ?? 0
        transfer.value = self.moneyAmountInputTextField.amount
        transfer.date = NSDate()
        transfer.token = self.appContext?.securityToken ?? ""
        return transfer
    }

}
