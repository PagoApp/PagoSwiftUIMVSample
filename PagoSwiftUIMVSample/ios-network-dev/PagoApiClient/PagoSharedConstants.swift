//
//  SharedConstants.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 26.05.2022.
//

import Foundation

public class PagoSharedConstants: NSObject {
    public static let kTestDataKey = "TestDataKey"
    public static let NotifcationsTokenKey = "NotifcationsToken"
    public static let ReloadInvoicesKey = "ReloadInvoices"
    public static let LocationDataUpdatedKey = "AccountDataUpdated"
    public static let HistoryFilterKey = "FilterHistory"
    public static let TermsAndConditionsUrl = "https://pagoplateste.ro/termenisiconditii.html"
    public static let AccountsSynced = "AccountsSynced"
    public static let authPath = "uaa/oauth/token"
    
    public static let LogoutNotificationKey = "LogoutNotification"
    
    @objc public static let remainingAttempts = "remainingAttempts"
    
    public static let scannedBillsMagicString = "Facturi Scanate"
    public static let scanSaveReleaseDate = "19-02-2019"
    
    public struct Texts {
        public static let configure = "4F3F2F90-0477-4BFF-A6C2-32D7995BEDE3"
        public static let scan = "0f607fe1-85c7-43af-86eb-facd1bf06e91"
    }
    
    public static let AccountSyncTakingTooLongKey = "AccountSyncTakingLongerThanExpected"
    
    
    public static let maxFilterAmount = 500
    public static let minFilterAmount = 0
}
