//
//  PagoLocalNotificationManager.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 05.05.2023.
//

import UserNotifications

public class PagoLocalNotificationManager {

    public static let shared = PagoLocalNotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]

    public enum PagoNotificationType: String {
        case none = "LocalNotificationNone"
        case rca = "LocalNotificationReminderRCA"
    }

    public static let pagoNotificationIDKey = "pagoNotificationKeyID"
    public static let pagoNotificationTypeIDKey = "pagoNotificationTypeIDKey"

    static func notificationType(from userInfo: [AnyHashable: Any]) -> PagoNotificationType {
        guard let userInfo = userInfo as? [String: Any], let typeRaw = userInfo[pagoNotificationTypeIDKey] as? String, let type = PagoNotificationType(rawValue: typeRaw) else {
            return .none
        }
        return type
    }
    
    public func schedule(notificationId: String, title: String, body: String, userInfo: [String: Any]?, date: Date, categoryIdentifier: String, completion: @escaping (Bool)->()) {

        notificationCenter.getNotificationSettings { [weak self] (settings) in
            guard settings.authorizationStatus == .authorized else {
                completion(false)
                return
            }
            
            let content = UNMutableNotificationContent()
            
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = categoryIdentifier
            if let userInfo = userInfo {
                content.userInfo = userInfo
            }
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
            self?.notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
            self?.notificationCenter.add(request) { (error) in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
}
