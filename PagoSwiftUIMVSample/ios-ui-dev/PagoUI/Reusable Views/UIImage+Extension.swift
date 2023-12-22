//
//  UIImage+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

internal extension UIImage {
    
    public enum PagoAnimation: String {
        case loading = "loading"
        case rcaLoading = "rca_offers_loading"
        case statusLoading = "status_loading"
        case statusLoadingBT = "status_loading_bt"
        case statusError = "status_error"
        case statusCheckMark = "status_checkmark"
        case providersNews = "providers_info"
        case onboarding_start_ro = "onboarding1_RO"
        case onboarding_start_it = "onboarding1_IT"
        case onboarding_start_pl = "onboarding1_PL"
        case onboarding_history = "onboarding2"
        case onboarding_bills = "onboarding3"
        case onboarding_points = "onboarding4"
        case onboarding_features_ro = "onboarding5_RO"
        case onboarding_features_en = "onboarding5_EN"
        case moneyTransfer_succesfulAddedCard = "add_card"
        case moneyTransfer_intro = "animatie_intro"
        case moneyTransfer_addDetails = "add_details"
        case moneyTransfer_contactPermission = "animatie_contacts"
        case moneyTransfer_limit = "animatie_limit"
        case moneyTransfer_pending = "animatie_pending"
        case moneyTransfer_finalized = "animatie_successful"
        case moneyTransfer_cardValidation = "card_validation"
        case moneyTransfer_finalTransfer = "finalize_transfer"
        case moneyTransfer_declineTransfer = "request_declined"
        case moneyTransfer_phone = "animatie_telefon"
        case syncingStatus = "syncing"
        case errorStatus = "error"
        case successStatus = "success"
        case neutralStatus = "neutral"
        
        public var animation: String { return self.rawValue }
    }

