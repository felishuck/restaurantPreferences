//
//  SortingType.swift
//  SwiftUIForm
//
//  Created by Félix Tineo Ortega on 30/4/22.
//

import Foundation

enum SortingType:Int, CaseIterable{
    case alphabetic = 0
    case favorite = 1
    case checkIn = 2
    
    init(type:Int){
        switch(type){
        case 0: self = .alphabetic
        case 1: self = .favorite
        case 2: self = .checkIn
        default: self = .alphabetic
        }
    }
    
    var text: String {
        switch self{
        case .alphabetic: return "Alphabetic"
        case .favorite: return "Show Favorite First"
        case .checkIn: return "Show Check-In First"
        }
    }
    
    func predicate() -> ((Restaurant, Restaurant)->Bool){
        switch self{
        case .alphabetic: return {$0.name < $1.name}
        case .checkIn: return {$0.isCheckIn && !$1.isCheckIn}
        case .favorite: return {$0.isFavorite && !$1.isFavorite}
        }
    }
}
