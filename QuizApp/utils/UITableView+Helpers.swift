//
//  UITableView+Helpers.swift
//  QuizApp
//
//  Created by Azizbek Asadov on 18.10.2025.
//

import UIKit

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        let cell = dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
        cell?.awakeFromNib()
        return cell
    }
    
    func title(at row: Int) -> String? {
        let cell = cell(at: row)
        
        return cell?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
