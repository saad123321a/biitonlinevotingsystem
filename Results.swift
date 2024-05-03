import SwiftUI

struct ResultsView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
//                Text("Results")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.blue)
//                    .padding(.top, 20)

                NavigationLink(destination: VotingEventResult()) {
                    Text("Voting Results")
                        .foregroundColor(.black)  // Set link color to white
                        .font(.headline)
                        .padding(.all) .frame(maxWidth: .infinity)
                       .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1)) // Set stroke color to red
                }

                NavigationLink(destination: SocietyResultsView()) {
                    Text("Society Results")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.all) .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                }

                NavigationLink(destination: SurveyResultsView()) {
                    Text("Survey Results")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.all) .frame(maxWidth: .infinity)
                       .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("Results", displayMode: .inline)
        }
    }
}

struct VotingResultsView: View {
    var body: some View {
        
        Text("Voting Results Content Goes Here")
            .navigationBarTitle("Voting Results", displayMode: .inline)
    }
}

struct SocietyResultsView: View {
    var body: some View {
        Text("Society Results Content Goes Here")
            .navigationBarTitle("Society Results", displayMode: .inline)
    }
}

struct SurveyResultsView: View {
    var body: some View {
        Text("Survey Results Content Goes Here")
            .navigationBarTitle("Survey Results", displayMode: .inline)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
