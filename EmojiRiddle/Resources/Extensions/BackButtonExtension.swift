//
//  BackButtonExtension.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit

extension UIViewController {
    func setupBackButton(tintColor: UIColor = .systemBlue, action: @escaping () -> Void) {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.contentMode = .scaleAspectFit
        backButton.isEnabled = true
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = tintColor

        backButton.addAction(UIAction(handler: { _ in
            action()
        }), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
