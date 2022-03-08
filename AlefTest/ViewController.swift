//
//  ViewController.swift
//  AlefTest
//
//  Created by Gold_Mock on 06.03.2022.
//

import UIKit

struct data {
    var name: String
    var age: String
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "parentCell")
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "childrenCell")
        table.register(ParentHeader.self, forHeaderFooterViewReuseIdentifier: "parentHeader")
        table.register(ChildrenHeader.self, forHeaderFooterViewReuseIdentifier: "childrenHeader")
        table.register(ChildrenFooter.self, forHeaderFooterViewReuseIdentifier: "childrenFooter")
        return table
    }()
    
    private var parentData = data(name: "", age: "") {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var childrenData = [data]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        configureTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return childrenData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId: String
        var name: String
        var age: String
        if indexPath.section == 0 {
            cellId = "parentCell"
            name = parentData.name
            age = parentData.age
        } else {
            cellId = "childrenCell"
            name = childrenData[indexPath.row].name
            age = childrenData[indexPath.row].age
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.nameTF.text = name
        cell.ageTF.text = age
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "parentHeader") as! ParentHeader
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "childrenHeader") as! ChildrenHeader
            if childrenData.count < 5 {
                header.addButton.isHidden = false
            }
            header.delegate = self
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "childrenFooter") as! ChildrenFooter
            footer.delegate = self
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 42
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 42
        }
        return 0
    }
    
    private func presentAlert() {
        let alert = UIAlertController()
        alert.title = "Очистить"
        alert.message = "Вы уверены, что хотите сбросить все введенные данные?"
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let clearAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            self?.parentData = data(name: "", age: "")
            self?.childrenData = [data]()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(clearAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: CHildrenHeaderDeledate, CHildrenFooterDeledate {
    
    func addButtonTapped(_ childrenHeader: ChildrenHeader?) {
        childrenData.append(data(name: "", age: ""))
        if childrenData.count == 5 {
            childrenHeader?.addButton.isHidden = true
        } else {
            childrenHeader?.addButton.isHidden = false
        }
    }
    
    func cleanButtonTapped(_ childrenHeader: ChildrenFooter?) {
        presentAlert()
    }
    
}

extension ViewController: CustomTableViewCellDelegate {
    func delButtonTapped(customCell: CustomTableViewCell?, for indexPath: IndexPath?) {
        childrenData.remove(at: indexPath!.row)
    }
    
    func nameEdited(customCell: CustomTableViewCell?, for indexPath: IndexPath?, name: String) {
        if indexPath?.section == 0 {
            parentData.name = name
        } else {
            childrenData[indexPath?.row ?? 0].name = name
        }
    }
    
    func ageEdited(customCell: CustomTableViewCell?, for indexPath: IndexPath?, age: String) {
        if indexPath?.section == 0 {
            parentData.age = age
        } else {
            childrenData[indexPath?.row ?? 0].age = age
        }
    }
    
}
