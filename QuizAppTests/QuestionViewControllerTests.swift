//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Azizbek Asadov on 13.10.2025.
//

import Foundation
import XCTest

@testable import QuizApp

@MainActor
final class QuestionViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersHeaderText() {
        XCTAssertEqual(makeSUT(for: "Q1", with: []).headerText, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(with: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(with: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(with: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withOneOptions_rendersOptionsCellTexts() {
        XCTAssertEqual(makeSUT(with: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(with: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWhenSelectionChanges() {
        var receivedAnswer: [String] = []
        let sut = makeSUT(with: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
        var callbackCount = 0
        
        let sut = makeSUT(with: ["A1", "A2"]) { _ in
            callbackCount += 1
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionDeselected_withMultipleSelection_notifiesDelegateWithEmptySelection() {
        var callbackCount = 0
        
        let sut = makeSUT(with: ["A1", "A2"]) { _ in
            callbackCount += 1
        }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 2)
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer: [String] = []
        let sut = makeSUT(with: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        var receivedAnswer: [String] = []
        let sut = makeSUT(with: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    func makeSUT(
        for question: String = "",
        with options: [String] = [],
        selection: @escaping (([String]) -> Void) = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(
            question: question,
            options: options,
            selection: selection
        )
        sut.loadViewIfNeeded()
        sut.awakeFromNib()
        return sut
    }
}
