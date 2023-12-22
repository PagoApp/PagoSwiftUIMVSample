//
//  
//  PagoTermsAndConditionsRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public class PagoTermsAndConditionsRepository: PagoRepository {
    
    public init() {}
    
    func getData(predicate: PagoPredicate) -> Model? {

        guard let predicate = predicate as? PagoTermsAndConditionsPredicate else { return nil }
        
        let webModel: PagoWebModel
        if containsHTMLTag(predicate.htmlString) {
            webModel = PagoWebModel(htmlString: predicate.htmlString)
        } else {
            webModel = PagoWebModel(urlString: predicate.htmlString)
        }
        

        var infoLabel: PagoLabelModel?
        if let info = predicate.info {
            let infoStyle = PagoLabelStyle(textColorType: .darkGraySecondaryText, fontType: .regular17, alignment: .center, numberOfLines: 0, inset: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
            let accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.staticText, accessibilityLabel: info)
            infoLabel = PagoLabelModel(text: info, style: infoStyle, accessibility: accessibility)
        }
        var mainModel: PagoButtonModel?
        if let title = predicate.mainAction {
            mainModel = PagoButtonModel(title: title, type: .main)
            let accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button, accessibilityLabel: title)
            mainModel?.accessibility = accessibility
        }
        var secondaryModel: PagoButtonModel?
        if let title = predicate.secondaryAction {
            let style = PagoButtonStyle(font: .semiBold17, textColor: .blueHighlight, backgroundColor: .clear)
            let accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button, accessibilityLabel: title)
            secondaryModel = PagoButtonModel(title: title, style: style, height: 48, accessibility: accessibility)
        }
        var acceptCheckboxModel: PagoCheckboxModel?
        if let title = predicate.acceptCheckbox {
            let selectedStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .selectedState)
            let deselectedStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .deselectedState)
            let errorStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .errorState)
            let disabledStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .disabledState)
            let checkboxStyle = PagoCheckboxStyle(selectedStateStyle: selectedStateStyle, deselectedStateStyle: deselectedStateStyle, errorStateStyle: errorStateStyle, disabledStateStyle: disabledStateStyle, imageSize: PagoCheckBoxSize.small, hasBackground: true)
            let accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: .button, accessibilityLabel: title)
			let isUserInteractionEnabled = !predicate.shouldScrollToBottomToEnableAcceptCheckbox
			
            acceptCheckboxModel = PagoCheckboxModel(title: title, style: checkboxStyle, isUserInteractionEnabled: isUserInteractionEnabled, accessibility: accessibility)
        }
        return PagoTermsAndConditionsModel(webModel: webModel, labelModel: infoLabel, mainModel: mainModel, secondaryModel: secondaryModel, acceptCheckboxModel: acceptCheckboxModel)
    }
	
	func getInfoAlertPredicate(message: String) -> PagoInfoAlertPredicate {
		
		let predicate = PagoInfoAlertPredicate(message: message)
		return predicate
	}
    
    public func containsHTMLTag(_ input: String) -> Bool {
        let htmlTagPattern = #"<\s*([a-zA-Z0-9]+)(?:\s+([a-zA-Z0-9]+="[^"]*"\s*)*)\s*/?>|<\/\s*([a-zA-Z0-9]+)\s*>"#
        let range = NSRange(location: 0, length: input.utf16.count)
        let regex = try? NSRegularExpression(pattern: htmlTagPattern)
        
        if let regex = regex {
            let matches = regex.matches(in: input, options: [], range: range)
            return !matches.isEmpty
        }
        
        return false
    }
}
