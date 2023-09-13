//
//  CalendarViewController.swift
//  CalendarViewPractice
//
//  Created by YUJIN KWON on 2023/09/13.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    lazy var calendarView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
    
    var selectedDate: DateComponents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setCalendar()
        reloadCalendarView(date: Date())
    }
    
    fileprivate func setCalendar() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
    
    func reloadCalendarView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadCalendarView(date: Calendar.current.date(from: dateComponents!))
    }
}

private extension CalendarViewController {
    func setUpLayout() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