    public enum Pago: String {
        case none = ""
        case checkmark
		case error = "error"
		case warning = "warning"
        case roundedCheckBoxMultipleSelected = "icon_rounded_checkbox_multiple_selected"
        case roundedCheckBoxSelected = "icon_rounded_checkbox_selected"
        case roundedCheckBoxDeselected = "icon_rounded_checkbox_deselected"
        case checkBoxSelected = "icon_checkbox_selected"
        case checkBoxDeselected = "icon_checkbox_deselected"
        case show = "icon_show"
        case hide = "icon_hide"
        case lock = "icon_lock"
        case smallQuestionIcon = "icon_small_question_mark"
        case largeQuestionIcon = "icon_large_question_mark"
        case calendar = "icon_calendar"
        case noResult = "icon_empty_result"
        case locationShared = "icon_location_shared"
        case locationScanned = "icon_location_scanned"
        case locationRecurring = "icon_location_recurring"
        case locationIconChild = "icon_location_child"
        case locationIconGrandParents = "icon_location_grandparents"
        case locationIconHome = "icon_location_home"
        case locationIconOffice = "icon_location_office"
        case locationIconOther = "icon_location_other"
        case locationIconParents = "icon_location_parents"
        case locationIconRent = "icon_location_rent"
        case locationIconVacation = "icon_location_vacation"
        case close = "icon_close"
        case search = "icon_search"
        case scanIconSmall = "icon_scan_small"
        case scanIcon = "icon_scan"
        case editIcon = "icon_edit"
        case pointsIcon = "icon_pago_points"
        case disclosureIcon = "icon_disclosure"
        case masterCard = "icon_masterCard"
        case pciPartnerIcon = "partner_pci"
        case btPartnerIcon = "partner_bt"
        case romcardPartnerIcon = "partner_romcard"
        case credoraxPartnerIcon = "credorax_logo"
        case maestroCard = "icon_maestroCard"
        case visaLogo = "partner_visa"
        case visaCard = "icon_visaCard"
        case visaWhite = "visa_white"
        case unknownCard = "icon_unknownCard"
        case touchId = "icon_touch_id"
        case faceId = "icon_face_id"
        case keyboardDelete = "icon_delete_digit"
        case resetPinIllustration = "image_reset_pin"
        case securityCodeIllustration = "image_security_code"
        case faceIdIllustration = "image_face_id"
        case touchIdIllustration = "image_touch_id"
        case instructionsSentIllustration = "image_instructions_sent"
        case emptyBillsIllustration = "image_empty_bills"
        case scanArrowHintIllustration = "image_scan_arrow_hint"
        case filterIcon = "icon_filter"
        case whySyncBillIcon = "icon_why_sync_bill"
        case whySyncPointsIcon = "icon_why_sync_points"
        case whySyncHistoryIcon = "icon_why_sync_history"
        case whySyncTapIcon = "icon_why_sync_tap"
        case newRedesignRONewIllustration = "image_new_redesign_intro_ro_0"
        case newRedesignROStepByStepIllustration = "image_new_redesign_intro_ro_1"
        case newRedesignROWhatsNewIllustration = "image_new_redesign_intro_ro_2"
        case historyTabBarIcon = "icon_history"
        case billsTabBarIcon = "icon_bills_tab_bar"
        case topUpTabBarIcon = "icon_recharge_tab_bar"
        case otherTabBarIcon = "icon_other_tab_bar"
        case insurancesTabBarIcon = "icon_insurances_tab_bar"
        case moreTabBarIcon = "icon_settings_tab_bar"
        case moneyTransferTabBarIcon = "icon_money_transfer_tab_bar"
        case taxesTabBarIcon = "icon_taxes_tab_bar"
        case donationsTabBarIcon = "icon_donations_tab_bar"
        case donationsIllustration = "image_what_to_pay_donations"
        case exploreIllustration = "image_what_to_pay_explore"
        case taxesIllustration = "image_what_to_pay_taxes"
        case carInsurancesIllustration = "image_what_to_pay_car_insurances"
        case travelInsurancesIllustration = "image_what_to_pay_travel_insurances"
        case billsIllustration = "image_what_to_pay_bills"
        case topupIllustration = "image_what_to_pay_topup"
        case topupAutomatedEmptyStateIllustration = "image_topup_automated"
        case topupRecentEmptyStateIllustration = "image_topup_recent"
        case nextArrow = "nextArrow"
        case barCodeIcon = "barCodeIcon"
        case qrCodeIcon = "qrIcon"
        case freemiumStar = "freemium_star"
        case freemium_payments = "payments"
        case freemium_topup = "topup"
        case freemium_insurance = "insurance"
        case freemium_supplier = "supplier"
        case freemium_points = "points"
        case freemium_functionalities = "functionalities"
        case freemium_support = "support"
        case freemium_alerts = "alerts"
        case freemium_offers = "offers"
        case freemium_taxes = "taxes"
        case freemium_transfer = "transfer"
        case freemiumXMasPromoIllustration = "image_xmas_promo"
        case infographic2020Illustration = "image_infographic_2020"
        case infographicPreviousYearsIllustration = "image_infographic_previous_years"
        case infographicConfettiIllustration = "image_infographic_confetti"
        case infographic2020Confetti = "image_infographic_2020_confetti"
        case topUsersIllustration = "image_top_users"
        case timeSavedIllustration = "image_time_saved"
        case pointsIllustration = "image_points"
        case cardsIllustration = "image_cards"
        case logo = "logo_pago"
        case logoWhite = "logoPagoWhite"
        case suppliersIllustration = "image_all_suppliers"
        case crossroadsIllustration = "image_crossroads"
        case liveChatIcon = "icon_liveChat"
        case settingsIcon = "icon_settings"
        case carAlertIcon = "icon_car_alert"
        case cardsIcon = "icon_cards"
        case fingerprintIcon = "icon_fingerprint"
        case friendsIcon = "icon_friends"
        case languageIcon = "icon_language"
        case locationsIcon = "icon_locations"
        case logoutIcon = "icon_logout"
        case notificationsIcon = "icon_notifications"
        case pointsSettingsIcon = "icon_points"
        case plVisaPromoSettingsIcon = "icon_visa_pl_terms"
        case promoCodeIcon = "icon_promo_code"
        case questionsIcon = "icon_questions"
        case securityIcon = "icon_security"
        case thermsIcon = "icon_therms"
        case subscriptionsIcon = "icon_subscriptions"
        case phoneBookIcon = "icon_phone_book"
        case sendContactMoneyIcon = "icon_send_money_contact"
        case moneyTransferLimit = "icon_money_transfer_limit"
        case upcPLClientCodeIllustration = "image_upc_client_code_sync_provider"
        case recurringIcon = "icon_recurring"
        case deleteIcon = "icon_delete"
        case deleteOffIcon = "icon_delete_off"
        case rightIcon = "icon_right"
        case leftIcon = "icon_left"
        case warningQuestionIcon = "icon_warning_info"
        case prepayIntroIllustration = "recharge_intro_icon"
        case plVisaPromoIcon = "pl_visa_intro_icon"
        case genericContactIcon = "icon_generic_contact"
        case expireDate = "icon_expire_time"
        case limitAlertIllustration = "image_limit_alert"
        case rcaCampaignIntroIllustration = "image_rca_campaign"
        case securityIllustration = "image_security_user_privacy"
        case subscriptionFreeIcon = "free"
        case subscriptionPremiumIcon = "premium"
        case subscriptionLimitlessIcon = "limitless"
        case historyClockIllustration = "history_illustration"
        case featureIcon = "icon_feature"
        case premiumProvidersBillsIllustration = "image_premium_providers_bills_campaign"
        case btPayMigrate = "image_btpay_migrate"
        case sliderDragIcon = "icon_slider_drag"
        case prepayCampaignIllustration = "image_prepay_campaign"
        case travelCampaignIllustration = "image_travel_campaign"
        case mailedBillIllustration = "mailed_bill_illustration"
        case scanBillIllustration = "scan_bill_illustration"
        case onlineBillIllustration = "online_bill_illustration"
        case otherBillIllustration = "other_bill_illustration"
        case paypointBillIllustration = "paypoint_bill_illustration"
        case stationBillIllustration = "station_bill_illustration"
        case whiteCheckMarkIcon = "white_checkmark_icon"
        
