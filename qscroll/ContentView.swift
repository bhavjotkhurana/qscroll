import SwiftUI

struct ContentView: View {
    private let questions: [Question] = [
        Question(
            prompt: "If 3x − 5 = 10, what is x?",
            choices: ["3", "5", "10", "15"],
            correctIndex: 1
        ),
        Question(
            prompt: "What is the area of a circle with radius 4?",
            choices: ["8π", "12π", "16π", "32π"],
            correctIndex: 2
        ),
        Question(
            prompt: "Simplify: 2(3x + 4) − 5x.",
            choices: ["x + 8", "x + 4", "6x + 8", "6x − 1"],
            correctIndex: 0
        ),
        Question(
            prompt: "If 2(x − 3) + 5 = 13, what is x?",
            choices: ["6", "7", "8", "9"],
            correctIndex: 1
        ),
        Question(
            prompt: "What is the area of a triangle with base 10 and height 6?",
            choices: ["30", "40", "60", "80"],
            correctIndex: 0
        ),
        Question(
            prompt: "A jar contains 3 red, 2 blue, and 5 green marbles. If one marble is drawn at random, what is the probability it’s blue?",
            choices: ["1/2", "1/3", "1/5", "1/10"],
            correctIndex: 2
        )
    ]
    
    @State private var currentPage = 0  // binding for paging control

    var body: some View {
        let pages = questions.map { question in
            // Wrap each QuestionCard and provide an onNext closure that increments currentPage.
            QuestionCard(question: question) {
                if currentPage < questions.count - 1 {
                    currentPage += 1
                }
            }
        }
        
        PagingScrollView(pages: pages, currentPage: $currentPage)
            .ignoresSafeArea()
    }
}

struct Question: Identifiable {
    let id = UUID()
    let prompt: String
    let choices: [String]
    let correctIndex: Int
}

struct QuestionCard: View {
    let question: Question
    let onNext: () -> Void

    @State private var selected: Int? = nil
    @State private var checked = false

    var body: some View {
        VStack {                // 1) Outer VStack
            Spacer()           // Push content down

            VStack(spacing: 24) {   // 2) Inner VStack with your existing layout
                Text(question.prompt)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                VStack(spacing: 16) {
                    ForEach(question.choices.indices, id: \.self) { idx in
                        Button {
                            selected = idx
                        } label: {
                            HStack {
                                Text(question.choices[idx])
                                Spacer()
                                if checked {
                                    Image(systemName: idx == question.correctIndex
                                          ? "checkmark.circle"
                                          : (idx == selected ? "xmark.circle" : ""))
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selected == idx ? Color.blue : Color.gray)
                            )
                        }
                        .disabled(checked)
                    }
                }

                Button("Check Answer") {
                    checked = true
                }
                .disabled(selected == nil || checked)

                if checked {
                    Button("Next Question", action: onNext)
                }
            }
            .padding(.horizontal)

            Spacer()           // Push content up from the bottom
        }
        // 3) Make the entire card fill its parent, so spacers have room to work
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
