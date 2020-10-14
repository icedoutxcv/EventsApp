//
//  Date+Extensions.swift
//  EventsApp
//
//  Created by icedoutxcv on 11/10/2020.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentFormatter.unitsStyle = .full
        return dateComponentFormatter.string(from: self, to: endDate)
    }
}
