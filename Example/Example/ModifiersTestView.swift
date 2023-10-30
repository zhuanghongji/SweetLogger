//
//  ModifiersTestView.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/30.
//

import SwiftUI
import SweetLogger

struct ModifiersTestView: View {
    var body: some View {
        VStack {
            Text("Modifiers Test View")
            TestLoggerModifiersView1()
            TestLoggerModifiersView2()
        }
    }
}

// MARK: Using logger modifiers

struct TestLoggerModifiersView1: View {
    @State private var visible = true

    var body: some View {
        VStack {
            if visible {
                Image(systemName: "globe")
                    .loggerAppearance(name: "GlobeImage")
            }
            Button {
                visible.toggle()
            } label: {
                Text("Toggle Visibility")
            }
        }
        .padding()
    }
}

struct TestLoggerModifiersView2: View {
    @State private var count = 0

    var countDescription: String {
        "\(count)"
    }

    var body: some View {
        VStack {
            Text(countDescription)
            Button {
                count += 1
            } label: {
                withAnimation {
                    Text("Add Count")
                }
            }
        }
        .padding()
        .loggerChange(of: countDescription, initial: true, name: "countDescription")
        .loggerChange(of: count, initial: true, name: "count")
        .loggerChange(of: count)
    }
}

#Preview {
    ModifiersTestView()
}
