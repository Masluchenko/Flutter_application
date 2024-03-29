import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  String name;
  int age;
  String gender;
  int course;
  String group;

  Student({
    required this.name,
    required this.age,
    required this.gender,
    required this.course,
    required this.group,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Студенты',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      ),
      home: const LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Главная'),
        ),
        body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Студент ${index + 1}'),
                    const SizedBox(height: 8.0),
                    Text('ФИО: ${students[index].name}'),
                    Text('Возраст: ${students[index].age}'),
                    Text('Пол: ${students[index].gender}'),
                    Text('Курс: ${students[index].course}'),
                    Text('Группа: ${students[index].group}'),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showEditStudentDialog(context, index);
                          },
                          child: const Text('Изменить'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              students.removeAt(index);
                            });
                          },
                          child: const Text('Удалить'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showAddStudentDialog(context);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

void _showAddStudentDialog(BuildContext context) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController groupController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить студента'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'ФИО'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Возраст'),
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Пол'),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Курс'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Группа'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  ageController.text.isNotEmpty &&
                  int.tryParse(ageController.text) != null &&
                  genderController.text.isNotEmpty &&
                  courseController.text.isNotEmpty &&
                  int.tryParse(courseController.text) != null &&
                  groupController.text.isNotEmpty) {
                setState(() {
                  students.add(Student(
                    name: nameController.text,
                    age: int.tryParse(ageController.text) ?? 0,
                    gender: genderController.text,
                    course: int.tryParse(courseController.text) ?? 0,
                    group: groupController.text,
                  ));
                });
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Ошибка'),
                      content: const Text('Пожалуйста, заполните все поля формы и введите корректные значения.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      );
    },
  );
}

void _showEditStudentDialog(BuildContext context, int index) async {
  final TextEditingController nameController = TextEditingController(text: students[index].name);
  final TextEditingController ageController = TextEditingController(text: students[index].age.toString());
  final TextEditingController genderController = TextEditingController(text: students[index].gender);
  final TextEditingController courseController = TextEditingController(text: students[index].course.toString());
  final TextEditingController groupController = TextEditingController(text: students[index].group);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Изменить данные студента'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'ФИО'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Возраст'),
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Пол'),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Курс'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Группа'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  ageController.text.isNotEmpty &&
                  int.tryParse(ageController.text) != null &&
                  genderController.text.isNotEmpty &&
                  courseController.text.isNotEmpty &&
                  int.tryParse(courseController.text) != null &&
                  groupController.text.isNotEmpty) {
                setState(() {
                  students[index].name = nameController.text;
                  students[index].age = int.tryParse(ageController.text) ?? students[index].age;
                  students[index].gender = genderController.text;
                  students[index].course = int.tryParse(courseController.text) ?? students[index].course;
                  students[index].group = groupController.text;
                });
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Ошибка'),
                      content: const Text('Пожалуйста, заполните все поля формы и введите корректные значения.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      );
    },
  );
}
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Логин'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите имя пользователя';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Пароль'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите пароль';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = _usernameController.text;
                String password = _passwordController.text;
                print('Вход выполнен: Имя пользователя: $username, Пароль: $password');

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            child: const Text('Вход'),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
              ).then((value) {
                if (value != null && value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Успешная регистрация'),
                        content: const Text('Вы успешно зарегестрировались.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            child: const Text('Регистрация'),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Имя пользователя'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите имя пользователя';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Пароль'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите пароль';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = _usernameController.text;
                String password = _passwordController.text;
                print('Регистрация: Имя пользователя: $username, Пароль: $password');

                Navigator.pop(context, true);
              }
            },
            child: const Text('Регистрация'),
          ),
        ],
      ),
    );
  }
}

