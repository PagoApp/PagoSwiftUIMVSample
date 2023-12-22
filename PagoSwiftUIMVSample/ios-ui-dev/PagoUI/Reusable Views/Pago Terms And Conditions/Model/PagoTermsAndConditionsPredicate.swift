//
//  
//  PagoTermsAndConditionsPredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public enum PagoTCModalPresentationStyle {
    case pageSheet
    case fullScreen
}

public struct PagoTermsAndConditionsPredicate: PagoPredicate {
    
    ///We will use these two types to differentiate between html code loaded from a remove page
    ///and local html code used to build custom local web pages
    public enum PagoTermsAndConditionsHtmlType {
        /// Type used for a regular web page, Ex: https://www.pago.ro
        case url
        /// Type used for a raw html page. Ex: Local T&C for Pago Integrators
        case datasource
    }
    
    internal var hidesNavigationBar: Bool = false
	internal let htmlString: String
    @available(*, deprecated, message: "It does not help us decide whether it is html or url. We use antoher method for that.")
    internal let webPageType: PagoTermsAndConditionsHtmlType
	internal var info: String?
	internal var mainAction: String?
	internal var secondaryAction: String?
	internal var acceptCheckbox: String?
	internal var modalPresentationStyle: PagoTCModalPresentationStyle?
	internal var shouldScrollToBottomToEnableAcceptCheckbox: Bool
	internal let disabledCheckboxWarningText: String?

    public init(hidesNavigationBar: Bool, urlString: String, webPageType: PagoTermsAndConditionsHtmlType = .datasource, info: String? = nil, mainAction: String? = nil, secondaryAction: String? = nil, acceptCheckbox: String? = nil, modalPresentationStyle: PagoTCModalPresentationStyle? = .pageSheet, shouldScrollToBottomToEnableAcceptCheckbox: Bool = false, disabledCheckboxWarningText: String? = nil) {
        
        self.webPageType = webPageType
        self.hidesNavigationBar = hidesNavigationBar
        self.htmlString = urlString
        self.info = info
        self.mainAction = mainAction
        self.secondaryAction = secondaryAction
        self.acceptCheckbox = acceptCheckbox
        self.modalPresentationStyle = modalPresentationStyle
		self.shouldScrollToBottomToEnableAcceptCheckbox = shouldScrollToBottomToEnableAcceptCheckbox
		self.disabledCheckboxWarningText = disabledCheckboxWarningText
    }
}
