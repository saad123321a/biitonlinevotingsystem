//
//  AddCandidates.swift
//  Biit_Voting_App
//
//  Created by Macboook on 23/02/2024.
//

import SwiftUI

struct AddCandidates: View {
    @State private var votingTitle = ""
    @State private var candidates: [String] = [""]

    var body: some View {
        NavigationView {
            VStack {
                // Candidates
//                VStack {
//                    LabelText(label: "Candidates")
//                    TextField("Enter candidate names ", text: $candidates[0])
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                }
               
                List {
                    ForEach(candidates.indices, id: \.self) { index in
                        TextField("Candidate \(index + 1)", text: Binding(
                            get: { self.candidates[index] },
                            set: { self.candidates[index] = $0 }
                        ))
                    }
                    .onDelete(perform: deleteCandidate)
                }

                Button(action: {
                    self.addCandidate()
                }) {
                    Text("Add Candidate")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.ButtonColor)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationBarTitle("Add Candidates", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Action to be performed when Done button is tapped (e.g., dismissing keyboard)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
             
            })
        }
    }

    func addCandidate() {
        candidates.append("")
    }

    func deleteCandidate(at offsets: IndexSet) {
        candidates.remove(atOffsets: offsets)
    }
}

struct AddCandidates_Previews: PreviewProvider {
    static var previews: some View {
        AddCandidates()
    }
}
