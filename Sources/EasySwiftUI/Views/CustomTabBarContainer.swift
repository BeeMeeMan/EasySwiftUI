//
//  CustomTabBar.swift
//  EasySwiftUI
//
//  Created by Yevhenii Korsun on 26.09.2023.
//

#if !os(macOS)

import SwiftUI

protocol TabItemProtocol: Hashable, CaseIterable {

}

struct CustomTabBarContainer<Content: View, BarContent: View, TabBarItem: TabItemProtocol>: View, KeyboardHelper {
    @State private var tabBarHeight: CGFloat = EasySwiftUI.tabBarHeight
    
    @Binding var selected: TabBarItem
    @ViewBuilder var content: (TabBarItem) -> Content
    @ViewBuilder var barContent: (TabBarItem) -> BarContent
    
    private var allTabs: [TabBarItem] {
        TabBarItem.allCases as! [TabBarItem]
    }
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(allTabs, id:\.self) { tabItem in
                ZStackWithBackground(alignment: .bottom) {
                    ZStackWithBackground(.color(.clear)) {
                        content(tabItem)
                    }
                    .tag(tabItem)
                    .padding(.bottom, tabBarHeight)

                    barContent(tabItem)
                        .alignment(.bottom)
                        .ignoresSafeArea(.keyboard)
                }
            }
        }
        .onReceive(isShowKeyboardPublisher) { isShow in
            tabBarHeight = isShow ? 0 : EasySwiftUI.tabBarHeight
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }
}

#endif