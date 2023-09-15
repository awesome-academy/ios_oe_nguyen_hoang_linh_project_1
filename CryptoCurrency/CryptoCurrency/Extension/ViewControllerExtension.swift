//
//  ViewControllerExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 14/9/2023.
//

import UIKit

extension UIViewController {
    func popUpErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