        case popupCustomProviderIcon = "popup_custom_provider"
        case popupAlerts = "popup_alerts"
        case popupVipSupport = "popup_vip_support"
        case popupFunctionalities = "popup_functionalities"
        case infoProviderIcon = "info_provider"
        case infoCarAlertIcon = "info_car_alert"
        case infoSupportIcon = "info_support"
        case infoTaxesIcon = "info_taxes"
        case infoBillsIcon = "info_bills"
        case premiumProviderCampaign = "freemiumProviderCampaign"
        case pagoCoin = "pago_coin"
        
        case moneyTransferLimitIcon = "money_transfer_limit"
        case moneyTransferCardLimitIcon = "money_transfer_card_limit_icon"
        case moneyTransferFinalizedIcon = "money_transfer_transfer_finalized_icon"
        case moneyTransferCardValidationIcon = "money_transfer_card_validation"
        case moneyTransferSuccsefulCardAddedIcon = "money_transfer_succesful_card_added"
        case moneyTransferPendingIcon = "money_transfer_pending"
        case moneyTransferMissingDetailsIcon = "money_transfer_missing_details"
        case moneyTransferRequestIcon = "money_transfer_request"
        case moneyTransferDeclineIcon = "money_transfer_decline"
        case moneyTransferComissionIcon = "money_transfer_comission"
        case moneyTransferRequestSentIcon = "money_transfer_request_sent"
        
        case topupDisabledIllustration = "image_topup_disabled"
        case rcaDisabledIllustration = "image_rca_disabled"
        case genericErrorIllustration = "error_illustration"
        case contactsPermissionIllustration = "contacts_permission_illustration"
        case premiumProviderIllustration = "premium_provider_illustration"
        case accountError = "rds_error"
        case vodaPrize = "vodaPrize"
        case vodaCampaignSmall = "vodaCampaignSmall"
        case vodaShare = "vodaShare"
        case vodaCampaignMedium = "vodaCampaignMedium"
        case playIcon = "playVideoIcon"
        case moneyBagIcon = "moneyBagIcon"
        
        case recommandFacebookLoginIcon = "recommand_facebook_login"
        case recommandGoogleLoginIcon = "recommand_google_login"
        case recommandAppleLoginIcon = "recommand_apple_login"
        case singleBillIllustration = "one_bill_illustration"
        case freemiumPremiumStar = "freemium_premium_star"
        case accessibilityIllustration = "accessibility_illustration"
        
