//
//  Date+Extension.swift
//  MyNotesApp
//
//  Created by Mehmet Bilir on 14.06.2022.
//

import Foundation


extension Date {
    
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mm a"
        }else {
            formatter.dateFormat = "dd/MM/yy"
        }
        
        return formatter.string(from: self)
    }
}
