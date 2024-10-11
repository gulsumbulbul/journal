import 'package:flutter/material.dart';
import 'package:journal/add_question_page.dart';
import 'package:journal/const/color.dart';
import 'package:journal/service/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserService uservice = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Gülsüm Bülbül',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'gulsumbulbul@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 100),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Question Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:journal/add_question_page.dart';
// import 'package:journal/const/color.dart';
// import 'package:journal/model/users.dart'; // Kullanıcı modelini ekliyoruz.
// import 'package:journal/service/user_service.dart';

// class ProfilePage extends StatefulWidget {

//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   UserService uservice = UserService();
//   Users? user; // Kullanıcı bilgilerini burada tutacağız.
//   bool isLoading = true; // Yükleme durumunu takip ediyoruz.

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   // Kullanıcı bilgilerini getiren fonksiyon
//   Future<void> fetchUserData() async {
//     try {
//       Users? fetchedUser = await uservice.getUserById();
//       setState(() {
//         user = fetchedUser;
//         isLoading = false; // Yükleme işlemi bitti.
//       });
//     } catch (e) {
//       print("Kullanıcı bilgileri alınırken hata: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator()) // Yükleniyor ekranı
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       user?.username ??
//                           'Kullanıcı adı bulunamadı', // Kullanıcı ismi
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       user?.useremail ??
//                           'E-posta bulunamadı', // Kullanıcı e-postası
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 100),
//                     ListTile(
//                       leading: const Icon(Icons.settings),
//                       title: const Text('Settings'),
//                       onTap: () {},
//                     ),
//                     const Divider(),
//                     ListTile(
//                       leading: const Icon(Icons.edit),
//                       title: const Text('Question Settings'),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => QuestionPage(),
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(),
//                     ListTile(
//                       leading: const Icon(Icons.logout),
//                       title: const Text('Log Out'),
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
