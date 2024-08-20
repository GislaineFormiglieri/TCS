import 'package:flutter/material.dart';
import 'package:invoice/views/home_page.dart';
import 'package:invoice/views/passreset_page';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Perfil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch(index){
      case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfilll'),
      ),
      body: Column(
        children: [
          SizedBox(height: 80), // Espaço para empurrar o conteúdo para baixo
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Usuário',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text('Total Acrescido\nValor'),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text('Total Saída\nValor'),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordResetPage(),
                      ),
                    );
                  },
                  child: Text('Alterar Senha', style: TextStyle(color: Colors.blue),)
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
