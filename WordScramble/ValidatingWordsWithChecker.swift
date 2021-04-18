//
//  ValidatingWordsWithChecker.swift
//  WordScramble
//
//  Created by Pranav Kasetti on 11/04/2021.
//

import SwiftUI

struct ValidatingWordsWithChecker: View {

  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""

  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
          .autocapitalization(.none)

        List(usedWords, id: \.self) {
          Image(systemName: "\($0.count).circle")
          Text($0)
        }
      }
      .onAppear(perform: startGame)
      .alert(isPresented: $showingError) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
      .navigationBarTitle(rootWord)
    }
  }

  func addNewWord() {
    // lowercase and trim the word, to make sure we don't add duplicate words with case differences
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    // exit if the remaining string is empty
    guard !answer.isEmpty else {
      return
    }

    guard isOriginal(word: answer) else {
      wordError(title: "Word used already", message: "Be more original")
      return
    }

    guard isPossible(word: answer) else {
      wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }

    guard isValidWord(word: answer) else {
      wordError(title: "Word not possible", message: "That isn't a real word.")
      return
    }

    usedWords.insert(answer, at: 0)
    newWord = ""
  }

  func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      // 2. Load start.txt into a string
      if let startWords = try? String(contentsOf: startWordsURL) {
        // 3. Split the string up into an array of strings, splitting on line breaks
        let allWords = startWords.components(separatedBy: "\n")

        // 4. Pick one random word, or use "silkworm" as a sensible default
        rootWord = allWords.randomElement() ?? "silkworm"

        // If we are here everything has worked, so we can exit
        return
      }
    }
    // If were are *here* then there was a problem – trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
  }

  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }

  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    return word.allSatisfy({ char in
      if let index = tempWord.firstIndex(of: char) {
        tempWord.remove(at: index)
        return true
      } else {
        return false
      }
    })
  }

  func isValidWord(word: String) -> Bool {

    let rootRange = NSRange.init(location: 0, length: word.utf16.count)

    let range = UITextChecker().rangeOfMisspelledWord(in: word, range: rootRange, startingAt: 0, wrap: false, language: "en")
    return (range.location == NSNotFound)
  }

  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }
}

struct ValidatingWordsWithChecker_Previews: PreviewProvider {
  static var previews: some View {
    ValidatingWordsWithChecker()
  }
}
