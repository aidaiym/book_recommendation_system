import 'package:book_recommendation_system/files.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBookScreen extends StatefulWidget {
  static const String id = 'add_book';

  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _genreController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _publishedYearController = TextEditingController();

  // File? _imageFile;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _imageFile = File(pickedFile.path);
  //     }
  //   });
  // }

  // Future uploadImage(File imageFile) async {
  //   try {
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference ref = storage.ref().child('images/$fileName');
  //     UploadTask uploadTask = ref.putFile(imageFile);
  //     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
  //     String imageUrl = await taskSnapshot.ref.getDownloadURL();
  //     return imageUrl;
  //   } on FirebaseException catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     getImage();
                //   },
                //   child: _imageFile != null
                //       ? Image.file(_imageFile!)
                //       : const Icon(
                //           Icons.add_a_photo,
                //           size: 100,
                //         ),
                // ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an author';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _publisherController,
                  decoration: const InputDecoration(labelText: 'Publisher'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _genreController,
                  decoration: const InputDecoration(labelText: 'Genre'),
                ),
                TextFormField(
                  controller: _pageCountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(labelText: 'Page Count'),
                ),
                TextFormField(
                  controller: _publishedYearController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration:
                      const InputDecoration(labelText: 'Published Year'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // String imageUrl = await uploadImage(_imageFile!);
                      String title = _titleController.text.trim();
                      String author = _authorController.text.trim();
                      String publisher = _publisherController.text.trim();
                      String description = _descriptionController.text.trim();
                      String genre = _genreController.text.trim();
                      int pageCount =
                          int.parse(_pageCountController.text.trim());
                      int publishedYear =
                          int.parse(_publishedYearController.text.trim());
                      Map<String, dynamic> book = {
                        'title': title,
                        'author': author,
                        'publisher': publisher,
                        'description': description,
                        // 'imageUrl': imageUrl,
                        'genre': genre,
                        'pageCount': pageCount,
                        'publishedYear': publishedYear,
                      };
                      FirebaseFirestore.instance.collection('books').add(book);
                      _titleController.clear();
                      _authorController.clear();
                      _publisherController.clear();
                      _descriptionController.clear();
                      _genreController.clear();
                      _pageCountController.clear();
                      _publishedYearController.clear();
                      // setState(() {
                      //   _imageFile = null!;
                      // });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Book added successfully'),
                        duration: Duration(seconds: 3),
                      ));
                      Navigator.pushNamed(context, AdminDash.id);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
