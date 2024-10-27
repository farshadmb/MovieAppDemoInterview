//
//  DateFormatter+Ext.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

extension DateFormatter {

    static let standardFormatter: DateFormatter = {

        let calendar = Calendar.current
        let locale = NSLocale.system

        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeZone = NSTimeZone.system

        return formatter
    }()

    static let currentZoneFormatter: DateFormatter = {

        let calendar = Calendar.current
        let locale = Locale.current

        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.calendar = calendar

        return formatter
    }()

}
