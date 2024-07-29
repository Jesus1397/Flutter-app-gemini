import 'package:chat_gemini/models/message_model.dart';
import 'package:chat_gemini/providers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;

  callGeminiModel() async {
    try {
      if (_controller.text.isNotEmpty) {
        setState(() {
          _messages.add(Message(text: _controller.text, isUser: true));
          _isLoading = true;
        });
      }

      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _controller.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
        _isLoading = false;
      });

      _controller.clear();
    } catch (e) {
      print("Error : $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/gpt-robot.png', height: 40),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gemini Bot',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: const Color(0xff3369FF)),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.circle, color: Colors.green, size: 10),
                            SizedBox(width: 5),
                            Text(
                              'Online',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: (currentTheme == ThemeMode.dark)
                  ? Icon(
                      Icons.light_mode,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : Icon(
                      Icons.dark_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              onTap: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!message.isUser)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/gpt-robot.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      Expanded(
                        child: Align(
                          alignment: message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: message.isUser
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                            ),
                            child: Text(
                              message.text,
                              style: message.isUser
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)
                                  : Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 32, top: 16.0, left: 16.0, right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB8B8B8).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: const Color(0xff3369FF)),
                      decoration: InputDecoration(
                        hintText: 'Write your message',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.grey),
                    onPressed: () {},
                  ),
                  _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: callGeminiModel,
                            child: Image.asset('assets/send.png'),
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
