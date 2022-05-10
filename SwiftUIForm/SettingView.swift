//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Félix Tineo Ortega on 28/4/22.
//

import Foundation
import SwiftUI

struct SettingView:View{
    @Environment(\.presentationMode) var presentatioMode
    @EnvironmentObject var settingStore: SettingStore
    @State private var selectedOrder:SortingType = .alphabetic
    @State private var pickerEdited: Bool = false
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    
    var body: some View{
        NavigationView{
            Form{
                Section(header:Text("SORT PREFERENCE")){
                    Picker(selection: self.$selectedOrder) {
                        ForEach(SortingType.allCases, id:\.self){sortingType in
                            Text(sortingType.text)
                        }
                    } label: {
                        Text("Display Order")
                    }.onDisappear {
                        pickerEdited = true
                    }

                }
                Section(header:Text("FILTER PREFERENCE")){
                    Toggle(isOn: self.$showCheckInOnly) {
                        Text("Show Check-in Only")
                    }
                    Stepper {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5{
                            self.maxPriceLevel = 5
                        }
                        print(maxPriceLevel)
                    } onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1{
                            self.maxPriceLevel = 1
                        }
                        print(maxPriceLevel)
                    } label: {
                        Text("Show \(String(repeating: "$", count: self.maxPriceLevel)) or bellow")
                    }

                }
            }.navigationTitle("Settings")
                .onAppear{
                    if !pickerEdited {
                        self.selectedOrder = self.settingStore.displayOrder
                        self.showCheckInOnly = self.settingStore.showCheckInOnly
                        self.maxPriceLevel = self.settingStore.maxPriceLevel
                    }

                }
                .toolbar {
                    ToolbarItem(placement:.navigationBarLeading){
                        Button {
                            self.presentatioMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button {
                            self.settingStore.maxPriceLevel = self.maxPriceLevel
                            self.settingStore.displayOrder = self.selectedOrder
                            self.settingStore.showCheckInOnly = self.showCheckInOnly
                            self.presentatioMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                        }

                    }
                }
        }
    }
}

struct SettingViewPreview: PreviewProvider{
    static var previews: some View{
        SettingView().environmentObject(SettingStore())
    }
}
