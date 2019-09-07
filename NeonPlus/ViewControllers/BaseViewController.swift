//
//  BaseViewController.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, AppContextAware {

    // MARK: - Properties

    var appContext: AppContext?


    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navController = self.navigationController {
            navController.navigationBar.shadowImage = UIImage();
            navController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var destinationViewController = segue.destinationViewController as? AppContextAware {
            destinationViewController.appContext = self.appContext
        }
    }

}
