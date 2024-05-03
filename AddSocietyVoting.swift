import SwiftUI

struct Panel {
    let id = UUID()
    var candidates: [Candidate] = [Candidate()]
}

struct Candidate: Identifiable {
    let id = UUID()
    var name: String = ""
    var image: UIImage? = nil
    var selectedImage: UIImage? = nil
}

struct AddSocietyVoting: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var showSheet: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var votingTitle = ""
    @State private var panels: [Panel] = [Panel()]
    @State private var selectedIndex = 0
    @State private var panelCount = 1 // Track panel count

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("BIIT Voting System")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack {
                        LabelText(label: "Society Title")
                        TextField("Enter Society title", text: $votingTitle)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                           
                            
                            
                            ForEach(Array(panels.enumerated()), id: \.offset) { index, panel in
                                PanelView(panel: $panels[index], selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker, selectedIndex: $selectedIndex, count: index + 1, deletePanel: deletePanel)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                            
                            Button(action: {
                                self.addPanel()
                            }) {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(systemName: "plus")
                                            .foregroundColor(.red)
                                        Text("Add Panel").foregroundColor(Color.theme.ButtonColor)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    Spacer()
                                }
                            }
                            .padding(.top, 20)
                        }
                        .padding()
                        .navigationBarTitle("Society Voting", displayMode: .inline)
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Color.theme.ButtonColor)
                                .font(.title)
                                .padding(20)
                                .background(Color.white.cornerRadius(10))
                        }
                        .sheet(isPresented: $showSheet) {
                            Filteration()
                        }
                        
                        Button {
                        } label: {
                            Text("Submit")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.ButtonColor)
                        .cornerRadius(8)
                        .sheet(isPresented: $showSheet) {
                            Filteration()
                        }
                    }
                }
                .padding(.horizontal)
            }.background(Color.theme.BackgroundColor)
            
        }
    }
    
    func addPanel() {
        panels.append(Panel())
        panelCount += 1 // Increment panel count
    }
    
    func deletePanel(panel: Panel) {
        if let index = panels.firstIndex(where: { $0.id == panel.id }) {
            panels.remove(at: index)
            panelCount -= 1 // Decrement panel count
        }
    }
}

struct PanelView: View {
    @Binding var panel: Panel
    @Binding var selectedImage: UIImage?
    @Binding var isShowingImagePicker: Bool
    @Binding var selectedIndex: Int
    var count: Int // Panel number
    var deletePanel: (Panel) -> Void // Delete panel function
    
    var body: some View {
        VStack {
            HStack {
                Text("Panel \(count)")
                    .font(.headline)
                Spacer()
                Button(action: {
                    deletePanel(panel)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            ForEach(panel.candidates.indices, id: \.self) { candidateIndex in
                CandidateRow(candidate: $panel.candidates[candidateIndex],  isShowingImagePicker: $isShowingImagePicker, selectedIndex: $selectedIndex, index: candidateIndex, panel: $panel)
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
            }
        }
    }
    
    func addCandidate() {
        panel.candidates.append(Candidate())
    }
}


struct CandidateRow: View {
    @Binding var candidate: Candidate
    @Binding var isShowingImagePicker: Bool
    @Binding var selectedIndex: Int
    let index: Int
    @Binding var panel: Panel
    @State private var designation: String = ""
    
    var body: some View {
        HStack {
            TextField("Candidate Name", text: $candidate.name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            TextField("Designation", text: $designation)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            if let image = candidate.image ?? candidate.selectedImage {
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
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    MyImagePicker(selectedImage: $candidate.selectedImage)
                }
            }
            
            Button(action: {
                deleteCandidate()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
    
    func deleteCandidate() {
        if let index = panel.candidates.firstIndex(where: { $0.id == candidate.id }) {
            panel.candidates.remove(at: index)
            candidate.selectedImage = nil
        }
    }
}

struct MyImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: MyImagePicker
        
        init(_ parent: MyImagePicker) {
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

struct AddSocietyVoting_Previews: PreviewProvider {
    static var previews: some View {
        AddSocietyVoting()
    }
}
