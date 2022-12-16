//
//  calendarControll.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/17.
//

import Foundation
import EventKitUI

class EventStore {
    private let eventStore: EKEventStore
    
    init() {
        eventStore = EKEventStore()
    }
    
    func getAuthorizationStatus() -> Bool {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .notDetermined:
            return false
        case .restricted:
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            return false
        case .denied:
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            return false
        case .authorized:
            return true
        @unknown default:
            return false
        }
    }
    
    @MainActor
    func requestAccess() async {
        if getAuthorizationStatus() {
            
            return
        }
        else {
            do {
                try await eventStore.requestAccess(to: .event)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addEvent(startDate: Date, endDate: Date, title: String) async {
        let defaultCalendar = eventStore.defaultCalendarForNewEvents
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = defaultCalendar
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            print(error.localizedDescription)
        }
    }
}
