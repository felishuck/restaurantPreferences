//
//  SettingStore.swift
//  SwiftUIForm
//
//  Created by Félix Tineo Ortega on 30/4/22.
//

import Foundation
import Combine

final class SettingStore: ObservableObject{
    init(){
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly": true,
            "view.preferences.displayOrder": 0,
            "view.preferences.maxPriceLevel": 5
        ])
    }
    
    @Published var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferences.showCheckInOnly"){
        didSet{
            UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }
    
    @Published var displayOrder: SortingType = SortingType(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")){
        didSet{
            UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
    }
    
    @Published var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferences.maxPriceLevel"){
        didSet{
            UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
        }
    }
    
    var description: String {
        return "Check-in Only: \(self.showCheckInOnly)\nDisplay Order: \(self.displayOrder)\nMax Price Level: \(self.maxPriceLevel)"
    }
}
