//
//  QuestionViewModel.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit
import CoreData

final class QuestionViewModel {
    static let shared = QuestionViewModel()
    private let correctAnswersKey = "CorrectAnswersKey"
    var selectedCategory: String?
    var riddles: [Riddle] = []

    private init() {}

    func saveCorrectAnswersCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: correctAnswersKey)
    }

    func getCorrectAnswersCount() -> Int {
        return UserDefaults.standard.integer(forKey: correctAnswersKey)
    }

    func resetCorrectAnswersCount() {
        UserDefaults.standard.removeObject(forKey: correctAnswersKey)
    }

    func fetchQuestions() {
        guard let selectedCategory = selectedCategory else { return }
        
        let fetchRequest = NSFetchRequest<Riddle>(entityName: "Riddle")
        fetchRequest.fetchLimit = 10
        fetchRequest.predicate = NSPredicate(format: "category == %@", selectedCategory)
        
        do {
            let context = CoreDataManager.shared.context
            riddles = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching questions: \(error)")
        }
    }
}
