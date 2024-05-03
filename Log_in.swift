import SwiftUI
struct LogIn: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLogged: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let userType: UserType
    
    var body: some View {
        NavigationView {
            
           ScrollView{
               
               Spacer()
                VStack {
                    
                    Spacer().frame(height: 120)
                    
                    // Logo and BIIT Voting System label
                    Image("logo")
                        .clipShape(Circle())
                        .scaleEffect(0.4)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("BIIT Voting System")
                        .font(.headline)
                        .padding(.top, 15)
                    
                    // Sign In label
                    VStack {
                        Text("Sign In")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        // Username text field
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        // Password text field
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                    }
                    .padding(.all, 30)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 2, y: 15)
                    .padding()
                    
                    // Login button
                    Button(action: {
    //                    if userType == .admin {
    //                                AdminPage()
    //                    } else  {
    //                                UserMain()
    //                            }
                        // For demonstration, assume login is successful
                        isLogged = true
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.theme.ButtonColor)
                            .cornerRadius(8)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .background(Color.theme.BackgroundColor)
                .padding()
                .navigationBarHidden(true)
                .onAppear {
                    // Reset fields when the view appears (optional)
                    username = ""
                    password = ""
            }
           }.background(Color.theme.BackgroundColor)
        }
        .fullScreenCover(isPresented: $isLogged, content: {
            switch userType {
            case .admin:
                AdminPage()
            case .voter:
                UserMain() // Use the VoterPage here
            }
        })
    }
}



struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn(userType: .admin)
    }
}



//struct LogIn_Previews: PreviewProvider {
//    static var previews: some View {
//        LogIn()
//    }
//}
