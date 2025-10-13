//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Azizbek Asadov on 13.10.2025.
//

import Foundation
import UIKit

typealias Question = String

class QuestionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var headerText: String = ""
    private var question: Question = ""
    private var options: [String] = []
    
    convenience init(question: Question, options: [String]) {
        self.init()
        
        self.question = question
        self.headerText = question
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = question
        navigationItem.titleView?.accessibilityIdentifier = headerText
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: QuestionViewController.cellid)
        tableView.dataSource = self
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return options.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: QuestionViewController.cellid,
            for: indexPath
        )
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

// NOTE: Static dispatching trick
extension QuestionViewController {
    static let headerTitle: String = "header-title"
    static let cellid: String = "cellid"
}
