//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Azizbek Asadov on 13.10.2025.
//

import Foundation
import XCTest

@testable import QuizApp


final class QuestionViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view // to layout all subviews
        
        XCTAssertEqual(sut.headerText, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptionsInSectionZero() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view // to layout all subviews
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOptions_rendersOneOptionsInSectionZero() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        _ = sut.view // to layout all subviews
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOptions_rendersOneOptionCell() {
        let option = "A1"
        
        let sut = QuestionViewController(question: "Q1", options: [option])
        _ = sut.view // to layout all subviews
    
        let indexPath = IndexPath.zero
        let cell = sut.tableView.dataSource?.tableView(
            sut.tableView,
            cellForRowAt: indexPath
        )
        
        XCTAssertEqual(cell?.textLabel?.text, option)
    }
}
