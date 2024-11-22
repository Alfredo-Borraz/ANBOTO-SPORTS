import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String title;
  final String? date;
  final String? category;
  final String? description;

  const PostWidget({
    Key? key,
    required this.title,
    this.date,
    this.category,
    this.description,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int _likeCount = 0;

  void _incrementLike() {
    setState(() {
      _likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.grey.shade600,
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  widget.date ?? 'Fecha no disponible',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 7.0),
                if (widget.category != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.category!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.description ?? 'Descripción no disponible',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: _likeCount > 0
                            ? const Color.fromARGB(255, 255, 0, 0)
                            : Colors.grey,
                      ),
                      onPressed: _incrementLike,
                    ),
                    Text(
                      '$_likeCount likes',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
