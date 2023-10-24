//
//  ContentView.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            SweetLogger.test()
        }
    }
}

#Preview {
    ContentView()
}
