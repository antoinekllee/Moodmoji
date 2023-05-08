//
//  InputView.swift
//  Moodmoji
//
//  Created by Antoine Lee on 7/5/23.
//

import SwiftUI
import UIKit

struct InputView: View {
	@State private var inputText: String = ""
	
	func pasteFromClipboard() {
		let pasteboard = UIPasteboard.general
		if let text = pasteboard.string {
			inputText = text
		}
	}
	
	var body: some View {
		GeometryReader { geo in
			ZStack {
				Image("Background")
					.resizable()
					.scaledToFill()
					.edgesIgnoringSafeArea(.all)
					.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
					.opacity(0.5)
				
				VStack(spacing: 20) {
					Image("Title")
						.resizable()
						.scaledToFit()
						.frame(width: 200, height: 200, alignment: .center)
						.padding(-10)
					
					ZStack(alignment: .topTrailing) {
						TextEditor(text: $inputText)
							.frame(height: 200)
							.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
							.overlay(
								RoundedRectangle(cornerRadius: 10)
									.stroke(Color.gray.opacity(0.5), lineWidth: 5)
							)
							.font(.system(size: 30))
							.background(Color.white.opacity(1))
							.cornerRadius(10)
						
						Button(action: pasteFromClipboard) {
							Image(systemName: "doc.on.clipboard")
								.resizable()
								.frame(width: 30, height: 30)
								.foregroundColor(.blue)
								.padding(5)
						}
						.padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 8))
					}
					.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
					
					NavigationLink(destination: OutputView(inputText: $inputText)) {
						Text("Go!")
							.font(.custom("AvenirNext-Bold", size: 30))
							.foregroundColor(.white)
							.padding()
							.background(Color.blue)
							.cornerRadius(10)
							.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
					}
				}
				.padding()
			}
		}
	}
}

struct InputView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			InputView()
		}
	}
}
