//
//  MoneyTransferHistoryListViewController.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class MoneyTransferHistoryListViewController: BaseTableViewController {
    
    
    // MARK: - Properties
    
    var sendMoneyEmbededViewController: SendMoneyEmbededViewController?

    var transfers: [Transfer]? {
        didSet {
            self.updateTransfers(transfers)
        }
    }

    func updateTransfers(transfers: [Transfer]?) {
        guard let transfers = transfers else { return }
        guard let dataSource = self.dataSource as? TableViewArrayDataSource<ContactTableViewCell, Transfer> else { return }
        dataSource.objects = transfers
        dataSource.refreshData()
    }


    // MARK: - Data Sync

    override func syncData() {
        let userToken = UserToken()
        userToken.token = self.appContext?.securityToken

        self.showToastWithMessage(withMessage: "Obtendo transferências ...")
        ApiClient().transfer.getTransfers(userToken, completionBlock: { (transfers: [Transfer]) in
            self.transfers = transfers
            self.dismissToast()
        }) { (error: NSError) in
            self.dismissToast()
        }
    }


    // MARK: - BaseTableViewController override

    let cellClassName = ContactTableViewCell.simpleClassName()

    override func setupTableView() {
        guard let tableView = self.tableView else { return }
        let cellNib = UINib(nibName: cellClassName, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: cellClassName)
    }
    
    override func createDataSource() -> UITableViewDataSource? {
        
        var objects = [Transfer]()
        if let transfers = self.transfers {
            objects = transfers
        }

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return self.cellClassName
        }
        
        let presenter = TableViewCellPresenter<ContactTableViewCell, Transfer> (
            configureCellBlock: { (cell: ContactTableViewCell, transfer: Transfer) in
                print ("item in list ... ")
                let contacts = self.appContext?.contacts?.filter({ (contact: Contact) -> Bool in
                    return contact.uid?.integerValue == transfer.clientUid?.integerValue
                })
                guard let contact = contacts?.first else { return }
                
                if let imagePath = contact.photoUrl where imagePath.characters.count > 0,
                    let imageUrl = NSURL(string: imagePath) {
                    cell.contactImage.sd_setImageWithURL(imageUrl)
                } else {
                    let bgColor = UIColor.whiteColor()
                    var textAttributes = [String : AnyObject]()
                    var textColor = UIColor.blackColor()
                    if let color = UIColor(hexString: "00A6DD") {
                        textColor = color
                    }
                    textAttributes[NSForegroundColorAttributeName] = textColor
                    textAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(26)
                    cell.contactImage.setImageWithString(contact.name, color: bgColor, circular: false, textAttributes: textAttributes)
                }
                cell.contactName.text = contact.name
                cell.contactPhoneNumber.text = contact.phoneNumber
            }, cellReuseIdentifierBlock: cellReuseIdBlock)

        let dataSource = TableViewArrayDataSource<ContactTableViewCell, Transfer>(
            targetingTableView: self.tableView!,
            presenter: presenter,
            objects: objects)
        
        return dataSource
    }

    override func createRefreshControl() -> UIRefreshControl? {
        let refreshControl = UIRefreshControl()
        if let tintColor = UIColor(hexString: "00A6DD") {
            refreshControl.attributedTitle = NSAttributedString(string: "Execute Pull para atualizar.", attributes: [NSForegroundColorAttributeName : tintColor])
            refreshControl.tintColor = tintColor
        }
        return refreshControl
    }

}
