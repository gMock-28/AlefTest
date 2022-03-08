//
//  ChildrenFooter.swift
//  AlefTest
//
//  Created by Gold_Mock on 07.03.2022.
//

import Foundation
import UIKit

protocol CHildrenFooterDeledate: AnyObject {
    func cleanButtonTapped(_ childrenHeader: ChildrenFooter?)
}

class ChildrenFooter: UITableViewHeaderFooterView {
    
    var delegate: CHildrenFooterDeledate?
    
    lazy var cleanButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { [weak self] _ in
            self?.delegate?.cleanButtonTapped(self)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(cleanButton)
        
        NSLayoutConstraint.activate([
            cleanButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            cleanButton.heightAnchor.constraint(equalToConstant: 40),
            cleanButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cleanButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
