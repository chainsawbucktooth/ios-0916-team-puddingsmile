//
//  AddMarketPickerView.swift
//  GroupProject
//
//  Created by Alexander Mason on 11/29/16.
//  Copyright © 2016 Alexander Mason. All rights reserved.
//

import Foundation
import UIKit

protocol TimePickerDelegate: class {
    
    func stringInfoDelegateOpen(time: String)
    
    func stringInfoDelegateClose(time: String)

}

class AddMarketPicker: UIView {
    
    weak var delegate: TimePickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
//        setupOpenTimeLabel()
//        setupCloseTimeLabel()
//        setupLeftPicker()
//        setupRightPicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let enterOpenTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Open Time"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.themePrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enterCloseDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Close Time"
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.themePrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = UIDatePickerMode.time
        picker.minuteInterval = 30
        picker.backgroundColor = UIColor.themeAccent1
        picker.locale = Locale.current
        picker.layer.borderColor = UIColor.themeAccent2.cgColor
        picker.layer.borderWidth = 3
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let rightDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = UIDatePickerMode.time
        picker.minuteInterval = 30
        picker.locale = Locale.current
        picker.calendar = Calendar.current
        picker.backgroundColor = UIColor.themeAccent1
        picker.layer.borderColor = UIColor.themeAccent2.cgColor
        picker.layer.borderWidth = 3
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    func leftDateDidChange(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmaa"
        delegate?.stringInfoDelegateOpen(time: dateFormatter.string(from: sender.date))
        
    }
    
    func rightDateDidChange(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmaa"
        delegate?.stringInfoDelegateClose(time: dateFormatter.string(from: sender.date))
    }
    
}

extension AddMarketPicker {
    
    func setupOpenTimeLabel() {
        self.addSubview(enterOpenTimeLabel)
        enterOpenTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        enterOpenTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        enterOpenTimeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        enterOpenTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    func setupCloseTimeLabel() {
        self.addSubview(enterCloseDayLabel)
        enterCloseDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        enterCloseDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        enterCloseDayLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        enterCloseDayLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupLeftPicker() {
        self.addSubview(leftDatePicker)
        
        leftDatePicker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        leftDatePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        leftDatePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftDatePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftDatePicker.addTarget(self, action: #selector(leftDateDidChange), for: .valueChanged)

    }
    
    func setupRightPicker() {
        self.addSubview(rightDatePicker)
        
        rightDatePicker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        rightDatePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        rightDatePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightDatePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rightDatePicker.addTarget(self, action: #selector(rightDateDidChange), for: .valueChanged)
    }
    
    
}












