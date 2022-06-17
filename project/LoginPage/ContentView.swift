import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
        
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            
            DispatchQueue.main.async {
                
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom)
            
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .cornerRadius(35.0)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .cornerRadius(35.0)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 20)
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                    
                    
                }, label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(35.0)
                })
                
                NavigationLink("Create new Account.", destination: SignUpView())
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            .padding()
            
            Spacer()
            
            Text("By Andres Machado.")
            
        }
        .navigationBarTitle("GameReview🎮", displayMode: .inline)
        .padding()
        
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                
                VStack {
                    HomeView()
                    
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.top)
            
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .cornerRadius(35.0)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .cornerRadius(35.0)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 20)
                
                
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                    
                    
                }, label: {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(35.0)
                })
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Account")
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
