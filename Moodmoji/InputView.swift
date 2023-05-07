//
//  InputView.swift
//  Moodmoji
//
//  Created by Antoine Lee on 7/5/23.
//

import SwiftUI

struct InputView: View {
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $inputText)
                .frame(height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 5)
                )
                .font(.system(size: 30))
            
            NavigationLink(destination: OutputView(inputText: $inputText)) {
                Text("Go!")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Input")
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InputView()
        }
    }
}
