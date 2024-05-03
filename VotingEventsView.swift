import SwiftUI

struct AddVotingView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State var showSheet:Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var votingTitle = ""
    @State private var candidates: [String] = [""]
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var selectedDiscipline: Set<String> = []
    @State private var selectedSemester: Set<String> = []
    @State private var selectedSection: Set<String> = []
    let disciplines = ["Computer Science", "Electrical Engineering", "Mechanical Engineering", "Electrical Engineering"]
    let semesters = ["1st Semester", "2nd Semester", "3rd Semester", "4th Semester"]
    let sections = ["A", "B", "C"]
    @State private var selectedImages: [UIImage?] = [nil]
    @State private var selectedIndex = 0

    
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                   // Spacer().frame(height: 80)
                    Text("BIIT Voting System")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack {
                        LabelText(label: "Voting Title")
                        TextField("Enter voting title", text: $votingTitle)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    VStack (){
                        ForEach(candidates.indices, id: \.self) { index in
                            HStack {
                                TextField("Candidate \(index + 1)", text: Binding(
                                    get: { self.candidates[index] },
                                    set: { self.candidates[index] = $0 }
                                ))
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                if let image = selectedImages[index] {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } else {
                                    
                                    Button {
                                        self.isShowingImagePicker = true
                                        self.selectedIndex = index
                                    } label: {
                                        Image(systemName: "photo")
                                    }.sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                                        ImagePicker(selectedImage: self.$selectedImages[self.selectedIndex])
                                    }
                                }
                                
                                
                                
                                
                                Button(action: {
                                    self.deleteCandidate(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Button(action: {
                            self.addCandidate()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.theme.ButtonColor)
                                Text("Add Candidate")
                                    .foregroundColor(Color.theme.ButtonColor)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        }
                        .padding(.top, 20)
                        
                        
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
//                    Rectangle().frame(height: 300).foregroundColor(Color.gray.opacity(0.3))
                    HStack(){
                        Spacer()
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")    .foregroundColor(Color.theme.ButtonColor)
                                .font(.title).padding(20)
                                .background(Color.white.opacity(0.1).cornerRadius(10))
                        }.sheet(isPresented: $showSheet) {
                            
                            Filteration()
                        }
                        

                    }
                   
                }
                .padding()
                .navigationBarTitle("Add Candidate",displayMode: .inline)
                
               
            }.background(Color.theme.BackgroundColor.ignoresSafeArea(.all))
            Button {
                
            } label: {
                Text("Submit")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.theme.ButtonColor)
            .cornerRadius(10)
            .shadow(radius: 8)
            
            .sheet(isPresented: $showSheet) {
                
                Filteration()
            }
        }
    }
    func loadImage() {
        guard let inputImage = selectedImage else { return }
        // Perform any additional processing on the image if needed
    }
    func addCandidate() {
        candidates.append("")
        selectedImages.append(nil)
    }

    func deleteCandidate(at index: Int) {
        candidates.remove(at: index)
        selectedImages.remove(at: index)
    }
}

struct LabelText: View {
    var label: String

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .padding(.top, 10)
            Spacer()
        }
    }
}
struct HalfSheetView: View {
    @Binding var isSheetPresented: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                VStack {
                    Text("Half Sheet")
                        .font(.title)
                        .padding()

                    Button("Dismiss") {
                        isSheetPresented.toggle()
                    }
                    .padding()
                }
                .frame(height: geometry.size.height / 2)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LabelDateTimePicker: View {
    var label: String
    @Binding var date: Date

    var body: some View {
        VStack {
            LabelText(label: label)
            DatePicker("", selection: $date)
                .labelsHidden()
                .datePickerStyle(DefaultDatePickerStyle())
        }
    }
}

struct DropdownWithCheckboxes: View {
    var label: String
    var options: [String]
    @Binding var selectedOptions: Set<String>
    @State private var isExpanded: Bool = false

    var body: some View {
        DisclosureGroup(label, isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Toggle(isOn: Binding(
                        get: { selectedOptions.contains(option) },
                        set: { isSelected in
                            if isSelected {
                                selectedOptions.insert(option)
                            } else {
                                selectedOptions.remove(option)
                            }
                        }
                    )) {
                        Text(option)
                            .foregroundColor(Color.primary)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .contentShape(Rectangle()) // Add this line to make the entire row tappable
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            .contentShape(Rectangle()) // Add this line to make the entire dropdown tappable
        }
        .padding(.bottom, 8)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(configuration.isOn ? .blue : .gray)
            }

            configuration.label
        }
        .padding(5)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}

struct AddVotingView_Previews: PreviewProvider {
    static var previews: some View {
        AddVotingView()
    }
}
