//
//  Alert.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit

final class Alert {
    static func showAlert(on viewController: UIViewController, withMessage message: String) {
        let alertController = UIAlertController(title: "Hint", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alertController, animated: true)
    }
}
