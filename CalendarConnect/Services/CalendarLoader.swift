//
//  CalendarLoader.swift
//  CalendarConnect
//
//  Created by Reo Ogundare on 10/23/24.
//

import Combine
import GoogleSignIn

final class CalendarLoader: ObservableObject {
    
    static let calendarReadScope = "user.birthday.read"
    private let baseUrlString = "https://calendar.google.com/calendar/u/0?cid=MjJhNDg1YzEzMGI3NDBiNDVjMjE5YmFiMWZlOTAxYjE5YTc4NzdlYWUyMzVhNWFkZTZlNTI1N2IwMDJjODg4YkBncm91cC5jYWxlbmRhci5nb29nbGUuY29t"
    
}
