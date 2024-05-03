import SwiftUI

struct Filteration: View {
    @State private var startTime = Date()
    @State private var endTime = Date()
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet: Bool = false

    var body: some View {
        ZStack {
            
            NavigationStack {
                ScrollView {
                    
                    Spacer().frame(height: 130)
                    LabelText1(label: "Set Date and Time")
                        .padding(.top, 20)
                    VStack(spacing: 20) {
                        
                        
                      
                        
                        LabelDateTimePicker1(label: "Start", date: $startTime)
                        
                        LabelDateTimePicker1(label: "End", date: $endTime)
                        
                        Spacer()
                        
                        HStack {
                            backButton
                            
                            Spacer()
                            
                            nextButton
                        }
                        .padding(.horizontal)
                    }
                    .padding(.all, 30)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 2, y: 15)
                    .padding()
                }.background(Color.theme.BackgroundColor)
                .navigationBarTitle("Set Time", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Back")
                .foregroundColor(Color.theme.ButtonColor)
                .font(.system(size: 20, weight: .bold))
                .padding(20)
                .background(Color.white.cornerRadius(10))
        }
        .transition(.slide)
    }
    
    private var nextButton: some View {
        NavigationLink(destination: PopulationSelectionView().navigationBarHidden(true)) {
                              Text("Next")
                .foregroundColor(Color.theme.ButtonColor)
                .font(.system(size: 20, weight: .bold))
                .padding(20)
                .background(Color.white.cornerRadius(10))
        }
        .transition(.slide)
        .sheet(isPresented: $showSheet) {
            PopulationSelectionView()
                .transition(.move(edge: .trailing))
        }
    }
}

struct LabelDateTimePicker1: View {
    var label: String
    @Binding var date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            DatePicker("", selection: $date, displayedComponents: [.hourAndMinute, .date])
                .labelsHidden()
                .datePickerStyle(DefaultDatePickerStyle())
        }
        .padding(.horizontal)
    }
}

struct LabelText1: View {
    var label: String

    var body: some View {
        Text(label)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
}

struct Filteration_Previews: PreviewProvider {
    static var previews: some View {
        Filteration()
    }
}


