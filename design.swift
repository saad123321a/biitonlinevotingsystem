import SwiftUI
//import FirebaseAuth

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: RegistrationView()) {
                    Text("Register")
                }
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                }
            }
        }
    }
}

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Register") {
                register(email: email, password: password)
            }
        }
        .padding()
    }

    func register(email: String, password: String) {
        // Implement Firebase registration logic
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Login") {
                login(email: email, password: password)
            }
        }
        .padding()
    }

    func login(email: String, password: String) {
        // Implement Firebase login logic
    }
}
