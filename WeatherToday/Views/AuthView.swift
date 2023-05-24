
import SwiftUI
import Firebase

struct AuthView: View {
    @State private var email = ""
    @State private var pass = ""
    @Binding var isLoggedIn: Bool
    @State private var err = false
    @State private var loading = false
    var body: some View {
        NavigationView(){
            ZStack{
                if loading == true{
                    LoadingView()
                }
                else{
                    VStack(spacing: 20){
                        Spacer(minLength: 200)
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .font(.title)
                            .offset(x: -120, y:-40)
                        TextField("", text: $email)
                            .textFieldStyle(.plain)
                            .foregroundColor(.white)
                            .placeholder(when: email.isEmpty) {
                                Text("Email")
                                    .bold()
                            }
                            .offset(x: 20)
                        
                        Rectangle()
                            .frame(height: 1)
                        
                        SecureField("", text: $pass)
                            .textFieldStyle(.plain)
                            .foregroundColor(.white)
                            .placeholder(when: pass.isEmpty) {
                                Text("Password")
                                    .bold()
                            }
                            .offset(x: 20)
                        
                        Rectangle()
                            .frame(height: 1)
                        
                        Spacer()
                        
                        Button {
                            loading = true
                            register()
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                    
                                )
                        }.padding(.top)
                        
                        NavigationLink {
                            LoginView(isLoggedIn: $isLoggedIn)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Already have an account? Login")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        
                    }
                    .alert("Password minimum length is 6 characters", isPresented: $err, actions: {
                        Button("Ok", role: .cancel){}
                    })
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
            }
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
        }
    }
    func register(){
        Auth.auth().createUser(withEmail: email, password: pass){ result, error in
            if error != nil {
                err = true
                loading = false
            }
            else{
                isLoggedIn = true
                loading = false
            }
            
        }
    }
}

//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
