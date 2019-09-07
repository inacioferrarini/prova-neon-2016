//
//  SendMoneyToContactListViewController.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import UIImageView_Letters
import SwiftHEXColors
import SDWebImage

class TransferMoneyToContactListViewController: BaseTableViewController {


    // MARK: - Outlets

    @IBOutlet weak var sendMoneyEmbededContainerView: UIView!


    // MARK: - Properties

    var sendMoneyEmbededViewController: SendMoneyEmbededViewController?


    // MARK: - BaseTableViewController override

    let cellClassName = ContactTableViewCell.simpleClassName()
    
    override func setupTableView() {
        guard let tableView = self.tableView else { return }
        let cellNib = UINib(nibName: cellClassName, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: cellClassName)
    }

    override func createDataSource() -> UITableViewDataSource? {

        var objects = [Contact]()
        if let appContext = self.appContext,
            let contacts = appContext.contacts {
            objects = contacts
        }

        let cellReuseIdBlock: ((indexPath: NSIndexPath) -> String) = { (indexPath: NSIndexPath) -> String in
            return self.cellClassName
        }

        let presenter = TableViewCellPresenter<ContactTableViewCell, Contact> (
            configureCellBlock: { (cell: ContactTableViewCell, contact: Contact) in
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

        let dataSource = TableViewArrayDataSource<ContactTableViewCell, Contact>(
            targetingTableView: self.tableView!,
            presenter: presenter,
            objects: objects)
        
        return dataSource
    }

    override func createDelegate() -> UITableViewDelegate? {
        let itemSelectionBlock = { (indexPath:NSIndexPath) -> Void in
            if let dataSource = self.dataSource as? TableViewArrayDataSource<ContactTableViewCell, Contact> {
                if let selectedContact = dataSource.objectAtIndexPath(indexPath) {
                    self.showSendMoneyEmbededViewController(forContact: selectedContact)
                }
            }
            self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        }
        let delegate = TableViewBlockDelegate(tableView: self.tableView!)
        delegate.itemSelectionBlock = itemSelectionBlock
        return delegate
    }
    
    func showSendMoneyEmbededViewController(forContact contact: Contact) {
        
        if let sendMoneyEmbededViewController = self.sendMoneyEmbededViewController {
            sendMoneyEmbededViewController.resetUI()
            sendMoneyEmbededViewController.contact = contact
        }
        if let sendMoneyEmbededContainerView = self.sendMoneyEmbededContainerView {
            sendMoneyEmbededContainerView.hidden = false
        }
        if let courtainView = self.courtainView {
            courtainView.hidden = false
        }
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? SendMoneyEmbededViewController {
            vc.appContext = self.appContext
            vc.courtainView = self.courtainView
            self.sendMoneyEmbededViewController = vc
        }
    }

}
