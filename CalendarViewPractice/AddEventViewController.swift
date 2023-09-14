//
//  AddEventViewController.swift
//  CalendarViewPractice
//
//  Created by YUJIN KWON on 2023/09/13.
//

import UIKit
import SnapKit

class AddEventViewController: UIViewController {
    
    var events: [Event] = []
    var selectedDate: Date? = Date()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 추가하기"
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜를 선택해주세요."
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc private func datePickerValueChanged(_ datePicker: UIDatePicker) {
        selectedDate = datePicker.date
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 일정인가요?"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var eventTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return textField
    }()
    
    private lazy var eventDescription: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15.0)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveBtnPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func saveBtnPressed() {
        guard let date = selectedDate, let title = eventTitle.text, let description = eventDescription.text else { return }
        let newEvent = Event(date: date, title: title, description: description)
        events.append(newEvent)
        dismiss(animated: true)
        print(newEvent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpLayout()
    }
}

private extension AddEventViewController {
    func setUpLayout() {
        [titleLabel, dateLabel, datePicker, descriptionLabel, eventTitle, eventDescription, saveButton].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        eventTitle.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(inset)
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30)
        }
        
        eventDescription.snp.makeConstraints {
            $0.top.equalTo(eventTitle.snp.bottom).offset(inset)
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(150)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(eventDescription.snp.bottom).offset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
}
