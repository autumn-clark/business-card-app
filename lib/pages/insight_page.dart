import 'package:flutter/material.dart';

class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCard(String title, int value, Color statusColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text(value.toString(),
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: statusColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 5,
              children: [
                ElevatedButton(onPressed: (){},
                    child: Text("Өнөөдөр")),
                ElevatedButton(onPressed: (){},
                    child: Text("Энэ долоо хоног")),
                ElevatedButton(onPressed: (){},
                    child: Text("Энэ сар"))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  _buildCard('Миний нэрийн хуудсыг үзсэн', 0, Colors.green),
                  _buildCard(
                      'Миний нэрийн хуудсыг хуваалцсан', 0, Colors.green),
                  _buildCard('Миний нэрийн хуудсыг хадгалсан', 0, Colors.green),
                  _buildCard('Шинээр холбогдсон', 0, Colors.red),
                  SizedBox(height: 16),
                  Text('Дэлгэрэнгүй',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 30, backgroundColor: Colors.grey[300]),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ариунаа',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text('Ариунаа таны мэдээллийг харсан байна'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text('Харах')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
