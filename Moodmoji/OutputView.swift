//
//  OutputView.swift
//  Moodmoji
//
//  Created by Antoine Lee on 7/5/23.
//

import SwiftUI
import OpenAISwift

struct OutputView: View {
	@State var selection: Emoji = .🐶
	@Binding var inputText: String
	
	@State private var isLoading: Bool = false
	@State private var story: String = ""
	
	private func getAPIKey(from plist: String, key: String) -> String? {
		guard let filePath = Bundle.main.path(forResource: plist, ofType: "plist"),
			  let plistContents = NSDictionary(contentsOfFile: filePath),
			  let apiKey = plistContents[key] as? String else {
			return nil
		}
		return apiKey
	}
	
	func generateStory() async {
		isLoading = true
		
		guard let apiKey = getAPIKey(from: "Secrets", key: "OPENAI_KEY") else {
			fatalError("Failed to get API key from Secrets.plist")
		}
		
		let openAI = OpenAISwift(authToken: apiKey)
		
		do {
			let chat: [ChatMessage] = [
				ChatMessage(role: .system, content: "You are a bot that will generate the 10 most relevant emotes to any given text. Your output will be in the format of an emote and the name of the emote separated by a colon. Each of the 10 emotes and text pairs will be separated by new lines. You must ensure to always follow this exact format consistently. "),
				ChatMessage(role: .user, content: "Scrappy, a scruffy street mutt, was taken in by a kind woman named Sarah who gave him a loving home. He grew to love his new family, enjoying walks and cuddles, and though he eventually passed away, he left behind cherished memories with those who knew him."),
				ChatMessage(role: .assistant, content: "🐕:Dog\n❤️:Heart\n👩‍❤️‍👨:Couple With Heart\n🚶‍♂️:Walking Man\n🐾:Paw Prints\n🏡:House\n💖:Sparkling Heart\n🌈:Rainbow\n😢:Cry\n🕊️:Dove"),
				ChatMessage(role: .user, content: "Mary found her ten-year office job unfulfilling, so she switched to a nonprofit helping underprivileged children. Her new work organizing fundraising events and working with donors brought her joy and fulfillment, making her grateful for the chance she took to make a change."),
				ChatMessage(role: .assistant, content: "👩‍💼:Woman Office Worker\n💼:Briefcase\n❤️:Heart\n👨‍👩‍👧‍👦:Family\n🙏:Folded Hands\n🤝:Handshake\n💰:Money Bag\n🎉:Party Popper\n🌟:Glowing Star\n👏:Clapping Hands"),
				ChatMessage(role: .user, content: inputText)
			]

			let result = try await openAI.sendChat(with: chat)
			if let assistantMessage = result.choices?.first?.message.content {
				story = assistantMessage.trimmingCharacters(in: .whitespacesAndNewlines)
			} else {
				story = "No response from the assistant"
			}
		} catch {
			story = "Error generating emotes: \(error.localizedDescription)"
		}
		
		isLoading = false
	}
	
	var body: some View {
		VStack {
			if isLoading {
				ProgressView("Generating story...")
			} else {
				Text("Generated story: \(story)")
					.font(.title2)
					.padding()
			}
		}
		.navigationTitle("Output")
		.padding(50)
		.task {
			await generateStory()
		}
	}
}

struct OutputView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			OutputView(inputText: .constant("Samantha won the lottery and finally got to fulfill her dream of traveling the world. She saw the Eiffel Tower, hiked Machu Picchu, and went on a safari in Africa, realizing that money couldn't buy happiness, but it could provide unforgettable experiences."))
		}
	}
}
