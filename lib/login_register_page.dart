import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/const/color.dart';
import 'package:journal/main_page.dart';
import 'package:journal/service/auth.dart';
import 'package:journal/service/user_service.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isLogin = true;
  String? errorMessage;

  Future<void> createUser() async {
    try {
      // Firebase'de kullanıcı oluşturma
      await Auth().createUser(
          email: emailController.text, password: passwordController.text);

      // Firebase kimlik doğrulamasından sonra kullanıcıyı veritabanına ekle
      await UserService().createUsers(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      print("Kullanıcı başarıyla kaydedildi ve veritabanına eklendi!");
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signIn() async {
    try {
      await Auth().signIn(
          email: emailController.text, password: passwordController.text);

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => JournalScreen(),
          ),
        );
      }
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.silver,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isLogin ? "Welcome Back!" : "Create Account",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                if (!isLogin)
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                errorMessage != null
                    ? Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (isLogin) {
                      signIn();
                    } else {
                      createUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isLogin ? "Login" : "Register",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin
                        ? "Don't have an account yet? Sign up here!"
                        : "Already have an account? Log in here!",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:journal/const/color.dart';
// import 'package:journal/main_page.dart';
// import 'package:journal/service/auth.dart';
// import 'package:journal/user_service.dart';

// class LoginRegisterPage extends StatefulWidget {
//   const LoginRegisterPage({super.key});

//   @override
//   State<LoginRegisterPage> createState() => _LoginRegisterPageState();
// }

// class _LoginRegisterPageState extends State<LoginRegisterPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool isLogin = true;
//   String? errorMessage;

// Future<void> createUser() async {
//   try {
//     // Firebase'de kullanıcı oluşturma
//     await Auth().createUser(
//         email: emailController.text, password: passwordController.text);

//     // Firebase kimlik doğrulamasından sonra kullanıcıyı veritabanına ekle
//     await UserService().createUsers(
//       "username", // Burada kullanıcı adını da almanız gerekecek
//       emailController.text,
//       passwordController.text,
//     );

//     print("Kullanıcı başarıyla kaydedildi ve veritabanına eklendi!");

//     // Kayıt sonrası kullanıcıyı JournalScreen'e yönlendir
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => JournalScreen(),
//       ),
//     );
//   } on FirebaseException catch (e) {
//     setState(() {
//       errorMessage = e.message;
//     });
//   }
// }

//   // Future<void> createUser() async {
//   //   try {
//   //     await Auth().createUser(
//   //         email: emailController.text, password: passwordController.text);
//   //   } on FirebaseException catch (e) {
//   //     setState(() {
//   //       errorMessage = e.message;
//   //     });
//   //   }
//   // }

//   Future<void> signIn() async {
//     try {
//       await Auth().signIn(
//           email: emailController.text, password: passwordController.text);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => JournalScreen(),
//         ),
//       );
//     } on FirebaseException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Password TextField
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Hata Mesajı
//                 errorMessage != null
//                     ? Text(
//                         errorMessage!,
//                         style: const TextStyle(color: Colors.red),
//                       )
//                     : const SizedBox.shrink(),
//                 const SizedBox(height: 20),
//                 // Login/Register Butonu
//                 ElevatedButton(
//                   onPressed: () {
//                     if (isLogin) {
//                       signIn();
//                     } else {
//                       createUser();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     isLogin ? "Login" : "Register",
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Register/Login
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isLogin = !isLogin;
//                     });
//                   },
//                   child: Text(
//                     isLogin
//                         ? "Don't have an account yet? Sign up here!"
//                         : "Already have an account? Log in here!",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.blueAccent,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:journal/main_page.dart';
// // import 'package:journal/service/auth.dart';

// // class LoginRegisterPage extends StatefulWidget {
// //   const LoginRegisterPage({super.key});

// //   @override
// //   State<LoginRegisterPage> createState() => _LoginRegisterPageState();
// // }

// // class _LoginRegisterPageState extends State<LoginRegisterPage> {
// //   final TextEditingController emailController = TextEditingController();

// //   final TextEditingController passwordController = TextEditingController();

// //   bool isLogin = true;
// //   String? errorMessage;

// //   Future<void> createUser() async {
// //     try {
// //       await Auth().createUser(
// //           email: emailController.text, password: passwordController.text);
// //     } on FirebaseException catch (e) {
// //       setState(() {
// //         errorMessage = e.message;
// //         print(errorMessage);
// //       });
// //     }
// //   }

// //   Future<void> signIn() async {
// //     try {
// //       await Auth().signIn(
// //           email: emailController.text, password: passwordController.text);

// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => JournalScreen(),
// //         ),
// //       );
// //     } on FirebaseException catch (e) {
// //       setState(() {
// //         errorMessage = e.message;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Padding(
// //       padding: EdgeInsets.symmetric(horizontal: 20),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           TextField(
// //             controller: emailController,
// //             decoration: const InputDecoration(
// //                 hintText: "Email", border: OutlineInputBorder()),
// //           ),
// //           TextField(
// //             controller: passwordController,
// //             obscureText: true,
// //             decoration: const InputDecoration(
// //                 hintText: "Password", border: OutlineInputBorder()),
// //           ),
// //           errorMessage != null ? Text(errorMessage!) : const SizedBox.shrink(),
// //           ElevatedButton(
// //               onPressed: () {
// //                 if (isLogin) {
// //                   signIn();
// //                 } else {
// //                   createUser();
// //                 }
// //               },
// //               child: isLogin ? const Text("Login") : const Text("Register")),
// //           GestureDetector(
// //             onTap: () {
// //               setState(() {
// //                 isLogin = !isLogin;
// //               });
// //             },
// //             child: Text("Don't have an account yet? Click here!"),
// //           )
// //         ],
// //       ),
// //     ));
// //   }
// // }
