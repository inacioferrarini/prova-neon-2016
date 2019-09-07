//
//  UIViewControllerExtension.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 04/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController {


    // MARK: - Toast

    public func showToastInfinite() {
        SVProgressHUD.show()
    }

    public func showToastWithMessage(withMessage message: String) {
        SVProgressHUD.showWithStatus(message)
    }

    public func dismissToast(withMessage message: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        SVProgressHUD.showSuccessWithStatus(message)
    }

    public func dismissToast(withErrorMessage errorMessage: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        SVProgressHUD.showErrorWithStatus(errorMessage)
    }

    public func dismissToast() {
        SVProgressHUD.dismiss()
    }

}
