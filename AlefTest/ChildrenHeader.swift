//
//  ChildrenHeader.swift
//  AlefTest
//
//  Created by Gold_Mock on 06.03.2022.
//

import Foundation
import UIKit

protocol CHildrenHeaderDeledate: AnyObject {
    func addButtonTapped(_ childrenHeader: ChildrenHeader?)
}

class ChildrenHeader: UITableViewHeaderFooterView {
    
    var delegate: CHildrenHeaderDeledate?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дети (макс. 5)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { [weak self] _ in
            self?.delegate?.addButtonTapped(self)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle(" Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(addButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/2),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/2 + 10),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
   
}
