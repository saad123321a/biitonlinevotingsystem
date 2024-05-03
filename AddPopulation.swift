import SwiftUI

struct PopulationSelectionView: View {
    @State private var selectedDiscipline: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSemester: String?
    @State private var selectedSections: Set<String> = []
    @State private var selectedGender: String?
    @State private var selections: [String] = []
    @State private var showAlert = false
    @State private var showSelectionDisplay = false

    let disciplines = ["Computer Science", "Electrical Engineering", "Mechanical Engineering"]
    let semesters = ["1st Semester", "2nd Semester", "3rd Semester", "4th Semester"]
    let sections = ["A", "B", "C", "D"]
    let genders = ["Male", "Female", "Both"]

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        Spacer().frame(height: 20)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Select Discipline").font(.headline)
                            ForEach(disciplines, id: \.self) { discipline in
                                RadioButtonField(title: discipline, isSelected: selectedDiscipline == discipline) {
                                    selectedDiscipline = discipline
                                    selectedSemester = nil
                                    selectedSections.removeAll()
                                }
                            }
                        }
                        .padding().background(Color.white).cornerRadius(20).shadow(radius: 5).padding()

                        if let selectedDiscipline = selectedDiscipline {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Select Semester").font(.headline)
                                ForEach(semesters, id: \.self) { semester in
                                    RadioButtonField(title: semester, isSelected: selectedSemester == semester) {
                                        selectedSemester = semester
                                        selectedSections.removeAll()
                                    }
                                }
                            }
                            .padding().background(Color.white).cornerRadius(20).shadow(radius: 5).padding()

                            if let selectedSemester = selectedSemester {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Select Section(s)").font(.headline)
                                    ForEach(sections, id: \.self) { section in
                                        CheckboxField(title: section, isSelected: selectedSections.contains(section)) {
                                            if selectedSections.contains(section) {
                                                selectedSections.remove(section)
                                            } else {
                                                selectedSections.insert(section)
                                            }
                                        }
                                    }
                                }
                                .padding().background(Color.white).cornerRadius(20).shadow(radius: 5).padding()
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            Text("Select Gender").font(.headline)
                            ForEach(genders, id: \.self) { gender in
                                RadioButtonField(title: gender, isSelected: selectedGender == gender) {
                                    selectedGender = gender
                                }
                            }
                        }
                        .padding().background(Color.white).cornerRadius(20).shadow(radius: 5).padding()
                    }

                    HStack {
                        Button(action: {
                            addSelection()
                            showAlert = true
                        }) {
                            Text("Add Selection").foregroundColor(.white).padding().background(Color.theme.ButtonColor).cornerRadius(10).shadow(radius: 8)
                        }
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Population Selection Added"), message: Text("Population selection has been added successfully."), dismissButton: .default(Text("OK")))
                        }

                        Button(action: {
                            showSelectionDisplay = true
                        }) {
                            Text("Show Selection").foregroundColor(.white).padding().background(Color.theme.ButtonColor).cornerRadius(10).shadow(radius: 8)
                        }
                        .padding()
                    }
                    NavigationLink(destination: SelectionDisplayView(selections: selections), isActive: $showSelectionDisplay) {
                        EmptyView()
                    }
                }
                
                .navigationBarTitle("Population Selection", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    dismissView()
                }) {
                    Text("Done")
                })
            .padding()
            }.background(Color.theme.BackgroundColor)
        }
    }

    func dismissView() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }

    func addSelection() {
        guard let selectedDiscipline = selectedDiscipline,
              let selectedSemester = selectedSemester,
              let selectedGender = selectedGender else { return }

        var sectionsString = selectedSections.isEmpty ? "" : "(\(selectedSections.joined(separator: ", ")))"
        let newSelection = "\(selectedDiscipline) - \(selectedSemester) \(sectionsString) - Gender: \(selectedGender)"
        selections.append(newSelection)
    }
}

struct RadioButtonField: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle").foregroundColor(isSelected ? .blue : .gray)
                Text(title).foregroundColor(.primary)
            }.padding()
        }
    }
}

struct CheckboxField: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square").foregroundColor(isSelected ? .blue : .gray)
                Text(title).foregroundColor(.primary).padding()
            }
        }
    }
}

struct SelectionDisplayView: View {
    var selections: [String]

    var body: some View {
        ZStack {
            List(selections, id: \.self) { selection in
                Text(selection)
            }.navigationBarTitle("Population Selection")
        }.background(Color.theme.BackgroundColor)
        
    }
}

struct FiltrationScreen: View {
    var body: some View {
        Text("This is the filtration screen")
    }
}

struct PopulationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PopulationSelectionView()
    }
}
