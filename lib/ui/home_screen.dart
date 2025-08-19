import 'package:flutter/material.dart';
import 'package:new_wild/ui/screens/saved_scenarios/saved_scenarios_screen.dart';
import 'package:new_wild/ui/screens/scenario_generation/platform_selection_screen.dart';

// Главный экран приложения с навигацией между разделами
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Индекс текущего выбранного экрана: 0 - Главная, 1 - Сохраненные
  int _selectedIndex = 0;

  // Контроллер для управления переключением между страницами
  late final PageController _pageController;

  // Список экранов, соответствующих пунктам навигации
  final List<Widget> _screens = [
    const PlatformSelectionScreen(), // Экран выбора платформы
    const SavedScenariosScreen(), // Экран сохраненных сценариев
  ];

  // Обработчик нажатия на пункт навигации
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      // Мгновенный переход к выбранной странице
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    // Инициализация контроллера страниц
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Очистка контроллера при уничтожении виджета
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Используем PageView для переключения между экранами
      body: PageView(
        controller: _pageController,
        // Отключаем возможность пролистывания страниц жестом
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),

      // Нижняя панель навигации
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // Закругление верхних углов
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.0),
            topEnd: Radius.circular(20.0),
          ),
          // Тень для визуального отделения от контента
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        // Обрезка содержимого по закругленным углам
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.0),
            topEnd: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            // Элементы навигационной панели
            items: <BottomNavigationBarItem>[
              _buildNavigationBarItem(Icons.home, 'Home', 0),
              _buildNavigationBarItem(Icons.bookmark, 'Saved', 1),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[600], // Цвет активного элемента
            unselectedItemColor: Colors.grey[400], // Цвет неактивных элементов
            iconSize: 28, // Размер иконок
            showUnselectedLabels:
                false, // Скрывать подписи неактивных элементов
            type: BottomNavigationBarType.fixed, // Фиксированное расположение
            onTap: _onItemTap, // Обработчик нажатий
          ),
        ),
      ),
    );
  }

  // Вспомогательный метод для создания элементов навигации с анимацией
  BottomNavigationBarItem _buildNavigationBarItem(
      IconData icon, String label, int index) {
    bool isSelected = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder(
        // Анимация изменения масштаба: 1.0 для неактивных, 1.2 для активных
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        duration: Duration(milliseconds: 300), // Длительность анимации
        builder: (context, scale, child) => Transform.scale(
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
