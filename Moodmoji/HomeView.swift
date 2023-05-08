//
//  HomeView.swift
//  Moodmoji
//
//  Created by Antoine Lee on 7/5/23.
//

import SwiftUI

struct HomeView: View {
	var body: some View {
		GeometryReader { geo in
			NavigationView {
				ZStack {
					Image("Background")
						.resizable()
						.scaledToFill()
						.edgesIgnoringSafeArea(.all)
						.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
						.opacity(0.5)
					
					VStack {
						Image("Title")
							.resizable()
							.scaledToFit()
							.frame(width: 250, height: 300, alignment: .center)
						
						NavigationLink(destination: InputView()) {
							Text("Start")
								.font(.custom("AvenirNext-Bold", size: 30))
								.foregroundColor(.white)
								.padding()
								.background(Color.blue)
								.cornerRadius(10)
								.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
								.padding(40)
						}
					}
				}
			}
			.frame(width: geo.size.width, height: geo.size.height)
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}

