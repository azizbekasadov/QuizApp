//
//  Answer.swift
//  QuizApp
//
//  Created by Azizbek Asadov on 18.10.2025.
//

import Foundation

struct PresentableAnswer {
    let answer: String
    let question: String
    let isCorrect: Bool
    
    init(
        answer: String = "",
        question: String = "",
        isCorrect: Bool
    ) {
        self.answer = answer
        self.question = question
        self.isCorrect = isCorrect
    }
}
