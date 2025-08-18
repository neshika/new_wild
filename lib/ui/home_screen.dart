import 'package:flutter/material.dart';
import 'package:new_wild/ui/screens/saved_scenarios/saved_scenarios_screen.dart';
import 'package:new_wild/ui/screens/scenario_generation/platform_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  //ctrl .
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // создаем переменные
  int _selectedIndex = 0; // 0 = Home, 1 = Saved
  late final PageController _pageController;

  final List<Widget> _screens = [
    const PlatformSelectionScreen(),
    const SavedScenariosScreen(),
  ];

//функция для изменения state
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _screens[_selectedIndex], // показывает экран, который выбрали
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.0),
            topEnd: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 76), // 0.3 * 255 ≈ 76
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.0),
            topEnd: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildNavigationBarItem(Icons.home, 'Home', 0),
              _buildNavigationBarItem(Icons.bookmark, 'Saved', 1),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[600], //цвет выбранного меню
            unselectedItemColor: Colors.grey[400], // цвет невыбранного меню
            iconSize: 28,
            showUnselectedLabels: false,
            type: BottomNavigationBarType
                .fixed, // фиксированный, не будет двигаться
            onTap: _onItemTap,
          ),
        ),
      ),
    );
  }

  //функция для анимации
  BottomNavigationBarItem _buildNavigationBarItem(
      IconData icon, String label, int index) {
    bool isSelected = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        duration: Duration(milliseconds: 300),
        builder: (
          context,
          scale,
          child,
        ) =>
            Transform.scale(
          scale: scale,
          child: Icon(
            icon,
            color: isSelected ? Colors.blue[600] : Colors.grey[400],
          ),
        ),
      ),
      label: label,
    );
  }
}
