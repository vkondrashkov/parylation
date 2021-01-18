//
//  PushNotificationsUseCase.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 5.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UserNotifications
import RxSwift

public enum PushNotificationsUseCaseError: Error {
    case failed
    case underlying(Error)
}

public protocol PushNotificationsUseCase: AnyObject {
    func isPermissonGranted() -> Single<Bool>
    func requestPermissions() -> Single<Bool>
    func scheduleNotification(_ notification: PushNotification) -> Single<Void>
}

public final class PushNotificationsUseCaseImpl: PushNotificationsUseCase {
    private let center: UNUserNotificationCenter

    public init() {
        center = UNUserNotificationCenter.current()
    }

    public func isPermissonGranted() -> Single<Bool> {
        return .create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.center.getNotificationSettings(completionHandler: { settings in
                single(.success(settings.authorizationStatus == .authorized))
            })
            return Disposables.create()
        }
    }

    public func requestPermissions() -> Single<Bool> {
        return .create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.center.requestAuthorization(
                options: [.alert, .sound, .badge],
                completionHandler: { isGranted, error in
                    if let error = error, !isGranted {
                        single(.error(PushNotificationsUseCaseError.underlying(error)))
                    } else {
                        single(.success(isGranted))
                    }
                }
            )
            return Disposables.create()
        }
    }

    public func scheduleNotification(_ notification: PushNotification) -> Single<Void> {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = .default
        content.badge = NSNumber(value: notification.badge)

        let triggerDate = Calendar.current.dateComponents(
            [.year,.month,.day,.hour,.minute,.second,],
            from: notification.date
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(
            identifier: notification.id,
            content: content,
            trigger: trigger
        )
        return .create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.center.removePendingNotificationRequests(withIdentifiers: [notification.id])
            self.center.add(request, withCompletionHandler: { error in
                if let error = error {
                    single(.error(PushNotificationsUseCaseError.underlying(error)))
                } else {
                    single(.success(()))
                }
            })
            return Disposables.create()
        }
    }
}
