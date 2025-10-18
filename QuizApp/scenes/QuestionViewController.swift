//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Azizbek Asadov on 13.10.2025.
//

import Foundation
import UIKit

typealias Question = String

class QuestionViewController: UIViewController, UITableViewDataSource {
    private(set) var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: QuestionViewController.reuseIdentifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private(set) var headerText: String = ""
    private var question: Question = ""
    private var options = [String]()
    private var selection: (([String]) -> Void)? = nil
    
    convenience init(
        question: Question,
        options: [String],
        selection: @escaping ([String]) -> Void
    ) {
        self.init(nibName: nil, bundle: nil)
        
        self.question = question
        self.options = options
        self.headerText = question
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = question
        navigationItem.titleView?.accessibilityIdentifier = headerText
        
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionViewController.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func dequeueCell(
        _ tableView: UITableView
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionViewController.reuseIdentifier) {
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: QuestionViewController.reuseIdentifier)
    }
    
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
        let cell = dequeueCell(tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

extension QuestionViewController {
    
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPathsForSelectedRows = tableView.indexPathsForSelectedRows else { return [] }
        
        return indexPathsForSelectedRows.map { options[$0.row] }
    }
}

// NOTE: Static dispatching trick
extension QuestionViewController {
    static let headerTitle: String = "header-title"
    static let reuseIdentifier: String = "cellid"
}
