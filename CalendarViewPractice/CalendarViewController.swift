//
//  CalendarViewController.swift
//  CalendarViewPractice
//
//  Created by YUJIN KWON on 2023/09/13.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    private lazy var selectedDate: DateComponents? = nil
    private lazy var filteredEvents: [Event] = []
    
    private lazy var calendarView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpNavigationBar()
        setCalendar()
        reloadCalendarView(date: Date())
    }
    
    private func setCalendar() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
    
    private func reloadCalendarView(date: Date?) {
        if let date = date {
            let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            filteredEvents = events.filter { $0.dateComponents == selectedDateComponents }
        } else {
            filteredEvents = []
        }
        
        tableView.reloadData()
        
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.year, .month, .day], from: date!)], animated: true)
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadCalendarView(date: calendar.date(from: dateComponents!))
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UITableViewCell() }
        let event = filteredEvents[indexPath.row]
        cell.textLabel?.text = event.title
        cell.setUp()
        return cell
    }
}

private extension CalendarViewController {
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
    }
    
    @objc func addBtnPressed() {
        let vc = AddEventViewController()
        self.present(vc, animated: true)
    }
    
    func setUpLayout() {
        [calendarView, tableView].forEach { view.addSubview($0) }
        
        calendarView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(25)
        }
    }
}
