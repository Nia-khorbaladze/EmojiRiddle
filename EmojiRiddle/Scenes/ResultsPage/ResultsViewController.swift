//
//  ResultsViewController.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import SwiftUI
import UIKit

class ResultsViewController: UIViewController {
    private let isWin: Bool
    
    init(isWin: Bool) {
        self.isWin = isWin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resultsView = ResultsView(isWin: isWin)
        let hostingController = UIHostingController(rootView: resultsView)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupBackButton()
    }
    
    private func setupBackButton() {
        setupBackButton(tintColor: UIColor(hexString: "FFDAF9")) { [weak self] in
            self?.navigateBack()
        }
    }
    
    private func navigateBack() {
        navigationController?.popToRootViewController(animated: true)
    }
}
