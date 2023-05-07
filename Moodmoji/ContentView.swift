//
//  ContentView.swift
//  Moodmoji
//
//  Created by Antoine Lee on 7/5/23.
//

import SwiftUI

enum Emoji: String, CaseIterable {
    case 😭,🐶,💀,😡
}

struct ContentView: View {
    @State var selection: Emoji = .🐶
    var body: some View {
        VStack
        {
            Text(selection.rawValue)
                .font(.system(size: 150))
            
            Picker("Select Emoji", selection: $selection)
            {
                ForEach(Emoji.allCases, id: \.self)
                { emoji in
                    Text (emoji.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
        .navigationTitle("Emoji Picker")
        .padding(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
