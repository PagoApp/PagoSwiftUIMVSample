//
//  ComponentTableViewCell.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 05.01.2023.
//

import UIKit

class ComponentTableViewCell: UITableViewCell {
	
	static let identifier = "ComponentCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
