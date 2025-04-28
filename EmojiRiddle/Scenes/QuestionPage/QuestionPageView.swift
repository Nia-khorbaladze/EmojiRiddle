//
//  QuestionPageView.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit
import SwiftUI
import CoreData

final class QuestionPageView: UIViewController {
    private var currentQuestionIndex = 0
    private var correctAnswersCount = 0
    private let viewModel = QuestionViewModel.shared
    private var hostingController: UIHostingController<QuizView>?
    
    // MARK: - UI Elements
    private var containerView = UIView()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var hintButton: UIButton = {
        let hintButton = UIButton()
        hintButton.setTitle("Hint", for: .normal)
        hintButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        hintButton.setTitleColor(.white, for: .normal)
        hintButton.backgroundColor = UIColor(hexString: "6200EA")
        hintButton.layer.cornerRadius = 8
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.addTarget(self, action: #selector(showHint), for: .touchUpInside)
        
        return hintButton
    }()
    
    private lazy var correctAnswersCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(hexString: "3700B3")
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.text = "Correct: \(viewModel.getCorrectAnswersCount())"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchQuestions()
        showNextQuestion()
        setupBackButton()
        hostingController?.view.backgroundColor = .clear
        
        if let categoryName = viewModel.selectedCategory {
            navigationItem.title = categoryName
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hexString: "100735")
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(hexString: "FFDAF9"),
                .font: UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.resetCorrectAnswersCount()
        correctAnswersCount = 0
        correctAnswersCountLabel.text = "Correct: 0"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel.resetCorrectAnswersCount()
        }
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(hexString: "100735")
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        view.addSubview(emojiLabel)
        view.addSubview(hintButton)
        view.addSubview(correctAnswersCountLabel)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            
            emojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),

            hintButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            hintButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintButton.widthAnchor.constraint(equalToConstant: 120),
            hintButton.heightAnchor.constraint(equalToConstant: 40),

            correctAnswersCountLabel.topAnchor.constraint(equalTo: hintButton.bottomAnchor, constant: 16),
            correctAnswersCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            correctAnswersCountLabel.widthAnchor.constraint(equalToConstant: 200),
            correctAnswersCountLabel.heightAnchor.constraint(equalToConstant: 40),

            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // MARK: - Private functions
    private func showNextQuestion() {
        guard currentQuestionIndex < viewModel.riddles.count else {
            showResultsScreen()
            return
        }

        let currentRiddle = viewModel.riddles[currentQuestionIndex]
        emojiLabel.text = currentRiddle.emoji

        if let existingHostingController = hostingController {
            existingHostingController.willMove(toParent: nil)
            existingHostingController.view.removeFromSuperview()
            existingHostingController.removeFromParent()
        }

        let options = currentRiddle.answerOptions as? [String] ?? []

        let quizView = QuizView(options: options) { [weak self] selectedOption in
            guard let self = self else { return }
            if selectedOption == currentRiddle.correctAnswer {
                self.correctAnswersCount += 1
                self.viewModel.saveCorrectAnswersCount(self.correctAnswersCount)
                
                self.correctAnswersCountLabel.text = "Correct: \(self.correctAnswersCount)"
            }
            self.currentQuestionIndex += 1
            self.showNextQuestion()
        }

        hostingController = UIHostingController(rootView: quizView)
        guard let hostingController = hostingController else { return }

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear

        addChild(hostingController)
        containerView.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }

    private func showResultsScreen() {
        let isWin = viewModel.getCorrectAnswersCount() > 5
        let resultsViewController = ResultsViewController(isWin: isWin)
        navigationController?.pushViewController(resultsViewController, animated: true)
    }
    
    @objc private func showHint() {
        guard currentQuestionIndex < viewModel.riddles.count else { return }
        let currentRiddle = viewModel.riddles[currentQuestionIndex]
        let hintMessage = currentRiddle.hint ?? "No hint available."

        Alert.showAlert(on: self, withMessage: hintMessage)
    }
    
    private func setupBackButton() {
        setupBackButton(tintColor: UIColor(hexString: "FFDAF9")) { [weak self] in
            self?.navigateBack()
        }
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