        case firstScanBillIllustration
        case reminderIllustration
        case scanBillCameraPermissionDeniedIllustration
        case scanBillCameraPermissionIllustration
        case securePaymentIllustration
        case mastercardLogo = "partner_mastercard"
        
        case premiumProvidersExplainedIllustration = "premiumProvidersExplainedIllustration"
        
        case settingsMTLegal = "icon_mt_legal"
        case settingsMTCampignLegal = "icon_mt_campaign_legal"
        
        case switchIcon = "icon_swap"
        case dropdownIcon = "dropdown_icon"
        
        case checkMarkCompleted = "icon_step_completed"
        case iconBackArrow = "icon_back_arrow"
        case iconNextArrow = "icon_next_arrow"

        case zoomIn = "icon_zoom_in"
        case zoomOut = "icon_zoom_out"
        
        case cameraFlashOn = "icon_camera_flash_on"
        case cameraFlashOff = "icon_camera_flash_off"
        case cameraGallery = "icon_camera_gallery"
        case cameraTakePhoto = "icon_camera_take_photo"
        case pdfIcon = "icon_pdf"

        case pagoLogo = "pago_logo"
        case renomiaLogo = "renomia_logo"

        case emailIcon = "icon_email"
        case pdfInfoIcon = "icon_pdf_info"
        case brokerIcon = "icon_broker"
        case termsConditionsIcon = "icon_terms_conditions"
        case personalDataIcon = "icon_personal_data"
        case complaintIcon = "icon_complaint"
        case phoneIcon = "icon_phone"
        case consentData = "icon_consent"

        var blueImageNames: String {
            return "\(imageName)_blue"
        }
        
        public var imageName: String {
            return self.rawValue
        }
        
        public var image: UIImage? {
            let pagoUIBundleIdentifier = "com.pago.PagoUI"
            let pagoUIBundle = Bundle.init(identifier: pagoUIBundleIdentifier)
            
            return imageName.count > 0 ? UIImage(named: imageName, in: pagoUIBundle, with: nil) : nil
        }
        
        public var originalImage: UIImage? {
            return UIImage(pagoImage: self)?.withRenderingMode(.alwaysOriginal)
        }
        
        public var templateImage: UIImage? {
            return UIImage(pagoImage: self)?.withRenderingMode(.alwaysTemplate)
        }
            
        public func image(tinted: UIColor.Pago) -> UIImage? {
            return templateImage?.tint(with: tinted.color)
        }
    }
    
    func tint(with color: UIColor) -> UIImage? {
        
        guard size.width > 0, size.height > 0 else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
        return nil
        }

        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)

        context.setBlendMode(.multiply)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        color.setFill()
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }
}

internal extension UIImage {
    
    convenience public init?(pagoImage: UIImage.Pago) {
        
        if pagoImage.imageName.count > 0 {
            let pagoUIBundleIdentifier = "com.pago.PagoUI"
            let pagoUIBundle = Bundle.init(identifier: pagoUIBundleIdentifier)

            self.init(named: pagoImage.imageName, in: pagoUIBundle, with: nil)
        } else {
            self.init()
        }
    }
}

internal extension UIImage {

    func bw(completion : @escaping (UIImage?) -> ()) {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let imageRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        context!.fill(imageRect)
        self.draw(in: imageRect, blendMode: CGBlendMode.colorDodge, alpha: 0.7)
        self.draw(in: imageRect, blendMode: CGBlendMode.luminosity, alpha: 0.9)
        self.draw(in: imageRect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let grayscaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        completion(grayscaleImage)
    }
    
    func tint(color : UIColor, completion: @escaping (UIImage?) -> ()) {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let imageRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        let context = UIGraphicsGetCurrentContext()
        context?.fill(imageRect)
        
        draw(in: imageRect, blendMode: .overlay, alpha: 1.0)
        draw(in: imageRect, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        completion(tintedImage)
    }
    
}

internal extension UIImage {
    
    func blackAndWhiteImage() -> UIImage {
        
        guard let currentCGImage = cgImage else { return self }
        let currentCIImage = CIImage(cgImage: currentCGImage)
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
        filter?.setValue(1, forKey: "inputIntensity")
        
        guard let outputCIImage = filter?.outputImage else { return self }
        let context = CIContext()
        if let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
            return UIImage(cgImage: outputCGImage)
        }
        
        return self
    }
}
