//
//  CustomTableViewCell.swift
//  AlefTest
//
//  Created by Gold_Mock on 06.03.2022.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func nameEdited(customCell: CustomTableViewCell?, for indexPath: IndexPath?, name: String)
    func ageEdited(customCell: CustomTableViewCell?, for indexPath: IndexPath?, age: String)
    func delButtonTapped(customCell: CustomTableViewCell?, for indexPath: IndexPath?)
}

class CustomTableViewCell: UITableViewCell {
    
    var delegate: CustomTableViewCellDelegate?
    
    lazy var nameBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "Имя"
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.placeholder = "Name"
        tf.addTarget(self,
                     action: #selector(nameEdited),
                     for: .editingDidEnd)
        
        return tf
    }()
    
    @objc private func nameEdited(textField: UITextField) {
        delegate?.nameEdited(customCell: self, for: self.indexPath, name: textField.text ?? "")
    }
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { [weak self] _ in
            self?.delegate?.delButtonTapped(customCell: self, for: self?.indexPath)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()
    
    lazy var ageBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "Возраст"
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var ageTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.placeholder = "Age"
        tf.addTarget(self,
                     action: #selector(ageEdited),
                     for: .editingDidEnd)
        
        return tf
    }()
    
    @objc private func ageEdited(textField: UITextField) {
        delegate?.ageEdited(customCell: self, for: self.indexPath, age: textField.text ?? "")
    }
    
    var indexPath: IndexPath?
    private var identifier: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.identifier = reuseIdentifier
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        
        contentView.addSubview(nameBackground)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTF)
        
        contentView.addSubview(deleteButton)
        
        contentView.addSubview(ageBackground)
        contentView.addSubview(ageLabel)
        contentView.addSubview(ageTF)
        
        var backgroundWidth: CGFloat
        if identifier == "parentCell" {
            backgroundWidth = UIScreen.main.bounds.width - 16
            deleteButton.isHidden = true
        } else {
            backgroundWidth = (UIScreen.main.bounds.width - 16)/2
        }

        NSLayoutConstraint.activate([
            nameBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameBackground.widthAnchor.constraint(equalToConstant: backgroundWidth),
            nameBackground.heightAnchor.constraint(equalToConstant: 68),
            nameBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: nameBackground.topAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: nameBackground.leadingAnchor, constant: 16),
            
            nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTF.leadingAnchor.constraint(equalTo: nameBackground.leadingAnchor, constant: 16),
            nameTF.trailingAnchor.constraint(equalTo: nameBackground.trailingAnchor, constant: -16),
            
            deleteButton.leadingAnchor.constraint(equalTo: nameBackground.trailingAnchor, constant: 24),
            deleteButton.centerYAnchor.constraint(equalTo: nameBackground.centerYAnchor),
            
            ageBackground.topAnchor.constraint(equalTo: nameBackground.bottomAnchor, constant: 8),
            ageBackground.widthAnchor.constraint(equalToConstant: backgroundWidth),
            ageBackground.heightAnchor.constraint(equalToConstant: 68),
            ageBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            ageLabel.topAnchor.constraint(equalTo: ageBackground.topAnchor, constant: 8),
            ageLabel.widthAnchor.constraint(equalToConstant: 100),
            ageLabel.leadingAnchor.constraint(equalTo: ageBackground.leadingAnchor, constant: 16),
            
            ageTF.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8),
            ageTF.leadingAnchor.constraint(equalTo: ageBackground.leadingAnchor, constant: 16),
            ageTF.trailingAnchor.constraint(equalTo: ageBackground.trailingAnchor, constant: -16),
            
        ])
    }
    
}
