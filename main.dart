
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';




void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portail Ciel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignInPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Logo(),
            _FormContent(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Portail Ciel",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) => _validateField(value, 'Email'),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) => _validateField(value, 'Password'),
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) => setState(() => _rememberMe = value ?? false),
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () => _handleSignIn(),
                
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Sign in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  

                  
                  ),

                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    if (fieldName == 'Email' && value != 'Damas') {
      return 'Please enter a valid email';
    }

    if (fieldName == 'Password' && value != '12345678') {
      return 'Password must be at least 6 characters';
    }

    return null;

  }

  Widget _gap() => const SizedBox(height: 16);

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage())
      );
    }
  }


}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchText = ""; // Nouveau champ pour stocker le texte de recherche

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                // Mettez ici la logique pour naviguer vers la page d'accueil
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Favoris'),
              onTap: () {
                // Mettez ici la logique pour naviguer vers la page des favoris
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const SettingsPage1()
                    )
                    );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildDynamicContent(),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.settings),
          
        ],
      ),
    );
  }

  Widget _buildDynamicContent() {
    // Utilisez _searchText pour filtrer ou charger dynamiquement votre contenu.
    // Ici, nous affichons simplement le texte de recherche à titre d'exemple.
    return Center(
      child: Text(
        'Contenu dynamique pour : $_searchText',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}



class SettingsPage1 extends StatelessWidget {
  const SettingsPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 194, 33, 243),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  const _CustomListTile(
                      title: "About Phone",
                      icon: CupertinoIcons.device_phone_portrait),
                      
                  _CustomListTile(
                      title: "Dark Mode",
                      icon: CupertinoIcons.moon,
                      trailing:
                          CupertinoSwitch(value: false, onChanged: (value) {})),
                  const _CustomListTile(
                      title: "System Apps Updater",
                      icon: CupertinoIcons.cloud_download),
                  const _CustomListTile(
                      title: "Security Status",
                      icon: CupertinoIcons.lock_shield),
                ],
              ),
              _SingleSection(
                title: "Network",
                children: [
                  const _CustomListTile(
                      title: "SIM Cards and Networks",
                      icon: Icons.sd_card_outlined),
                  _CustomListTile(
                    title: "Wi-Fi",
                    icon: CupertinoIcons.wifi,
                    trailing: CupertinoSwitch(value: true, onChanged: (val) {}),
                  ),
                  _CustomListTile(
                    title: "Bluetooth",
                    icon: CupertinoIcons.bluetooth,
                    trailing:
                        CupertinoSwitch(value: false, onChanged: (val) {}),
                  ),
                  const _CustomListTile(
                    title: "VPN",
                    icon: CupertinoIcons.desktopcomputer,
                  )
                ],
              ),
              const _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                      title: "Multiple Users", icon: CupertinoIcons.person_2),
                  _CustomListTile(
                      title: "Lock Screen", icon: CupertinoIcons.lock),
                  _CustomListTile(
                      title: "Display", icon: CupertinoIcons.brightness),
                  _CustomListTile(
                      title: "Sound and Vibration",
                      icon: CupertinoIcons.speaker_2),
                  _CustomListTile(
                      title: "Themes", icon: CupertinoIcons.paintbrush)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}







class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 255, 251, 251),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
