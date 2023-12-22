//
//  
//  PagoPageControllersModel.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal struct PagoPageControllersModel: Model {
            
    internal var pageControllersStackModel: PagoStackedInfoModel  {
        
        let pageControllerStyle1 = PagoPageControllerStyle(indicatorColor: .redNegative, currentIndicatorColor: .yellowWarning, dividerColor: .blue)
        let pageController1 = PagoPageControllerModel(numberOfPages: 10, currentIndex: 5, style: pageControllerStyle1)
        let pageControllerStyle2 = PagoPageControllerStyle(indicatorColor: .sdkMainButtonColor, currentIndicatorColor: .sdkDarkRed, dividerColor: .sdkMixedGray)
        let pageController2 = PagoPageControllerModel(numberOfPages: 3, currentIndex: 1, style: pageControllerStyle2)
        let pageControllerStyle3 = PagoPageControllerStyle(indicatorColor: .blueHighlight, currentIndicatorColor: .google, dividerColor: .grayTertiaryText)
        let pageController3 = PagoPageControllerModel(numberOfPages: 5, currentIndex: 5, style: pageControllerStyle3)
        
        let stackStyle = PagoStackedInfoStyle(backgroundColor: .white, distribution: .fill, alignment: .fill, axis: .vertical)
        return PagoStackedInfoModel(models: [pageController1, pageController2, pageController3], style: stackStyle)
    }
   

}
