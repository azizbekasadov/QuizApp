//
//  ResultsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Azizbek Asadov on 18.10.2025.
//

import XCTest
import Foundation

@testable import QuizApp

@MainActor
final class ResultsViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT("a summary").headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer(), makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCorrectCell() {
        let answer = makeAnswer(answer: "A1", question: "Q1", isCorrect: true)
        
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configuresCorrectCell() {
        let answer = makeAnswer(answer: "A1", question: "Q1", isCorrect: false)
        
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        _ summary: String = "",
        answers: [PresentableAnswer] = []
    ) -> ResultsViewController {
        let sut = ResultsViewController(summary: "a summary", answers: answers)
        sut.awakeFromNib()
        sut.loadViewIfNeeded()
        return sut
    }
    
    private func makeDummyAnswer() -> PresentableAnswer {
        return .init(answer: "An Answer", isCorrect: false)
    }
    
    private func makeAnswer(
        answer: String = "",
        question: String = "",
        isCorrect: Bool
    ) -> PresentableAnswer {
        return PresentableAnswer(
            answer: answer,
            question: question,
            isCorrect: isCorrect
        )
    }
}

