//
//  ZStackWithBackground.swift
//  EasySwiftUI
//
//  Created by Yevhenii Korsun on 25.09.2023.
//

import SwiftUI

public struct ZStackWithBackground<Content: View>: View {
    var state: BackgroundState = .color(EasySwiftUI.appBackground)
    var alignment: Alignment = .center
    
    @ViewBuilder let content: () -> Content
    
    public init(
        _ state: BackgroundState = .color(EasySwiftUI.appBackground),
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = state
        self.alignment = alignment
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            BackgroundView(state: state)
            
            content()
        }
        .overlay(alignment: .topLeading) {
#if DEBUG
            if EasySwiftUI.isShowCircleOverZstack {
                Circle()
                    .fill(Color.random)
                    .frame(width: 20, height: 20)
                    .allowsHitTesting(false)
            } else {
                EmptyView()
            }
#else
                EmptyView()
#endif
            }
    }
}

public extension ZStackWithBackground {
    init(
        color: Color,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.state = .color(color)
        self.alignment = alignment
        self.content = content
    }
}
