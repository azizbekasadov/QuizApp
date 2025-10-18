//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Azizbek Asadov on 18.10.2025.
//

import UIKit

final class ResultsViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var summary: String = ""
    private var answers: [PresentableAnswer] = []
    
    convenience init(summary: String, answers: [PresentableAnswer] = []) {
        self.init()
        
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = self.summary
        
        tableView.register(CorrectAnswerCell.self, forCellReuseIdentifier: "cellid0")
        tableView.register(WrongAnswerCell.self, forCellReuseIdentifier: "cellid1")
        tableView.reloadData()
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        
        let cell: UITableViewCell
        if answer.isCorrect {
            cell = makeCorrectAnswerCell(for: answer)
        } else {
            cell = makeWrongAnswerCell(for: answer)
        }
        
        return cell
    }
    
    private func makeCorrectAnswerCell(
        for answer: PresentableAnswer
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid0") as! CorrectAnswerCell
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func makeWrongAnswerCell(
        for answer: PresentableAnswer
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid1") as! WrongAnswerCell
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        return cell
    }
}
