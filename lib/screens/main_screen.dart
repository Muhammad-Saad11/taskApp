import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Data model for activities
class Activity {
  final String id;
  final String time;
  final String duration;
  final String title;
  final String location;
  final double price;
  final int spotsLeft;
  final String difficulty;
  final bool hasChildcare;
  final List<String> categories;

  Activity({
    required this.id,
    required this.time,
    required this.duration,
    required this.title,
    required this.location,
    required this.price,
    required this.spotsLeft,
    required this.difficulty,
    required this.hasChildcare,
    required this.categories,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String selectedCategory = 'All';
  bool isJoining = false;

  // Sample activity data
  final List<Activity> allActivities = [
    Activity(
      id: '1',
      time: '08:00',
      duration: '60 min',
      title: 'Beach Yoga',
      location: 'La Playa de la Rada',
      price: 9.0,
      spotsLeft: 8,
      difficulty: 'light',
      hasChildcare: false,
      categories: ['Sports'],
    ),
    Activity(
      id: '2',
      time: '09:00',
      duration: '60 min',
      title: 'Reformer Pilates',
      location: 'Wellness Studio',
      price: 15.0,
      spotsLeft: 3,
      difficulty: 'medium',
      hasChildcare: true,
      categories: ['Sports'],
    ),
    Activity(
      id: '3',
      time: '12:30',
      duration: '45 min',
      title: '5-a-side Football',
      location: 'Municipal Sports Center',
      price: 19.0,
      spotsLeft: 0,
      difficulty: 'high',
      hasChildcare: true,
      categories: ['Sports'],
    ),
    Activity(
      id: '4',
      time: '14:00',
      duration: '90 min',
      title: 'Cooking Workshop',
      location: 'Culinary Institute',
      price: 25.0,
      spotsLeft: 5,
      difficulty: 'medium',
      hasChildcare: false,
      categories: ['Food'],
    ),
    Activity(
      id: '5',
      time: '15:30',
      duration: '60 min',
      title: 'Kids Art Class',
      location: 'Creative Space',
      price: 12.0,
      spotsLeft: 6,
      difficulty: 'light',
      hasChildcare: true,
      categories: ['Kids', 'Creative'],
    ),
    Activity(
      id: '6',
      time: '17:00',
      duration: '120 min',
      title: 'Pottery Workshop',
      location: 'Arts Center',
      price: 30.0,
      spotsLeft: 4,
      difficulty: 'medium',
      hasChildcare: false,
      categories: ['Creative'],
    ),
  ];

  List<Activity> filteredActivities = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    filteredActivities = List.from(allActivities);
    _controller.forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void filterActivities(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredActivities = List.from(allActivities);
      } else {
        filteredActivities = allActivities
            .where((activity) => activity.categories.contains(category))
            .toList();
      }
      _controller.reset();
      _controller.forward();
    });
  }

  Future<void> joinActivity(Activity activity) async {
    if (activity.spotsLeft == 0) return;

    setState(() {
      isJoining = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success!'),
        content: Text('You have successfully joined ${activity.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );

    setState(() {
      isJoining = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            iconSize: 24,
            icon: Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/img_1.png'),
              backgroundColor: Colors.grey[200],
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thurs, Jan 24',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14)),
              Text('This week in Estepona',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Add this after the AppBar and before the Category Tabs in the body Column:

          // Points/Goals Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You're close to your goal!",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text("Join more sport activities to collect more points",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600])),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: Size(80, 32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                              ),
                              child: Text('Join now',
                                  style: TextStyle(fontSize: 13,color: Colors.white)),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: Size(80, 32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                              ),
                              child: Text('My points',
                                  style: TextStyle(fontSize: 13,color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
      Container(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            // Progress Indicator
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: 0.27, // 27%
                backgroundColor: Colors.blue[200]!.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[200]!),
                strokeWidth: 3,
              ),
            ),
            // Centered Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '27',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'points',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),                ],
              ),
            ),
          ),

          // Search Bar (which was already there but let's make it match the design better)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What do you feel like doing?',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon:
                Icon(Icons.search, color: Colors.grey[400], size: 20),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
          // Category Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                _buildCategoryIcon(Icons.restaurant_menu, selectedCategory == 'All'),
                SizedBox(width: 12),
                _buildFilterChip('All'),
                _buildFilterChip('Sports'),
                _buildFilterChip('Food'),
                _buildFilterChip('Kids'),
                _buildFilterChip('Creative'),
              ],
            ),
          ),

          // Today Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.wb_sunny_outlined, size: 20, color: Colors.amber),
                SizedBox(width: 8),
                Text('Today',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(' / Thursday',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),

          // Activity List
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: ListView.builder(
                key: ValueKey<String>(selectedCategory),
                padding: EdgeInsets.all(16),
                itemCount: filteredActivities.length,
                itemBuilder: (context, index) {
                  final activity = filteredActivities[index];
                  return _buildActivityCard(activity);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.blue),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final isSelected = selectedCategory == category;
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 13,
          ),
        ),
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.purple[300],
        onSelected: (bool selected) {
          filterActivities(category);
        },
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple[100] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon,
          size: 20, color: isSelected ? Colors.purple : Colors.grey[600]),
    );
  }

  Widget _buildActivityCard(Activity activity) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      )),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${activity.time} (${activity.duration})',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                Text('${activity.price.toStringAsFixed(0)}€',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 8),
            Text(activity.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 16, color: Colors.grey[400]),
                SizedBox(width: 4),
                Text(activity.location,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.star_border,
                          size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('${activity.spotsLeft} spots left',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[600])),
                      SizedBox(width: 8),
                      _buildDifficultyTag(activity.difficulty),
                      if (activity.hasChildcare) ...[
                        SizedBox(width: 8),
                        _buildChildcareTag(),
                      ],
                    ],
                  ),
                ),
                if (activity.spotsLeft > 0)
                  ElevatedButton(
                    onPressed: isJoining
                        ? null
                        : () => joinActivity(activity),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(60, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isJoining
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Text('Join', style: TextStyle(fontSize: 13,color: Colors.white)),
                  )
                else
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Sold out',
                      style:
                      TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyTag(String difficulty) {
    Color backgroundColor;
    Color textColor;
    switch (difficulty) {
      case 'light':
        backgroundColor = Colors.blue[50]!;
        textColor = Colors.blue[400]!;
        break;
      case 'medium':
        backgroundColor = Colors.purple[50]!;
        textColor = Colors.purple[400]!;
        break;
      default:
        backgroundColor = Colors.orange[50]!;
        textColor = Colors.orange[400]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
    );
  }

  Widget _buildChildcareTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'childcare',
        style: TextStyle(fontSize: 12, color: Colors.green[400]),
      ),
    );
  }
}